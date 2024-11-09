package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.value.MessageModel;
import xxxx.service.DeleteProjectService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deleteProject")
public class DeleteProjectServlet extends HttpServlet {

    private DeleteProjectService projectService = new DeleteProjectService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("projectId"));
        System.out.println(id);

        try {
            resp.setContentType("application/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            MessageModel messageModel = projectService.deleteProject(id);
            // 序列化为 JSON
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
