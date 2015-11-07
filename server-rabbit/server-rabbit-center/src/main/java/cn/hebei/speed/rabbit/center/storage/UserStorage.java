package cn.hebei.speed.rabbit.center.storage;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeoutException;

import lombok.Setter;
import net.rubyeye.xmemcached.MemcachedClient;
import net.rubyeye.xmemcached.exception.MemcachedException;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import cn.hebei.speed.rabbit.center.dao.UserDao;
import cn.hebei.speed.rabbit.center.empty.UserEmpty;

public class UserStorage {
	private static Logger logger = LogManager.getLogger(UserStorage.class.getName());
	@Setter
	private MemcachedClient memcachedClient;
	@Setter
	private UserDao userDao;
	@Setter
	private Integer lifeAge;
	
	public UserEmpty findUser(Long userId){
		if(userId==null){
			logger.debug("参数不完整");
			return null;
		}
		String key="rabbit_user_"+userId;
		UserEmpty user=null;
		try {
			user=(UserEmpty)memcachedClient.get(key);
			if(user!=null){
				return user;
			}
			//执行查询
			logger.debug("===执行用户查询");
			
			//==存入缓存
			memcachedClient.set(key, this.lifeAge, user);
		} catch (TimeoutException e) {
			logger.error("链接memcached超时", e);
		} catch (InterruptedException e) {
			logger.error("链接memcached中断", e);
		} catch (MemcachedException e) {
			logger.error("memcached错误", e);
		}
		
		return user;
	}
	
	/**
	 * 列表获得用户
	 * @param ids
	 * @return
	 */
	public List<UserEmpty> mergeUsers(List<Long> ids){
		List<UserEmpty> users=new ArrayList<UserEmpty>();
		for (Long id : ids) {
			UserEmpty u=this.findUser(id);
			if(u!=null){
				users.add(u);
			}
		}
		return users;	
	}
}
