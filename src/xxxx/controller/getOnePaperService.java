package xxxx.service;

import org.apache.ibatis.session.SqlSession;

import xxxx.entity.Paper;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.getOnePaperMapper;
import xxxx.util.GetSqlSession;

public class getOnePaperService {

    public MessageModel getOnePaper(int id) {//获取新闻
        MessageModel messageModel = new MessageModel();

        SqlSession session= GetSqlSession.createSqlSession();
        getOnePaperMapper get1PaperMapper = session.getMapper(getOnePaperMapper.class);
        Paper paper=get1PaperMapper.getOnePaper(id);//调用mapper层获取新闻

        if(paper==null){//库中无新闻
            Paper empty_paper = new Paper();
            messageModel.setObject(empty_paper);
            messageModel.setCode(0);//失败信息
            messageModel.setMsg("无论文！");
            return messageModel;//返回空壳
        }
        messageModel.setObject(paper);

        return messageModel;//返回新闻
    }

}
