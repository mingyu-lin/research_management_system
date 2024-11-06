package xxxx.controller;

import com.google.gson.Gson;

import xxxx.entity.value.MessageModel;
import xxxx.service.getUserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("//GetUserInfoServlet")
public class GetUserInfoServlet extends HttpServlet {

    private getUserService service = new getUserService();//

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("userId"));//
        MessageModel messageModel = service.getOneUser(id);//


        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();

    }

}
