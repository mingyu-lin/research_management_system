package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.Paper;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.PaperDeleteMapper;
import xxxx.util.GetSqlSession;


public class DeletePaperService {
   public MessageModel deletePaper(int paperId) {

        MessageModel messageModel=new MessageModel();
        SqlSession session= GetSqlSession.createSqlSession();
        PaperDeleteMapper paperDeleteMapper=session.getMapper(PaperDeleteMapper.class);
        int affectedRows = paperDeleteMapper.deletePaperById(paperId);
        session.commit();
        session.close();
        if(affectedRows>0){
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
