package cn.hebei.speed.rabbit.center.service.impl;

import org.springframework.stereotype.Service;

import cn.hebei.speed.rabbit.center.empty.UserEmpty;
import cn.hebei.speed.rabbit.center.service.EmpJsonService;
import cn.hebei.speed.rabbit.common.response.ResponseBody;

@Service
public class EmpJsonServiceImpl implements EmpJsonService {

	
	@Override
	public ResponseBody<UserEmpty> show() {
		UserEmpty user=new UserEmpty();
		user.setFull_name("zs");
		return new ResponseBody<UserEmpty>(user);
	}

}
