package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.ProjectReviewMapper;
import xxxx.util.GetSqlSession;

public class ProjectReviewService {

    public boolean projectReviewApprove(int adminId, int projectId) {
        try {
            SqlSession session = GetSqlSession.createSqlSession();
            ProjectReviewMapper projectReviewMapper = session.getMapper(ProjectReviewMapper.class);
            projectReviewMapper.approveProject(adminId, projectId);
            session.commit();
            session.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean projectReviewDecline(int adminId, int projectId) {
        try {
            SqlSession session = GetSqlSession.createSqlSession();
            ProjectReviewMapper projectReviewMapper = session.getMapper(ProjectReviewMapper.class);
            projectReviewMapper.declineProject(adminId, projectId);
            session.commit();
            session.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
