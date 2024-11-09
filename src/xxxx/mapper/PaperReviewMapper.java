package xxxx.mapper;

import org.apache.ibatis.annotations.Param;

public interface PaperReviewMapper {
    void approvePaper(@Param("adminId") int adminId, @Param("paperId") int paperId);
    void declinePaper(@Param("adminId") int adminId, @Param("paperId") int paperId);
}
