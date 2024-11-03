package xxxx.entity;//实体包

import java.text.SimpleDateFormat;
import java.util.Date;

//新闻类
public class News {
    private int newsId;//主键
    private int ifPublish; // 0:no, 1:yes 是否发布
    private String newsTitle;//标题
    private String newsWriter;//作者
    private Date publishTime;//发布时间
    private String newsContent;//内容

    // 构造方法
    public News() {}

    public News(int newsId, int ifPublish, String newsTitle, String newsWriter, Date publishTime, String newsContent) {
        this.newsId = newsId;
        this.ifPublish = ifPublish;
        this.newsTitle = newsTitle;
        this.newsWriter = newsWriter;
        this.publishTime = publishTime;
        this.newsContent = newsContent;
    }

    // Getter 和 Setter 方法
    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public int getIfPublish() {
        return ifPublish;
    }

    public void setIfPublish(int ifPublish) {
        this.ifPublish = ifPublish;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getNewsWriter() {
        return newsWriter;
    }

    public void setNewsWriter(String newsWriter) {
        this.newsWriter = newsWriter;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getNewsContent() {
        return newsContent;
    }

    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
    }

    @Override
    public String toString() {
        return "News{" +
                "newsId=" + newsId +
                ", ifPublish=" + ifPublish +
                ", newsTitle='" + newsTitle + '\'' +
                ", newsWriter='" + newsWriter + '\'' +
                ", publishTime=" + publishTime +
                ", newsContent='" + newsContent + '\'' +
                '}';
    }

}
