package xxxx.mapper;

import xxxx.entity.User;

/**
 * 用户接口类
 */
public interface UserMapper {
    /*User:与.xml（映射文件）文件中的resulType的类型一致
     * queryUserByName：接口的名字和.xml文件（映射文件）的id一致*/
    public User queryUserByName(String userName);
}