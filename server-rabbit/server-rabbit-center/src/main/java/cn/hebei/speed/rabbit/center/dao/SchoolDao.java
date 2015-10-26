package cn.hebei.speed.rabbit.center.dao;

import cn.hebei.speed.rabbit.center.empty.SchoolEmpty;

public interface SchoolDao {
	SchoolEmpty findSchoolById(Long schoolId);
}
