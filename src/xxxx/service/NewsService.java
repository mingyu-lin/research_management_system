package xxxx.service;

import xxxx.entity.News;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.NewsMapper;
import xxxx.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.ArrayList;
import java.util.List;

public class NewsService {//新闻服务

    public MessageModel newsGet() {//获取新闻
        MessageModel messageModel = new MessageModel();

        SqlSession session= GetSqlSession.createSqlSession();
        NewsMapper newsMapper = session.getMapper(NewsMapper.class);
        List<News> newsList=newsMapper.getNews();//调用mapper层获取新闻

        messageModel.setCount(newsList.size());

        if(newsList.size()==0){//库中无新闻
            News empty_news = new News();
            messageModel.setObject(empty_news);
            messageModel.setCode(0);//失败信息
            messageModel.setMsg("无新闻！");
            return messageModel;//返回空壳
        }
        List<Object> objectList = new ArrayList<>(newsList);
        messageModel.setList(objectList);

        return messageModel;//返回新闻
    }
    // 新增方法：根据新闻id获取新闻
    public MessageModel getNewsById(String newsId) {
        MessageModel messageModel = new MessageModel();

        // 判断newsId是否为空
        if (newsId == null || newsId.isEmpty()) {
            messageModel.setCode(0);
            messageModel.setMsg("新闻id不能为空！");
            return messageModel;
        }

        // 调用mapper层获取特定id的新闻
        SqlSession session = GetSqlSession.createSqlSession();
        NewsMapper newsMapper = session.getMapper(NewsMapper.class);
        News news = newsMapper.getNewsById(newsId);

        if (news == null) {
            // 如果没有找到新闻，设置失败信息
            messageModel.setCode(0);
            messageModel.setMsg("无此新闻！");
        } else {
            // 如果找到了新闻，直接设置object字段
            messageModel.setObject(news);
            messageModel.setCode(1); // 成功信息
            messageModel.setMsg("获取新闻成功");
            System.out.println("test"+news.getNewsContent());
        }

        // 确保SqlSession被关闭
        session.close();

        return messageModel;
    }


}
