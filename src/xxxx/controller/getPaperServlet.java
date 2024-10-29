package xxxx.controller;

import com.google.gson.Gson;

import xxxx.entity.value.MessageModel;
import xxxx.service.PaperGetService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/getPaper")
public class getPaperServlet extends HttpServlet {

    private PaperGetService paperGetService = new PaperGetService();//实例化服务层

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

        MessageModel messageModel = paperGetService.paperGet();// 调用服务层的方法获取数据

        resp.setContentType("application/json;charset=UTF-8");// 设置响应内容类型为 JSON
        PrintWriter out = resp.getWriter();// 获取响应输出流

        // 序列化为 JSON
        String json = new Gson().toJson(messageModel);
        out.print(json);
        out.flush();

    }
}
