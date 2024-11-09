package xxxx.service;

import org.apache.ibatis.session.SqlSession;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.PaperReviewMapper;
import xxxx.util.GetSqlSession;

import javax.servlet.annotation.WebServlet;


public class paperReviewService {


    public boolean paperReviewApprove(int adminId, int paperId) {

        try {
            SqlSession session= GetSqlSession.createSqlSession();
            PaperReviewMapper paperReviewMapper= session.getMapper(PaperReviewMapper.class);
            MessageModel messageModel= new MessageModel();
            getOnePaperService getone=new getOnePaperService();
            messageModel=getone.getOnePaper(paperId);
            if(messageModel.getCode()==0) return false;
            paperReviewMapper.approvePaper(adminId, paperId);
            session.commit();
            session.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean paperReviewDecline(int adminId, int paperId) {
        try {
            SqlSession session= GetSqlSession.createSqlSession();
            PaperReviewMapper paperReviewMapper= session.getMapper(PaperReviewMapper.class);
            MessageModel messageModel= new MessageModel();
            getOnePaperService getone=new getOnePaperService();
            messageModel=getone.getOnePaper(paperId);
            if(messageModel.getCode()==0) return false;
            paperReviewMapper.declinePaper(adminId, paperId);
            session.commit();
            session.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
