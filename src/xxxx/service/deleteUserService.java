package xxxx.service;

import org.apache.ibatis.session.SqlSession;

import xxxx.mapper.deleteUserMapper;
import xxxx.mapper.getOnePaperMapper;
import xxxx.util.GetSqlSession;

public class deleteUserService {

    public void deleteUser(int id) {
        SqlSession session= GetSqlSession.createSqlSession();

        deleteUserMapper mapper = session.getMapper(deleteUserMapper.class);//
        mapper.deleteUser(id);//调用mapper层获取新闻
        session.commit();
        session.close();
    }

}
