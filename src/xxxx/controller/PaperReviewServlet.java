package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/paperReview")
public class PaperReviewServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置响应类型
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        // 获取参数
        String paperId = req.getParameter("paperId");
        String action = req.getParameter("action");
        String adminId = req.getParameter("adminId");

        // 创建返回模型
        MessageModel messageModel = new MessageModel();

        try {
            if ("approve".equals(action)) {
                // 处理通过逻辑
                System.out.println("Approving paper with ID: " + paperId + " by admin ID: " + adminId);

                // TODO: 这里调用服务层方法，更新数据库，设置论文为已通过
                // 假设返回成功
                messageModel.setCode(1);
                messageModel.setMsg("论文审核通过成功");

            } else if ("reject".equals(action)) {
                // 处理拒绝逻辑
                System.out.println("Rejecting paper with ID: " + paperId + " by admin ID: " + adminId);

                // TODO: 这里调用服务层方法，更新数据库，设置论文为已拒绝
                // 假设返回成功
                messageModel.setCode(1);
                messageModel.setMsg("论文审核拒绝成功");
            } else {
                messageModel.setCode(0);
                messageModel.setMsg("未知操作");
            }
        } catch (Exception e) {
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
