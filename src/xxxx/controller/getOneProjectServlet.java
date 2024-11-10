package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.getOnePaperService;
import xxxx.service.getOneProjectService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/getOneProject")
public class getOneProjectServlet extends HttpServlet {

    private getOneProjectService service = new getOneProjectService();//服务

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        MessageModel messageModel=new MessageModel();

        String parameter=req.getParameter("projectId");//
        if((parameter!=null)&&(!parameter.isEmpty())){
            int id = Integer.parseInt(parameter);//
            messageModel = service.getOneProject(id);//获取
        }

        try {
            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            String json = new Gson().toJson(messageModel);
            out.print(json);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().print("{\"error\": \"服务器内部错误\"}");
        }
    }

}
