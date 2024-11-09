package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserService userService = new UserService();
    private Object messageModel;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String userName = req.getParameter("userName");
        String userPwd = req.getParameter("userPwd");
        String userEmail = req.getParameter("userEmail");
        String userPhone = req.getParameter("userPhone");
        //String userRole = req.getParameter("userRole");
        String userPostscript = req.getParameter("userPostscript");
        userPostscript = (userPostscript == null) ? "" : userPostscript;
        System.out.println("Received username: " + userName);
        System.out.println("Received password: " + userPwd);

        try {
            // 调用 userService 的 userLogin 方法
            //MessageModel messageModel = userService.userLogin(username, userpwd);
            MessageModel messageModel=userService.userRegist(userName,userPwd,userEmail,userPhone,userPostscript);

            System.out.println("msg"+messageModel.getMsg());
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


