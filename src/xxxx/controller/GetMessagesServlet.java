package xxxx.controller;

import xxxx.entity.Message;
import xxxx.entity.value.MessageModel;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.google.gson.Gson;

@WebServlet("/getMessages")
public class GetMessagesServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String receiverName = (String) session.getAttribute("receiverName"); // 从session中获取receiverName

        // 测试用：构造一个示例消息列表
        List<Message> messageList = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            Message message = new Message();
            message.setMessageId(i);
            message.setSenderId(100 + i); // 示例发送者ID
            message.setReceiverId(200); // 示例接收者ID
            message.setSenderName("用户" + (100 + i)); // 示例发送者姓名
            message.setReceiverName(receiverName); // 从 session 中获取
            message.setContent("这是一条测试消息 " + i);
            message.setTimestamp(new Date()); // 设置当前时间
            messageList.add(message);
        }

        // 将 List<Message> 转换为 List<Object>
        List<Object> messages = new ArrayList<>(messageList); // 将消息列表转换为 List<Object>

        // 将消息列表放入 MessageModel
        MessageModel messageModel = new MessageModel();
        messageModel.setList(messages); // 这里直接将 List<Object> 赋值
        messageModel.setCode(1); // 设置成功的代码
        messageModel.setMsg("消息加载成功"); // 可选的成功消息

        try {
            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();

            // 序列化为 JSON
            String json = new Gson().toJson(messageModel);
            out.print(json);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace(); // 打印堆栈跟踪
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().print("{\"code\": 0, \"msg\": \"服务器内部错误\"}");
        }
    }
}
