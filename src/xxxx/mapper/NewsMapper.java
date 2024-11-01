package xxxx.mapper;

import xxxx.entity.News;//新闻类

import java.util.List;

public interface NewsMapper {//新闻接口类

    public List<News> getNews();//获取新闻

    public News getNewsById(String newsId); // 新增方法：根据id获取新闻

}
