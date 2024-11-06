package xxxx.service;

import xxxx.entity.User;
import xxxx.entity.Admin; // Import Admin class
import xxxx.entity.value.MessageModel;
import xxxx.mapper.UserMapper;
import xxxx.mapper.AdminMapper; // Import AdminMapper
import xxxx.util.GetSqlSession;
import xxxx.util.StringUtil;
import org.apache.ibatis.session.SqlSession;

public class UserService {

    public MessageModel userLogin(String username, String userpwd, String role) {
        MessageModel messageModel = new MessageModel();

        if (role.equals("user")) {
            // User login logic
            User u = new User();
            u.setUserName("name" + username);
            u.setUserPwd("pwd" + userpwd);
            messageModel.setObject(u);

            if (StringUtil.isEmpty(username) || StringUtil.isEmpty(userpwd)) {
                messageModel.setCode(0);
                messageModel.setMsg("用户名和密码不能为空");
                return messageModel;
            }

            SqlSession session = GetSqlSession.createSqlSession();
            UserMapper userMapper = session.getMapper(UserMapper.class);
            User user = userMapper.queryUserByName(username);
            if (user == null) {
                messageModel.setCode(0);
                messageModel.setMsg("用户不存在！");
                return messageModel;
            }

            if (!userpwd.equals(user.getUserPwd())) {
                messageModel.setCode(0);
                messageModel.setMsg("密码错误！");
                return messageModel;
            }

            messageModel.setObject(user);

        } else if (role.equals("admin")) {
            // Admin login logic
            Admin a = new Admin();
            a.setAdminName("name" + username);
            a.setAdminPwd("pwd" + userpwd);
            messageModel.setObject(a);

            if (StringUtil.isEmpty(username) || StringUtil.isEmpty(userpwd)) {
                messageModel.setCode(0);
                messageModel.setMsg("用户名和密码不能为空");
                return messageModel;
            }

            SqlSession session = GetSqlSession.createSqlSession();
            AdminMapper adminMapper = session.getMapper(AdminMapper.class); // Create AdminMapper instance
            Admin admin = adminMapper.queryAdminByName(username); // Query admin by username
            if (admin == null) {
                messageModel.setCode(0);
                messageModel.setMsg("管理员不存在！");
                return messageModel;
            }

            if (!userpwd.equals(admin.getAdminPwd())) {
                messageModel.setCode(0);
                messageModel.setMsg("密码错误！");
                return messageModel;
            }

            messageModel.setObject(admin);
        }

        return messageModel;
    }
    public MessageModel userRegist(String userName, String userPwd, String userEmail, String userPhone,String userPostscript) {
        MessageModel messageModel = new MessageModel();

        SqlSession session= GetSqlSession.createSqlSession();
        UserMapper userMapper = session.getMapper(UserMapper.class);
        User findUser = userMapper.queryUserByName(userName);
        User registerUser = new User();
        registerUser.setUserName(userName);
        registerUser.setUserPwd(userPwd);
        registerUser.setUserEmail(userEmail);
        registerUser.setUserPhone(userPhone);
        registerUser.setUserPostscript(userPostscript);


        if(findUser!=null){
            messageModel.setCode(1);
            messageModel.setMsg("账号已存在");
            return messageModel;
        }
        int i = userMapper.registerUser(registerUser);
        session.commit();

        return messageModel;
    }
}
