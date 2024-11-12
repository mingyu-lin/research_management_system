package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.Message;
import xxxx.entity.Paper;
import xxxx.entity.value.MessageModel;
import xxxx.service.SendMessageService;
import xxxx.service.UserService;
import xxxx.service.getOnePaperService;
import xxxx.service.paperReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/paperReview")
public class PaperReviewServlet extends HttpServlet {
    private paperReviewService paperReview=new paperReviewService();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置响应类型
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        MessageModel messageModel = new MessageModel();
        String adminname = req.getSession().getAttribute("username").toString();
        // 获取参数
        String spaperId = req.getParameter("paperId");
        String action = req.getParameter("action");
        String sadminId = req.getParameter("adminId");
        System.out.println(spaperId);
        System.out.println(action);
        int adminId = 0;
        int paperId = 0;

        // 检查参数是否为空或 "null"
        if (sadminId != null && !sadminId.equalsIgnoreCase("null")) {
            adminId = Integer.parseInt(sadminId);
        } else {
            messageModel.setCode(0);
            messageModel.setMsg("管理员ID不能为空");
            PrintWriter out = resp.getWriter();
            Gson gson = new Gson();
            out.print(gson.toJson(messageModel));
            out.flush();
            return;
        }

        if (spaperId != null && !spaperId.equalsIgnoreCase("null")) {
            paperId = Integer.parseInt(spaperId);
        } else {
            messageModel.setCode(0);
            messageModel.setMsg("论文ID不能为空");
            PrintWriter out = resp.getWriter();
            Gson gson = new Gson();
            out.print(gson.toJson(messageModel));
            out.flush();
            return;
        }
        Message msg = new Message();
        Paper paper = new Paper();
        getOnePaperService getonePaperService=new getOnePaperService();
        UserService userService=new UserService();
        paper=(Paper)getonePaperService.getOnePaper(paperId).getObject();
        String receivername=paper.getPaperAuthor();
        msg.setReceiverName(receivername);
        msg.setReceiverId(userService.Finduser(receivername).getUserId());
        msg.setSenderId(adminId);
        msg.setSenderName(adminname);

        try {
            if ("approve".equals(action)) {
                // 处理通过逻辑


                System.out.println("Approving paper with ID: " + paperId + " by admin ID: " + adminId);

                // TODO: 这里调用服务层方法，更新数据库，设置论文为已通过

                // 假设返回成功
                if(paperReview.paperReviewApprove(adminId,paperId)) {
                    messageModel.setCode(1);
                    messageModel.setMsg("论文审核通过成功");
                    msg.setContent("您的论文："+paper.getPaperTitle()+" 审核通过");
                    SendMessageService sendMessageService=new SendMessageService();
                    sendMessageService.sendMessage(msg);
                }
                else{
                    messageModel.setCode(0);
                    messageModel.setMsg("出错了");
                }
            } else if ("reject".equals(action)) {
                // 处理拒绝逻辑

                System.out.println("Rejecting paper with ID: " + paperId + " by admin ID: " + adminId);

                // TODO: 这里调用服务层方法，更新数据库，设置论文为已拒绝
                // 假设返回成功
                if(paperReview.paperReviewDecline(adminId,paperId)) {
                messageModel.setCode(1);
                messageModel.setMsg("论文审核拒绝成功");
                    msg.setContent("您的论文："+paper.getPaperTitle()+" 审核未通过");
                    SendMessageService sendMessageService=new SendMessageService();
                    sendMessageService.sendMessage(msg);
                }
                else{
                    messageModel.setCode(0);
                    messageModel.setMsg("出错了");
                }
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("未知操作");
            }
        } catch (Exception e) {
            System.out.println("error"+e);
            messageModel.setCode(0);
            messageModel.setMsg("处理请求时出错: " + e.getMessage());
        }

        // 返回响应
        PrintWriter out = resp.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(messageModel));
        out.flush();
    }
}
