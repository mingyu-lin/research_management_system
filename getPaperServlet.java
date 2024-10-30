package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getPaper")
public class getPaperServlet extends HttpServlet {
    MessageModel messageModel = new MessageModel();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        try {
            System.out.println("Request received: " + req.getRequestURI());

            // 创建 User 对象
            User user = new User();
            user.setUserName("admin");
            user.setUserPwd("admin");
            user.setUserId(1);

            // 创建 List<User>
            List<User> users = List.of(user);

            // 创建 MessageModel 对象
            MessageModel messageModel = new MessageModel();
            messageModel.setCount(users.size());
            messageModel.setCode(1); // 成功
            messageModel.setMsg("成功！");
            // 将 List<User> 转换为 List<Object>
            List<Object> objectList = new ArrayList<>(users);
            messageModel.setList(objectList); // 设置 List<Object>

            // 设置响应类型为 JSON
            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();

            // 序列化为 JSON
            String json = new Gson().toJson(messageModel);
           
            System.out.println("Generated JSON: " + json);
            out.print(json);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace(); // 打印堆栈跟踪
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().print("{\"error\": \"服务器内部错误\"}");
        }
    }
}
