package xxxx.service;

import xxxx.entity.News;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.NewsMapper;
import xxxx.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.Collections;
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

        messageModel.setList(Collections.singletonList(newsList));
        return messageModel;//返回新闻
    }

}
