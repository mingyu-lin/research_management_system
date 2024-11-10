package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.Paper;
import xxxx.entity.Project;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.getOnePaperMapper;
import xxxx.mapper.getOneProjectMapper;
import xxxx.util.GetSqlSession;

public class getOneProjectService {

    public MessageModel getOneProject(int id) {
        MessageModel messageModel = new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();

        getOneProjectMapper mapper = session.getMapper(getOneProjectMapper.class);//
        Project info=mapper.getOneProject(id);//调用mapper层获取新闻

        if(info==null){
            Project empty_info = new Project();//
            messageModel.setObject(empty_info);
            messageModel.setCode(0);
            messageModel.setMsg("无！");
            return messageModel;
        }
        messageModel.setObject(info);
        return messageModel;
    }

}
