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
import cn.hebei.speed.rabbit.center.empty.AttendClassEmpty;
import cn.hebei.speed.rabbit.center.empty.ClassHeadEmpty;
import cn.hebei.speed.rabbit.center.empty.CommunityEmpty;
import cn.hebei.speed.rabbit.center.empty.PositionEmpty;
import cn.hebei.speed.rabbit.center.empty.StudentEmpty;
import cn.hebei.speed.rabbit.center.empty.TeachEmpty;
import cn.hebei.speed.rabbit.center.empty.TeacherEmpty;
import cn.hebei.speed.rabbit.center.empty.UserEmpty;

public class UserStorage {
	private static Logger logger = LogManager.getLogger(UserStorage.class.getName());
	@Setter
	private MemcachedClient memcachedClient;
	@Setter
	private UserDao userDao;
	@Setter
	private Integer lifeAge;
	
	public UserEmpty findUser(Long userId,Long schoolId){
		if(userId==null||schoolId==null){
			logger.debug("参数不完整");
			return null;
		}
		String key="rabbit_user_"+schoolId+"_"+userId;
		UserEmpty user=null;
		try {
			user=(UserEmpty)memcachedClient.get(key);
			if(user!=null){
				return user;
			}
			//执行查询
			logger.debug("===执行用户查询");
			user=userDao.findUserById(userId);
			//查询教师
			TeacherEmpty te=userDao.findTeacherByUser(userId);
			user.setTeacher(te);
			//查询学生 
			StudentEmpty se=userDao.findStudentByUser(userId);
			user.setStudent(se);
			//查询职位
			PositionEmpty [] pes=userDao.queryPositionByUserAndSchool(userId, schoolId);
			user.setPositions(pes);
			//查询任课
			TeachEmpty [] tes=userDao.queryTeachByUserAndSchool(userId, schoolId);
			user.setTeachs(tes);
			//查询班主任
			ClassHeadEmpty [] che=userDao.queryClassHeadByUserAndSchool(userId, schoolId);
			user.setClassHeads(che);
			//查询就读
			AttendClassEmpty [] ace=userDao.queryAttendClassByUserAndSchool(userId, schoolId);
			user.setAttendClasses(ace);
			//查询管理社团
		    CommunityEmpty [] cie=userDao.queryCommunityHeadByUserAndSchool(userId, schoolId);
			user.setCommunityHeads(cie);
			//查询参与社团
			CommunityEmpty [] cie2=userDao.queryAttendCommunityByUserAndSchool(userId, schoolId);
			user.setAttendCommunities(cie2);
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
	public List<UserEmpty> mergeUsers(List<Long> ids,Long inSchoolId){
		List<UserEmpty> users=new ArrayList<UserEmpty>();
		for (Long id : ids) {
			UserEmpty u=this.findUser(id,inSchoolId);
			if(u!=null){
				users.add(u);
			}
		}
		return users;	
	}
}
