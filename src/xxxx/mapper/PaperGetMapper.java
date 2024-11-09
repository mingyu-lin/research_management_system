package xxxx.mapper;

import org.apache.ibatis.annotations.Param;
import xxxx.entity.Paper;

import java.util.List;

public interface PaperGetMapper {
    List<Paper> getPaper();
    List<Paper> getPaperByAuthor(String author);
    List<Paper> getPaperByTitleAndAuthor_flagPos(@Param("title") String title, @Param("author") String author);
    List<Paper> getPaper_flagNeg1();
    public int paperInsert(Paper paper);
}
