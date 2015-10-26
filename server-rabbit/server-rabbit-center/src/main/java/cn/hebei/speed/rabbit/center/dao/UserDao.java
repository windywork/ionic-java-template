package cn.hebei.speed.rabbit.center.dao;

import cn.hebei.speed.rabbit.center.empty.AttendClassEmpty;
import cn.hebei.speed.rabbit.center.empty.ClassHeadEmpty;
import cn.hebei.speed.rabbit.center.empty.CommunityEmpty;
import cn.hebei.speed.rabbit.center.empty.PositionEmpty;
import cn.hebei.speed.rabbit.center.empty.StudentEmpty;
import cn.hebei.speed.rabbit.center.empty.TeachEmpty;
import cn.hebei.speed.rabbit.center.empty.TeacherEmpty;
import cn.hebei.speed.rabbit.center.empty.UserEmpty;

public interface UserDao {
	Long findUserOnLogin(String loginName,String password,Long schoolId);
	UserEmpty findUserById(Long userId);
	TeacherEmpty findTeacherByUser(Long userId);
	StudentEmpty findStudentByUser(Long userId);
	PositionEmpty [] queryPositionByUserAndSchool(Long userId,Long schoolId);
	TeachEmpty []  queryTeachByUserAndSchool(Long userId,Long schoolId);
	ClassHeadEmpty []  queryClassHeadByUserAndSchool(Long userId,Long schoolId);
	AttendClassEmpty []  queryAttendClassByUserAndSchool(Long userId,Long schoolId);
	CommunityEmpty []  queryCommunityHeadByUserAndSchool(Long userId,Long schoolId);
	CommunityEmpty [] queryAttendCommunityByUserAndSchool(Long userId,Long schoolId);
	
}
