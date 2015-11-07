package cn.hebei.speed.rabbit.center.service;

import javax.servlet.http.HttpSession;

import com.googlecode.jsonrpc4j.JsonRpcService;

import cn.hebei.speed.rabbit.center.empty.UserEmpty;
import cn.hebei.speed.rabbit.common.response.ResponseBody;

@JsonRpcService("/emp")
public interface EmpJsonService {
	ResponseBody<UserEmpty> show();
}
