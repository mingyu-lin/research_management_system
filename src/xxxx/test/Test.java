package xxxx.test;

import xxxx.entity.Admin;
import xxxx.entity.Paper;
import xxxx.entity.User;
import xxxx.mapper.AdminMapper;
import xxxx.mapper.PaperGetMapper;
import xxxx.mapper.UserMapper;
import xxxx.util.GetSqlSession;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class Test {
    public static void main(String[] args) {


        SqlSession session = GetSqlSession.createSqlSession();
        // 得到对应的 AdminMapper
        PaperGetMapper paperGetMapper = session.getMapper(PaperGetMapper.class);

        // 调用方法，返回 admin 对象
        List<Paper> paperList= paperGetMapper.getPaperByTitleAndAuthor_flagPos("%","df"); // 替换为你要查询的管理员用户名

        // 打印 admin 对象
        System.out.println(paperList);

        // 关闭 sqlSession
        session.close();
    }
}