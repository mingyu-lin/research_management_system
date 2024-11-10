package xxxx.controller;

import xxxx.service.deleteUserService;
import xxxx.service.getOnePaperService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteUser")
public class deleteUserServlet extends HttpServlet {

    private deleteUserService service = new deleteUserService();//服务

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String parameter=req.getParameter("userId");//
        if((parameter!=null)&&(!parameter.isEmpty())) {
            int id = Integer.parseInt(parameter);
            service.deleteUser(id);
        }
        //
    }

}
