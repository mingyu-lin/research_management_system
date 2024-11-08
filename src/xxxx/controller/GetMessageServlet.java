package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.getMessageService;
import xxxx.service.getOnePaperService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/getMessages")
public class GetMessageServlet extends HttpServlet {

    private getMessageService service = new getMessageService();//服务

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MessageModel messageModel=new MessageModel();
        HttpSession session = req.getSession();

        //
        int parameter = (int) session.getAttribute("userId");
        messageModel = service.getMessage(parameter);
        //

        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();

    }

}
