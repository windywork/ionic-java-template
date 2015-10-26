package cn.hebei.speed.rabbit.common.response;

import java.util.HashMap;

public class MetaData extends HashMap<String, Object> implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6908840052114081755L;

	
	/*
	  200 - 成功
	  404 - 未找到
	  500 - 内部服务器错误
	  530 - 未登录w	
	 */
	public MetaData(){
		this.put("code", 200);
		this.put("message", null);
		this.put("total", 1);
		this.put("pageSize", 1);
	}
	public MetaData(String msg){
		this.put("code", 200);
		this.put("message", msg);
	}
	public MetaData(Integer code,String msg){
		this.put("code", code);
		this.put("message", msg);
	}
}
