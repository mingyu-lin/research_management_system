package xxxx.controller;

import com.google.gson.Gson;

import xxxx.entity.value.MessageModel;
import xxxx.service.PaperGetService;
import xxxx.util.GetSqlSession;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

@WebServlet("/getPaper")
public class getPaperServlet extends HttpServlet {

    private PaperGetService paperGetService = new PaperGetService();//调用服务层

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        HttpSession session= req.getSession();
        String role=(String)session.getAttribute("role");

        String title = req.getParameter("paperTitle");
        String author = req.getParameter("paperAuthor");
        String paperFlagStr = req.getParameter("paperFlag");
        System.out.println(role);
        System.out.println(title);
        System.out.println(author);
        System.out.println(paperFlagStr);
        int flag = 0; // 默认值，可以根据实际情况调整
        if (paperFlagStr != null && !paperFlagStr.trim().isEmpty()){
            flag = Integer.parseInt(paperFlagStr);
        }

        MessageModel messageModel=new MessageModel();
        if(Objects.equals(role, "user")|| ( Objects.equals(role,"admin")&&(flag!=1) ) ){
            if(Objects.equals(title, "admin")){
                messageModel =paperGetService.paperGetByAuthor(author);
            }
            else{
                messageModel=paperGetService.paperGetByTitleAndAuthor_flagPos(title,author);
            }
        }
        else if ( ( Objects.equals(role, "admin")&&(flag==1) ) ) {
            messageModel=paperGetService.paperGet_flagNeg1();
        }




        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        // 序列化为 JSON
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();//确保更新

    }
}
