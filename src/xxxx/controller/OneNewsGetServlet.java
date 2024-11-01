package xxxx.controller;

import com.google.gson.Gson;
import xxxx.entity.News;
import xxxx.entity.value.MessageModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet("/OneNewsGetServlet")
public class OneNewsGetServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("newsId");
        System.out.println(id);
        News news = new News();
        news.setNewsId(1);
        news.setNewsTitle("title");
        news.setNewsContent("content");
        news.setNewsWriter("writer");
        news.setPublishTime(new Date());
        resp.setContentType("application/json;charset=UTF-8");

        MessageModel messageModel = new MessageModel();
        messageModel.setCode(1);
        messageModel.setObject(news);
        PrintWriter out = resp.getWriter();

        // 序列化为 JSON
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();
    }

}
