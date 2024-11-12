package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.deleteUserService;
import xxxx.service.getOnePaperService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deleteUser")
public class deleteUserServlet extends HttpServlet {

    private deleteUserService service = new deleteUserService();//服务

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String parameter=req.getParameter("userId");//
        System.out.println("userId"+parameter);
        MessageModel messageModel = new MessageModel();
        messageModel.setCode(0);
        messageModel.setMsg("删除失败");
        if((parameter!=null)&&(!parameter.isEmpty())) {
            int id = Integer.parseInt(parameter);
            service.deleteUser(id);
           messageModel.setCode(1);
           messageModel.setMsg("删除成功");

        }
        //
        resp.setContentType("application/json;charset=UTF-8");
        // Write the MessageModel as JSON to the response
        PrintWriter out = resp.getWriter();

        // 序列化为 JSON
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();//确保更新
    }

}
