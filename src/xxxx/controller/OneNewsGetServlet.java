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

@WebServlet("/OneNewsGetServlet")
public class OneNewsGetServlet extends HttpServlet {

    private NewsService newsService = new NewsService(); // 初始化服务层

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newsId = req.getParameter("newsId");
        System.out.println("newsId: " + newsId);

        MessageModel messageModel = new MessageModel();

        if (newsId == null || newsId.isEmpty()) {
            // 如果没有提供新闻ID，则设置错误信息
            messageModel.setCode(-1);
            messageModel.setMsg("请提供新闻id");
        } else {
            // 根据新闻ID查找新闻
            messageModel = newsService.getNewsById(newsId);
            System.out.println("messageModel: " + messageModel);
            if (newsId != null) {
                // 如果找到了新闻，则设置成功信息
                messageModel.setCode(1);

            } else {
                // 如果没有找到新闻，则设置错误信息
                messageModel.setCode(0);
                messageModel.setMsg("没有找到该新闻");
            }
        }

        // 设置响应内容类型为JSON
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        // 序列化为 JSON
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();
    }
}
