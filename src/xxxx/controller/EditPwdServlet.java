package xxxx.controller;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.UserService;

@WebServlet("/editPwd")
public class EditPwdServlet extends HttpServlet {

    private UserService userService = new UserService();
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userid") ;// Assuming user ID is in session
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        String userPhone = request.getParameter("userPhone");
        String userPostscript = request.getParameter("userPostscript");
        MessageModel messageModel = new MessageModel();

        try {
            boolean result;
            if (newPassword != null && !newPassword.isEmpty()) {
                // Update password if newPassword is provided
                System.out.println("servlet newPassword: " + newPassword);
                System.out.println("servlet oldPassword: " + oldPassword);
                result = userService.updatePassword(userId, oldPassword, newPassword);
                messageModel.setMsg(result ? "密码修改成功" : "旧密码不正确");
            } else {
                // Update user info if newPassword is empty
                System.out.println("userid: " + userId);
                System.out.println("userName: " + userName);
                System.out.println("userEmail: " + userEmail);
                System.out.println("userPhone: " + userPhone);
                System.out.println("userPostscript: " + userPostscript);
                result = userService.updateUserInfo(userId, userName, userEmail, userPhone, userPostscript);
                messageModel.setMsg(result ? "用户信息修改成功" : "用户信息修改失败");
            }

            messageModel.setCode(result ? 1 : 0);
        } catch (Exception e) {
            e.printStackTrace();
            messageModel.setCode(0);
            messageModel.setMsg("修改操作时出现错误，请重试。");
        }
        response.setContentType("application/json;charset=UTF-8");
        // Write the MessageModel as JSON to the response
        PrintWriter out = response.getWriter();

        // 序列化为 JSON
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();//确保更新
    }
}