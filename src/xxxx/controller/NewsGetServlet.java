package xxxx.controller;

import xxxx.entity.value.MessageModel;
import xxxx.service.NewsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/getNews")
public class NewsGetServlet extends HttpServlet {

    private NewsService newsService = new NewsService();//调用服务层

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        MessageModel messageModel = newsService.newsGet();

        if (messageModel.getCode() == 1) {//成功获取新闻
            req.getSession().setAttribute("news", messageModel.getObject());
        }
        else {//获取新闻失败
            req.getSession().setAttribute("messageModel", messageModel);
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        }

    }

}
