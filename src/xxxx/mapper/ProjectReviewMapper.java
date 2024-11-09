package xxxx.mapper;

import org.apache.ibatis.annotations.Param;

public interface ProjectReviewMapper {
    void approveProject(@Param("adminId") int adminId, @Param("projectId") int projectId);
    void declineProject(@Param("adminId") int adminId, @Param("projectId") int projectId);
}
