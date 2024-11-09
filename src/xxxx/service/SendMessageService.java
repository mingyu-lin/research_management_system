package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.Message;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.SendMessageMapper;
import xxxx.mapper.UserMapper;
import xxxx.util.GetSqlSession;

public class SendMessageService {
    public MessageModel sendMessage(Message msg) {
        MessageModel m = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        UserMapper userMapper = session.getMapper(UserMapper.class);
        User user = userMapper.queryUserByName(msg.getReceiverName());
        if(user == null) {
            m.setCode(0);
            m.setMsg("用户不存在！");
            return m;
        }
        SendMessageMapper sendMessageMapper = session.getMapper(SendMessageMapper.class);
        sendMessageMapper.MessageInsert(msg);
        session.commit();
        return m;
    }
}
