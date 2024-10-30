package xxxx.entity;

import java.util.Date;

/**
 * User实体类
 */
public class User {
    private Integer userId; //用户编号
    private String userName; //用户名
    private String userPwd; //密码
    private String userEmail;
    private String userPhone;
    private Integer userFlag;
    private Date userCreateTime;

    public Date getUserCreateTime() {
        return userCreateTime;
    }

    public void setUserCreateTime(Date userCreateTime) {
        this.userCreateTime = userCreateTime;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public Integer getUserFlag() {
        return userFlag;
    }

    public void setUserFlag(Integer userFlag) {
        this.userFlag = userFlag;
    }


    public String getUserPostscript() {
        return userPostscript;
    }

    public void setUserPostscript(String userPostscript) {
        this.userPostscript = userPostscript;
    }

    private String userPostscript;
    public User() {}
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }

    public String getUserPhone() {
        return userPhone;
    }
}
