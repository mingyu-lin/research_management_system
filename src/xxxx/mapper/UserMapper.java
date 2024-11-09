package xxxx.mapper;

import org.apache.ibatis.annotations.Param;
import xxxx.entity.User;

/**
 * 用户接口类
 */
public interface UserMapper {
    User queryUserByName(String userName);
    int registerUser(User registerUser);
    int checkOldPassword(@Param("userId") int userId, @Param("oldPassword") String oldPassword);
    int updateUserPassword(@Param("userId") int userId, @Param("newPassword") String newPassword);

    // New method to update user info
    int updateUserInfo(@Param("userId") int userId,
                       @Param("userName") String userName,
                       @Param("userEmail") String userEmail,
                       @Param("userPhone") String userPhone,
                       @Param("userPostscript") String userPostscript);
}
