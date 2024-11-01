package xxxx.test;

import xxxx.entity.News;
import xxxx.entity.value.MessageModel;
import xxxx.service.NewsService;

public class NewsServiceTest {
    public static void main(String[] args) {
        // 创建NewsService实例
        NewsService newsService = new NewsService();

        String newsId = "1";
        // 调用getNewsById方法
        MessageModel messageModel = newsService.getNewsById(newsId);

        // 打印返回的MessageModel对象
        System.out.println(messageModel);

        // 如果操作成功并且找到了新闻，则打印新闻对象
        if (messageModel.getCode() == 1) {
            News news = (News) messageModel.getObject();
            System.out.println("找到的新闻: " + news);
        } else {
            // 如果操作失败，打印错误消息
            System.out.println("错误: " + messageModel.getMsg());
        }
    }
}
