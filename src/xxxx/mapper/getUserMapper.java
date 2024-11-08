package xxxx.mapper;

import xxxx.entity.User;

import java.util.List;

public interface getUserMapper {
    User getUserById(int id);
    List<User> getUserList();
}
