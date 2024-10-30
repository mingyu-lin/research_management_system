package xxxx.service;

import org.apache.ibatis.session.SqlSession;

import xxxx.entity.Paper;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.PaperGetMapper;
import xxxx.util.GetSqlSession;

import java.util.ArrayList;
import java.util.List;

public class PaperGetService {

    public MessageModel paperGet() {//获取新闻
        MessageModel messageModel = new MessageModel();

        SqlSession session= GetSqlSession.createSqlSession();
        PaperGetMapper paperGetMapper = session.getMapper(PaperGetMapper.class);
        List<Paper> paperList=paperGetMapper.getPaper();//调用mapper层获取新闻

        messageModel.setCount(paperList.size());

        if(paperList.size()==0){//库中无新闻
            Paper empty_paper = new Paper();
            messageModel.setObject(empty_paper);
            messageModel.setCode(0);//失败信息
            messageModel.setMsg("无论文！");
            return messageModel;//返回空壳
        }
        List<Object> objectList = new ArrayList<>(paperList);
        messageModel.setList(objectList);

        return messageModel;//返回新闻
    }

}
