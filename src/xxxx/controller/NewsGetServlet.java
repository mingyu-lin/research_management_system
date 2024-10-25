package xxxx.controller;

import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.service.NewsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

@WebServlet("/getNews")
public class NewsGetServlet extends HttpServlet {

    private NewsService newsService = new NewsService();//调用服务层

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        MessageModel messageModel = newsService.newsGet();
        try{
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
