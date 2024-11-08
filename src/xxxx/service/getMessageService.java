package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.Message;
import xxxx.entity.Paper;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.getMessageMapper;
import xxxx.mapper.getOnePaperMapper;
import xxxx.util.GetSqlSession;

public class getMessageService {

    public MessageModel getMessage(int id) {
        MessageModel messageModel = new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();

        getMessageMapper mapper = session.getMapper(getMessageMapper.class);//
        Message info=mapper.getMessage(id);//调用mapper层获取新闻

        if(info==null){
            Message empty_info = new Message();//
            messageModel.setObject(empty_info);
            messageModel.setCode(0);
            messageModel.setMsg("无！");
            return messageModel;
        }
        messageModel.setObject(info);
        return messageModel;
    }

}
