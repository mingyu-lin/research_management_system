package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.Paper;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.service.PaperGetService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.List;
@WebServlet("/addPaper")
public class addPaperServlet extends HttpServlet {
    PaperGetService paperGetService = new PaperGetService();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        Paper InsertPaper = new Paper();
        //写入参数

        InsertPaper.setPaperTitle(req.getParameter("paperTitle"));
        InsertPaper.setPaperAuthor(req.getParameter("paperAuthor"));
        InsertPaper.setPaperPublicationVenue(req.getParameter("paperPublicationVenue"));
        InsertPaper.setKeywords(req.getParameter("keywords"));
        InsertPaper.setPaperAbstract(req.getParameter("paperAbstract"));
        InsertPaper.setPaperPublicationTime(req.getParameter("paperPublicationTime"));
        InsertPaper.setPaperLevel(req.getParameter("paperLevel"));
        String action = req.getParameter("action");
        System.out.println("Received papertitle: " + InsertPaper.getPaperTitle());
        System.out.println("Received paperauthor: " + InsertPaper.getPaperAuthor());
        System.out.println("action: "+action);
        try{
            MessageModel messageModel=new MessageModel();
            if(action.equals("add")) {
                messageModel = paperGetService.paperInsert(InsertPaper);
            }
            else {
                messageModel=paperGetService.paperUpdate(InsertPaper);
            }
            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            // 序列化为 JSON
            String json = new Gson().toJson(messageModel);
            out.print(json);
            out.flush();

        }catch (Exception e) {
            e.printStackTrace(); // 打印堆栈跟踪
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().print("{\"error\": \"服务器内部错误\"}");
        }


    }

}
