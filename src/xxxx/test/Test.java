package xxxx.test;

import xxxx.entity.User;
import xxxx.mapper.UserMapper;
import xxxx.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

public class Test {
    public static void main(String[] args) {
        //获取sqlSession对象
        SqlSession session = GetSqlSession.createSqlSession();
        //得到对应的Mapper
        UserMapper userMapper = session.getMapper(UserMapper.class);
        //调用方法，返回用户对象
        User user = userMapper.queryUserByName("admin");
        System.out.println(user);
    }
}