package xxxx.service;

import org.apache.ibatis.session.SqlSession;

import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.getUserMapper;
import xxxx.util.GetSqlSession;

public class getUserService {

    public MessageModel getOneUser(int id) {
        MessageModel messageModel = new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();

        //
        getUserMapper mapper = session.getMapper(getUserMapper.class);
        User info=mapper.getUserById(id);//调用mapper层获取新闻
        if(info==null){//库中无新闻
            User empty_info = new User();
            messageModel.setObject(empty_info);
            messageModel.setCode(0);//失败信息
            messageModel.setMsg("无！");
            return messageModel;//返回空壳
        }
        //

        messageModel.setObject(info);
        return messageModel;
    }
}
