package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.PaperGetService;
import xxxx.service.getProjectService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

@WebServlet("/getProject")
public class getProjectServlet extends HttpServlet {

    private getProjectService service = new getProjectService();//

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session= req.getSession();
        MessageModel messageModel=new MessageModel();

        //
        String role=(String)session.getAttribute("role");
        String title = req.getParameter("projectTitle");
        String author = req.getParameter("projectManager");
        int flag = Integer.parseInt(req.getParameter("projectFlag"));
        if(Objects.equals(role, "user")|| ( Objects.equals(role,"admin")&&(flag!=1) ) ){
            if(Objects.equals(title, "admin")){
                messageModel =service.getProjectByAuthor(author);
            }
            else{
                messageModel=service.getProjectByTitleAndAuthor_flagPos(title,author);
            }
        }
        else if ( ( Objects.equals(role, "admin")&&(flag==1) ) ) {
            messageModel=service.getProject_flagNeg1();
        }
        //

        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();

    }

}
