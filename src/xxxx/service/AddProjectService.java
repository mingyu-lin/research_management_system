package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.Project;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.AddProjectMapper;
import xxxx.util.GetSqlSession;

public class AddProjectService {
    public MessageModel projectInsert(Project project) {
        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        AddProjectMapper addProjectMapper = session.getMapper(AddProjectMapper.class);
        addProjectMapper.projectInsert(project);
        session.commit();
        int res= addProjectMapper.projectInsert(project);
        if(res>0){
            messageModel.setCode(1);
            messageModel.setMsg("success");
        }
        else{
            messageModel.setCode(0);
            messageModel.setMsg("fail");
        }


        return messageModel;

    }
}
