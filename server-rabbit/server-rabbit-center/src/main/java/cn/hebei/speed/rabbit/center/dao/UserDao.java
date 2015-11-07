package cn.hebei.speed.rabbit.center.dao;
import cn.hebei.speed.rabbit.center.empty.UserEmpty;
public interface UserDao {
	Long findUserOnLogin(String loginName,String password);
	UserEmpty findUserById(Long id);
}
