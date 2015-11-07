package cn.hebei.speed.rabbit.center.service.impl;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.hebei.speed.rabbit.center.dao.UserDao;
import cn.hebei.speed.rabbit.center.empty.UserEmpty;
import cn.hebei.speed.rabbit.center.service.UserService;
import cn.hebei.speed.rabbit.center.socket.EntrySchoolHandler;
import cn.hebei.speed.rabbit.common.response.ResponseBody;
import cn.hebei.speed.rabbit.common.util.MD5Util;

@Service
public class UserServiceImpl implements UserService {

	private static Logger logger = LogManager.getLogger(UserServiceImpl.class
			.getName());
	

	@Autowired
	public UserDao userDao = null;
	//@Autowired
	//public UserStorage userStorage = null;
	@Autowired
	public EntrySchoolHandler entrySchoolHandler=null;
	
	
	

	@Override
	public ResponseBody<UserEmpty> login(String loginName, String password,
			String captcha, HttpSession s) {
	
		Long userId=userDao.findUserOnLogin(loginName, MD5Util.MD5(password));
		if(userId==null){
			return new ResponseBody<UserEmpty>(403,"用户名或密码错误");
		}
		
		UserEmpty user=userDao.findUserById(userId);
		//======设置session
		s.setAttribute("user_id", user.getId());
	
		//返回
		return new ResponseBody<UserEmpty>(user);
	}

	@Override
	public ResponseBody<Boolean> loginout(HttpSession s) {
		//  退出学校房间,清除Session
		Long schoolId=(Long)s.getAttribute("current_school");
		Long userId=(Long)s.getAttribute("user_id");
		if(schoolId==null||userId==null){
			return new ResponseBody<Boolean>(403,"请先登录学校");
		}
		boolean b=entrySchoolHandler.loginoutUser(userId, schoolId);
		logger.debug("用户退出:"+b);
		s.removeAttribute("user_id");
		s.removeAttribute("class_id");
		s.removeAttribute("teach_id");
		s.removeAttribute("position_id");
		s.removeAttribute("class_head");
		s.removeAttribute("community_head");
		s.removeAttribute("community_id");
		return  new ResponseBody<Boolean>(true);
	}

}
