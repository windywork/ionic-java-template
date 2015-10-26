package cn.hebei.speed.rabbit.center.service;

import javax.servlet.http.HttpSession;

import cn.hebei.speed.rabbit.center.empty.SchoolEmpty;
import cn.hebei.speed.rabbit.center.empty.UserEmpty;
import cn.hebei.speed.rabbit.common.response.ResponseBody;

public interface SchoolUserService {
	/**
	 * 
	 * 进入学校
	 * @param schoolId 学校编号
	 * @param s 
	 * @return
	 */
	ResponseBody<SchoolEmpty> enterSchool(Long schoolId,HttpSession s);
	
	/**
	 * 用户登录方法
	 * @param loginName 用户名
	 * @param password 密码
	 * @param captcha 验证码
	 * @return
	 */
	ResponseBody<UserEmpty> login(String loginName, String password,
			String captcha,HttpSession session);
	
	/**
	 * 退出用户
	 * @param session
	 * @return
	 */
	ResponseBody<Boolean> loginout(HttpSession session);
	
	/**
	 * 获得当前用户
	 * @param s
	 * @return
	 */
	 ResponseBody<UserEmpty> getCurrentUser(HttpSession s);
	 
	 /**
	 * 获得当前学校
	 * @param s
	 * @return
	 */
	ResponseBody<SchoolEmpty> getCurrentSchool(HttpSession s);
	
	void sendMsg();
}
