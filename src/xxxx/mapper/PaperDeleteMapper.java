package xxxx.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Delete;

public interface PaperDeleteMapper {

    int deletePaperById(int paperId);
}