package xxxx.mapper;

import xxxx.entity.Admin;
import xxxx.entity.User;

public interface AdminMapper {
    public Admin queryAdminByName(String userName);
}
