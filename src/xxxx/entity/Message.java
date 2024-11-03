package xxxx.entity;

import java.util.Date;

public class Message {
    private Integer messageId; // 消息ID
    private Integer senderId; // 发送者ID
    private Integer receiverId; // 接收者ID
    private String content; // 消息内容
    private String senderName;
    private String receiverName;
    private Date timestamp; // 时间戳

    // 构造函数

    @Override
    public String toString() {
        return "Message{" +
                "messageId=" + messageId +
                ", senderId=" + senderId +
                ", receiverId=" + receiverId +
                ", content='" + content + '\'' +
                ", senderName='" + senderName + '\'' +
                ", receiverName='" + receiverName + '\'' +
                ", timestamp=" + timestamp +
                '}';
    }

    // Getter 和 Setter 方法

    public Integer getMessageId() {
        return messageId;
    }

    public void setMessageId(Integer messageId) {
        this.messageId = messageId;
    }

    public Integer getSenderId() {
        return senderId;
    }

    public void setSenderId(Integer senderId) {
        this.senderId = senderId;
    }

    public Integer getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(Integer receiverId) {
        this.receiverId = receiverId;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }


}
