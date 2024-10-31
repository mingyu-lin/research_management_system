package xxxx.controller;

import xxxx.entity.Paper;
import xxxx.entity.value.MessageModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

@WebServlet("/getOnePaper")
public class GetOnePaperServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        MessageModel messageModel = new MessageModel();

        // 创建一个示例的 Paper 对象
        Paper samplePaper = new Paper();
        samplePaper.setPaperId(1);
        samplePaper.setPaperTitle("示例论文标题");
        samplePaper.setPaperAuthor("作者姓名");
        samplePaper.setPaperPublicationVenue("发表场所");
        samplePaper.setKeywords("关键字1, 关键字2");
        samplePaper.setPaperUpdateFrom("来源信息");
        samplePaper.setPaperAbstract("这是一个示例摘要，描述论文的主要内容和贡献。");
        samplePaper.setPaperPublicationTime("2024-10-31");

        // 将 Paper 对象设置到 MessageModel
        messageModel.setCode(1); // 表示成功
        messageModel.setMsg("成功获取示例论文数据！");
        messageModel.setObject(samplePaper); // 设置为单个对象

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
            resp.getWriter().print("{\"error\": \"服务器内部错误\"}");
        }
    }
}
