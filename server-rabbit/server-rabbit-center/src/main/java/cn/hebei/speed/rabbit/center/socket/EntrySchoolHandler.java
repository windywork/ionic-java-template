package cn.hebei.speed.rabbit.center.socket;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


public class EntrySchoolHandler extends TextWebSocketHandler {
	private static Logger logger = LogManager.getLogger(EntrySchoolHandler.class
			.getName());

	private static final Map<Long, SchoolRoom> schools;

	static {
		schools = new HashMap<Long, SchoolRoom>();
	}

	public String getHttpSessionId(WebSocketSession session) {
		String session_id = (String) session.getAttributes().get(
				"HTTP.SESSION.ID");
		return session_id;
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		Long schoolId = (Long) session.getAttributes().get("current_school");
		SchoolRoom schoolRoom = schools.get(schoolId);
		if (schoolRoom == null) {
			schoolRoom = new SchoolRoom();
			schoolRoom.setSchool_id(schoolId);
			schools.put(schoolId, schoolRoom);
		}
		boolean b = schoolRoom.addClient(session);
		logger.debug("进入学校房间 ["+schoolId+"] : " + b);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session,
			CloseStatus status) throws Exception {
		logger.debug("开始断开连接..");
		Long schoolId = (Long) session.getAttributes().get("current_school");
		SchoolRoom schoolRoom = schools.get(schoolId);
		boolean b=schoolRoom.removeClient(session);
		logger.debug("退出学校房间 ["+schoolId+"] : " + b);
	}

	@Override
	public void handleTransportError(WebSocketSession session,
			Throwable throwable) throws Exception {
		logger.debug("发生错误断开连接..");
		try{
		Long schoolId = (Long) session.getAttributes().get("current_school");
		SchoolRoom schoolRoom = schools.get(schoolId);
		if (session.isOpen()) {
			logger.debug("....开始断开连接");
			session.close();
		}else{
			boolean b=schoolRoom.removeClient(session);
			logger.debug("发生错误,退出学校房间 ["+schoolId+"] : " + b);
		}
	
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public boolean supportsPartialMessages() {
		return false;
	}

	@Override
	protected void handleTextMessage(WebSocketSession session,
			TextMessage message) throws Exception {

		super.handleTextMessage(session, message);
		TextMessage returnMessage = new TextMessage(message.getPayload()
				+ " received at server");
		session.sendMessage(returnMessage);
	}
	/**
	 * 用户退出
	 * @param userId
	 * @return
	 */
	public boolean loginoutUser(Long userId,Long schoolId){
		SchoolRoom sroom=schools.get(schoolId);
		if(sroom!=null){
			List<WebSocketSession>  sessions=sroom.findSessionByUserId(userId);
			for (WebSocketSession session : sessions) {
				try {
					session.close();
				} catch (IOException e) {
					logger.error("客户端退出发生错误",e);
				}
			}
			return true;
		}
		return false;
	}
	/**
	 * 用户是否登录
	 * @param userId
	 * @return
	 */
	public boolean hasUser(Long userId,Long schoolId){
		SchoolRoom sroom=schools.get(schoolId);
		if(sroom!=null){
			return sroom.hasUser(userId);
		}
		return false;
	}
	
	public SchoolRoom getSchoolRoom(Long schoolId){
		return schools.get(schoolId);
	}

}