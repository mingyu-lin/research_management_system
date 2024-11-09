package xxxx.mapper;

import xxxx.entity.Message;
import org.apache.ibatis.annotations.Param;
public interface SendMessageMapper {
    //void MessageInsert(@Param("senderId") int senderId,@Param("receiverId") int recevierId,@Param("receiverName") String recevierName, @Param("senderName") String senderName,@Param("content") String content);
    void MessageInsert(Message message);
}
