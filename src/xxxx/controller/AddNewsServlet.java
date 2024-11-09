package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.News;
import xxxx.entity.value.MessageModel;
import xxxx.service.NewsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AddNewsServlet")
public class AddNewsServlet extends HttpServlet {
    private NewsService newsService = new NewsService();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("newsTitle");
        String content = req.getParameter("newsContent");
        String author = req.getParameter("newsWriter");

        try {
            News news = new News(0, 1, title, author, null, content);
            MessageModel messageModel = newsService.addNews(news);

            System.out.println("msg: " + messageModel.getMsg());
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