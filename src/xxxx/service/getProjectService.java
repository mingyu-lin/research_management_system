package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.Paper;
import xxxx.entity.Project;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.PaperGetMapper;
import xxxx.mapper.getProjectMapper;
import xxxx.util.GetSqlSession;

import java.util.ArrayList;
import java.util.List;

public class getProjectService {

    public MessageModel getProjectByAuthor(String author) {
        MessageModel messageModel = new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();

        //
        getProjectMapper mapper = session.getMapper(getProjectMapper.class);
        List<Project> info=mapper.getProjectByAuthor(author);
        //

        messageModel.setCount(info.size());
        if(info.size()==0){
            Project empty_info = new Project();//
            messageModel.setObject(empty_info);
            messageModel.setCode(0);
            messageModel.setMsg("无！");
            return messageModel;
        }
        List<Object> objectList = new ArrayList<>(info);
        messageModel.setList(objectList);
        return messageModel;
    }

    public MessageModel getProjectByTitleAndAuthor_flagPos(String title,String author) {
        MessageModel messageModel = new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();

        //
        getProjectMapper mapper = session.getMapper(getProjectMapper.class);
        List<Project> info=mapper.getProjectByTitleAndAuthor_flagPos(title,author);
        //

        messageModel.setCount(info.size());
        if(info.size()==0){
            Project empty_info = new Project();//
            messageModel.setObject(empty_info);
            messageModel.setCode(0);
            messageModel.setMsg("无！");
            return messageModel;
        }
        List<Object> objectList = new ArrayList<>(info);
        messageModel.setList(objectList);
        return messageModel;
    }

    public MessageModel getProject_flagNeg1() {//获取新闻
        MessageModel messageModel = new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();

        //
        getProjectMapper mapper = session.getMapper(getProjectMapper.class);
        List<Project> info=mapper.getProject_flagNeg1();
        //

        messageModel.setCount(info.size());
        if(info.size()==0){
            Project empty_info = new Project();//
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
