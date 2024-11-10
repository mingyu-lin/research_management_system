package xxxx.mapper;

import org.apache.ibatis.annotations.Param;
import xxxx.entity.Paper;
import xxxx.entity.Project;

import java.util.List;

public interface getProjectMapper {

    List<Project> getProjectByAuthor(String author);
    List<Project> getProjectByTitleAndAuthor_flagPos(@Param("title") String title, @Param("author") String author);
    List<Project> getProject_flagNeg1();

}
