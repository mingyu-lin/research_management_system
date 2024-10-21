package xxxx.controller;

import xxxx.entity.User;
import xxxx.entity.value.MessageModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/getNews")
public class NewsGetServlet extends HttpServlet {
    private MessageModel messageModel=new MessageModel();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User user=new User();
        user.setUserName("admin");
        user.setUserPwd("admin");
        user.setUserId(1);

        List<User> users= List.of(user);
        messageModel.setCount(users.size());
        messageModel.setCode(1);
        messageModel.setList(Collections.singletonList(users));
        HttpSession session = req.getSession();
        req.getSession().setAttribute("messageModel", messageModel);
        req.getRequestDispatcher("main.jsp").forward(req, resp);
    }
}
