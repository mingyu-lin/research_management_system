package xxxx.mapper;

import xxxx.entity.Paper;

import java.util.List;

public interface PaperGetMapper {
    List<Paper> getPaper();
    List<Paper> getPaperByAuthor(String author);
    List<Paper> getPaperByTitleAndAuthor_flagPos(String title,String author);
    List<Paper> getPaper_flagNeg1();
}
