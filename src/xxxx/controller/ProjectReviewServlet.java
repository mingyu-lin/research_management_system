package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.ProjectReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/projectReview")
public class ProjectReviewServlet extends HttpServlet {
    private ProjectReviewService projectReview = new ProjectReviewService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        MessageModel messageModel = new MessageModel();

        String sprojectId = req.getParameter("projectId");
        String action = req.getParameter("action");
        String sadminId = req.getParameter("adminId");

        int adminId = 0;
        int projectId = 0;

        if (sadminId != null && !sadminId.equalsIgnoreCase("null")) {
            adminId = Integer.parseInt(sadminId);
        } else {
            messageModel.setCode(0);
            messageModel.setMsg("管理员ID不能为空");
            PrintWriter out = resp.getWriter();
            out.print(new Gson().toJson(messageModel));
            out.flush();
            return;
        }

        if (sprojectId != null && !sprojectId.equalsIgnoreCase("null")) {
            projectId = Integer.parseInt(sprojectId);
        } else {
            messageModel.setCode(0);
            messageModel.setMsg("项目ID不能为空");
            PrintWriter out = resp.getWriter();
            out.print(new Gson().toJson(messageModel));
            out.flush();
            return;
        }

        try {
            if ("approve".equals(action)) {
                if (projectReview.projectReviewApprove(adminId, projectId)) {
                    messageModel.setCode(1);
                    messageModel.setMsg("项目审核通过成功");
                } else {
                    messageModel.setCode(0);
                    messageModel.setMsg("出错了");
                }
            } else if ("reject".equals(action)) {
                if (projectReview.projectReviewDecline(adminId, projectId)) {
                    messageModel.setCode(1);
                    messageModel.setMsg("项目审核拒绝成功");
                } else {
                    messageModel.setCode(0);
                    messageModel.setMsg("出错了");
                }
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("未知操作");
            }
        } catch (Exception e) {
            messageModel.setCode(0);
            messageModel.setMsg("处理请求时出错: " + e.getMessage());
        }

        PrintWriter out = resp.getWriter();
        out.print(new Gson().toJson(messageModel));
        out.flush();
    }
}
