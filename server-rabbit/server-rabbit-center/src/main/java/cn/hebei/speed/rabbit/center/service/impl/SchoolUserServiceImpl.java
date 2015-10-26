package cn.hebei.speed.rabbit.center.service.impl;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.hebei.speed.rabbit.center.dao.SchoolDao;
import cn.hebei.speed.rabbit.center.dao.UserDao;
import cn.hebei.speed.rabbit.center.empty.AttendClassEmpty;
import cn.hebei.speed.rabbit.center.empty.ClassHeadEmpty;
import cn.hebei.speed.rabbit.center.empty.CommunityEmpty;
import cn.hebei.speed.rabbit.center.empty.PositionEmpty;
import cn.hebei.speed.rabbit.center.empty.SchoolEmpty;
import cn.hebei.speed.rabbit.center.empty.TeachEmpty;
import cn.hebei.speed.rabbit.center.empty.UserEmpty;
import cn.hebei.speed.rabbit.center.service.SchoolUserService;
import cn.hebei.speed.rabbit.center.socket.EntrySchoolHandler;
import cn.hebei.speed.rabbit.center.socket.SchoolRoom;
import cn.hebei.speed.rabbit.center.storage.UserStorage;
import cn.hebei.speed.rabbit.common.response.ResponseBody;
import cn.hebei.speed.rabbit.common.util.MD5Util;

@Service
public class SchoolUserServiceImpl implements SchoolUserService {

	private static Logger logger = LogManager.getLogger(SchoolUserServiceImpl.class
			.getName());
	
	@Autowired
	public SchoolDao schoolDao = null;
	@Autowired
	public UserDao userDao = null;
	@Autowired
	public UserStorage userStorage = null;
	@Autowired
	public EntrySchoolHandler entrySchoolHandler=null;
	
	
	@Override
	public ResponseBody<SchoolEmpty> enterSchool(Long schoolId, HttpSession s) {
		
		SchoolEmpty school=schoolDao.findSchoolById(schoolId);
		if(school!=null){
			logger.debug("\n===========================\n进入学校:"+school.getTitle()+"\n=================\n");
			s.setAttribute("current_school", school.getId());
			return new ResponseBody<SchoolEmpty>(school);
		}else{
			return new ResponseBody<SchoolEmpty>(404,"学校未找到",school);
		}
	}
	

	@Override
	public ResponseBody<UserEmpty> login(String loginName, String password,
			String captcha, HttpSession s) {
		Long schoolId=(Long)s.getAttribute("current_school");
		if(schoolId==null){
			return new ResponseBody<UserEmpty>(403,"请先登录学校");
		}
		Long userId=userDao.findUserOnLogin(loginName, MD5Util.MD5(password),schoolId);
		if(userId==null){
			return new ResponseBody<UserEmpty>(403,"用户名或密码错误");
		}
		UserEmpty user=userStorage.findUser(userId,schoolId);
		//======设置session
		s.setAttribute("user_id", user.getId());
		//-就读班级
		AttendClassEmpty [] aces=user.getAttendClasses();
		Long [] saces=new Long [aces.length];
		for(int i=0;i<aces.length;i++){
			saces[i]=aces[i].getClass_id();
		}
		s.setAttribute("class_id", saces);
		//-任课班级
		TeachEmpty [] tes=user.getTeachs();
		Long [] stes=new Long [tes.length];
		for(int i=0;i<tes.length;i++){
			stes[i]=tes[i].getId();
		}
		s.setAttribute("teach_id", stes);
		//-学校任职
		 PositionEmpty [] pes=user.getPositions();
		 Long [] spes=new Long[pes.length];
		 for(int i=0;i<pes.length;i++){
			 spes[i]=pes[i].getId();
		 }
		s.setAttribute("position_id", spes);
		//-班主任
		ClassHeadEmpty [] ches=user.getClassHeads();
		Long [] sches=new Long[ches.length];
		for(int i=0;i<ches.length;i++){
			sches[i]=ches[i].getId();
		}
		s.setAttribute("class_head", sches);
		//-社团管理
		CommunityEmpty [] ces=user.getCommunityHeads();
		Long [] sces=new Long[ces.length];
		for(int i=0;i<ces.length;i++){
			sces[i]=ces[i].getCommunity_id();
		}
		s.setAttribute("community_head", sces);
		//-加入社团
		CommunityEmpty [] cies=user.getAttendCommunities();
		Long [] scies=new Long[cies.length];
		for(int i=0;i<cies.length;i++){
			scies[i]=cies[i].getCommunity_id();
		}
		s.setAttribute("community_id", scies);
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

	@Override
	public ResponseBody<UserEmpty> getCurrentUser(HttpSession s) {
		Long userId=(Long)s.getAttribute("user_id");
		Long schoolId=(Long)s.getAttribute("current_school");
		if(schoolId==null||userId==null){
			return new ResponseBody<UserEmpty>(403,"请先登录学校");
		}
		UserEmpty user=userStorage.findUser(userId, schoolId);
		return new ResponseBody<UserEmpty>(user);
	}

	@Override
	public ResponseBody<SchoolEmpty> getCurrentSchool(HttpSession s) {
		Long schoolId=(Long)s.getAttribute("current_school");
		if(schoolId==null){
			return new ResponseBody<SchoolEmpty>(403,"请先进入学校");
		}
		SchoolEmpty school=schoolDao.findSchoolById(schoolId);
		return new ResponseBody<SchoolEmpty>(school);
	}


	@Override
	public void sendMsg() {
		SchoolRoom room=entrySchoolHandler.getSchoolRoom(1L);
		room.sendAll("hasMsg", "哈哈");
	}

}
