package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.Message;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.service.SendMessageService;
import xxxx.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {
    private UserService userService = new UserService();
    private SendMessageService sendMessageService = new SendMessageService();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        MessageModel messageModel = new MessageModel();
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        HttpSession session = req.getSession();
        //从页面接受发送者信息
        String sender=session.getAttribute("username").toString();
        String receiver=req.getParameter("receiverName");
        String content=req.getParameter("content");
        System.out.println(content);
        System.out.println(receiver);
        Message message=new Message();
        //设置message的各个参数
        message.setSenderName(sender);
        message.setReceiverName(receiver);
        message.setContent(content);
        //调用UserMapper层的queryUserbyName方法查询用户Id
        try {
            User SendUser = userService.Finduser(sender);
            User receiverUser = userService.Finduser(receiver);
            if(receiverUser==null){
                messageModel.setCode(-1);
                messageModel.setMsg("未找到目标用户");
            }
            else {
                message.setSenderId(SendUser.getUserId());
                message.setReceiverId(receiverUser.getUserId());
               messageModel= sendMessageService.sendMessage(message);
            }
            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            // 序列化为 JSON
            String json = new Gson().toJson(messageModel);
            out.print(json);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace(); // 打印堆栈跟踪
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().print("{\"error\": \"服务器内部错误\"}");
        }




    }
}
