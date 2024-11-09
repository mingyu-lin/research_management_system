package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.service.getUserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getUserList")
public class GetUserListServlet extends HttpServlet {

    private getUserService service = new getUserService();//调用服务层

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        MessageModel messageModel = service.getUserList();//

        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();// 序列化为 JSON
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();


    }
}
