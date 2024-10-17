package xxxx.service;

import xxxx.entity.User;
import xxxx.entity.value.MessageModel;
import xxxx.mapper.UserMapper;
import xxxx.util.GetSqlSession;
import xxxx.util.StringUtil;
import org.apache.ibatis.session.SqlSession;


public class UserService {

    public MessageModel userLogin(String username, String userpwd) {
         MessageModel messageModel = new MessageModel();

        User u= new User();
        u.setUserName(username);
        u.setUserPwd(userpwd);
        messageModel.setObject(u);
         if (StringUtil.isEmpty(username) || StringUtil.isEmpty(userpwd)) {
             messageModel.setCode(0);
             messageModel.setMsg("用户名和密码不能为空");

             return messageModel;
         }

        SqlSession session= GetSqlSession.createSqlSession();
        UserMapper userMapper = session.getMapper(UserMapper.class);
        User user=userMapper.queryUserByName(username);

        if(user==null){
            messageModel.setCode(0);
            messageModel.setMsg("用户不存在！");
            return messageModel;
        }

        if(!userpwd.equals(user.getUserPwd())){
            messageModel.setCode(0);
            messageModel.setMsg("密码错误！");
            return messageModel;
        }

        messageModel.setObject(user);
         return messageModel;
    }

}
