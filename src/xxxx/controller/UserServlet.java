package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.Admin;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name="login", urlPatterns = "/login")
public class UserServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String userpwd = req.getParameter("userpwd");
        String role = req.getParameter("role");
        System.out.println("Received username: " + username);
        System.out.println("Received password: " + userpwd);

        try {
            // 调用 userService 的 userLogin 方法
            MessageModel messageModel = userService.userLogin(username, userpwd,role);
            HttpSession session = req.getSession();
            // 将用户信息存储到 session
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            if(role.equals("admin")){
                session.setAttribute("userid", ((Admin) messageModel.getObject()).getAdminId());
            }
            else {
                session.setAttribute("userid", ((User) messageModel.getObject()).getUserId());
            }
            System.out.println("userService.userLogin returned: " + messageModel);

            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            // 序列化为 JSON
            String json = new Gson().toJson(messageModel);
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace(); // 打印堆栈跟踪
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().print("{\"error\": \"服务器内部错误\"}");
        }
    }
}