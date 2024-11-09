package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.ProjectDeleteMapper;
import xxxx.util.GetSqlSession;

public class DeleteProjectService {
    public MessageModel deleteProject(int projectId) {

        MessageModel messageModel = new MessageModel();
        SqlSession session = GetSqlSession.createSqlSession();
        ProjectDeleteMapper projectDeleteMapper = session.getMapper(ProjectDeleteMapper.class);

        int affectedRows = projectDeleteMapper.deleteProjectById(projectId);
        session.commit();
        session.close();

        if (affectedRows > 0) {
            messageModel.setCode(1);
            messageModel.setMsg("success");
        } else {
            messageModel.setCode(0);
            messageModel.setMsg("fail");
        }
        return messageModel;
    }
}
