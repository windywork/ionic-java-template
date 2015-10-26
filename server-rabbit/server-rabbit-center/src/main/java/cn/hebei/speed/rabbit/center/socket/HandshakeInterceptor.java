package cn.hebei.speed.rabbit.center.socket;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;



public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{  
	  
	private static Logger logger = LogManager.getLogger(HandshakeInterceptor.class
			.getName());
	
    @Override  
    public boolean beforeHandshake(ServerHttpRequest request,  
            ServerHttpResponse response, WebSocketHandler wsHandler,  
            Map<String, Object> attributes) throws Exception { 
    	//ServletServerHttpRequest serverRequest = (ServletServerHttpRequest) request;
		//HttpSession session=serverRequest.getServletRequest().getSession(false);
		
    	boolean b=super.beforeHandshake(request, response, wsHandler, attributes);
    	
    	if(!b){
    		return false;
    	}
    	//判断是否有该有数据
    	Long schoolId=(Long)attributes.get("current_school");
    	Long userId=(Long)attributes.get("user_id");
    	if(schoolId==null||userId==null){
    		logger.debug("不能直接连接,请登录处理后连接");
    		return false;
    	}
    	logger.debug("客户端握手:"+schoolId+","+userId);
    	return true;
    }  
    
  

	@Override  
    public void afterHandshake(ServerHttpRequest request,  
            ServerHttpResponse response, WebSocketHandler wsHandler,  
            Exception ex) { 
        super.afterHandshake(request, response, wsHandler, ex);  
    }  
    
    
  
}  