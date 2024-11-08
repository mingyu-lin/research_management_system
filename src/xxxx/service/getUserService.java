package xxxx.service;

import org.apache.ibatis.session.SqlSession;

import xxxx.entity.News;
import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.NewsMapper;
import xxxx.mapper.getUserMapper;
import xxxx.util.GetSqlSession;

import java.util.ArrayList;
import java.util.List;

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

    public MessageModel getUserList() {
        MessageModel messageModel = new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();

        getUserMapper mapper = session.getMapper(getUserMapper.class);//
        List<User> info=mapper.getUserList();//调用mapper层获取新闻

        messageModel.setCount(info.size());

        if(info.size()==0){
            User empty_info = new User();//
            messageModel.setObject(empty_info);
            messageModel.setCode(0);
            messageModel.setMsg("无！");
            return messageModel;
        }
        List<Object> objectList = new ArrayList<>(info);
        messageModel.setList(objectList);
        return messageModel;
    }

}
