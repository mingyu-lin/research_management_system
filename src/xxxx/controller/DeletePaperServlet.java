package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.DeletePaperService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deletePaper")
public class DeletePaperServlet extends HttpServlet {

    private DeletePaperService paperService=new DeletePaperService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("paperId"));//
        System.out.println(id);


        try {
            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            MessageModel messageModel = paperService.deletePaper(id);//获
            // 序列化为 JSON
            String json = new Gson().toJson(messageModel);
            out.print(json);
            out.flush();//确保更新
        } catch (Exception e) {
            e.printStackTrace(); // 打印堆栈跟踪
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().print("{\"error\": \"服务器内部错误\"}");
        }
    }
}
