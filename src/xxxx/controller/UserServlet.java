package xxxx.controller;

import xxxx.entity.value.MessageModel;
import xxxx.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="login", urlPatterns = "/login")
public class UserServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String userpwd = req.getParameter("userpwd");
        MessageModel messageModel = userService.userLogin(username,userpwd);
        if (messageModel.getCode() == 1) {
            req.getSession().setAttribute("user", messageModel.getObject());
            resp.sendRedirect("index.jsp");
        }
        else {
            req.getSession().setAttribute("messageModel", messageModel);
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
