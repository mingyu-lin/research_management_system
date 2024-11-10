package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.Project;
import xxxx.entity.value.MessageModel;
import xxxx.service.AddProjectService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/addProject")
public class AddProjectServlet extends HttpServlet {
    AddProjectService addProjectService = new AddProjectService();
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");

        Project project = new Project();

        project.setProjectTitle(req.getParameter("projectTitle"));
        project.setProjectManager(req.getParameter("projectManager"));
        project.setProjectFunding(Integer.valueOf(req.getParameter("projectFunding")));
        project.setProjectBeginTime(req.getParameter("projectBeginTime"));
        project.setProjectEndTime(req.getParameter("projectEndTime"));
        project.setProjectLevel(Integer.valueOf(req.getParameter("projectLevel")));
        project.setProjectSource(req.getParameter("projectSource"));

        try{


            MessageModel messageModel = addProjectService.projectInsert(project);

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
