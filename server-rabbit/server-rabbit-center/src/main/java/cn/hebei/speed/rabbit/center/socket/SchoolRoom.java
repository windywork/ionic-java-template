package cn.hebei.speed.rabbit.center.socket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.Vector;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;

@Getter
@Setter
public class SchoolRoom implements java.io.Serializable {
	private static Logger logger = LogManager.getLogger(SchoolRoom.class
			.getName());

	/**
	 * 
	 */
	private static final long serialVersionUID = 8419379048004320846L;
	private Long school_id;
	private Map<Long, Set<Client>> students = new HashMap<Long, Set<Client>>();
	private Map<Long, Set<Client>> communities = new HashMap<Long, Set<Client>>();
	private Set<Client> teacher = new TreeSet<Client>();

	private Set<Client> clients = new TreeSet<Client>();

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Integer && obj != null) {
			return Long.parseLong(obj.toString()) == this.getSchool_id()
					.longValue();
		} else if (obj instanceof Long && obj != null) {
			return ((Long) obj).longValue() == this.getSchool_id().longValue();
		}
		return false;
	}

	/**
	 * 添加客户到学校
	 * 
	 * @param session
	 * @return
	 */
	public synchronized boolean addClient(WebSocketSession session) {
		logger.debug("开始进入房间:" + school_id);

		if (session == null) {
			logger.debug("Session 不能为空");
			return false;
		}
		Map<String, Object> attribs = session.getAttributes();
		Long current_school = (Long) attribs.get("current_school"); // 当前学校
		Long user_id = (Long) attribs.get("user_id"); // 当前登录用户
		Long[] class_id = (Long[]) attribs.get("class_id"); // 所在学校-就读班级-班级编号
		Long[] teach_id = (Long[]) attribs.get("teach_id"); // 所在学校-学校任课-任课编号
		Long[] position_id = (Long[]) attribs.get("position_id"); // 所在学校-学校任职-职位编号
		Long[] class_head = (Long[]) attribs.get("class_head"); // 所在学校-管理班级-班级编号
		Long[] community_id = (Long[]) attribs.get("community_id"); // 所在学校-参与社团-社团编号
		Long[] community_head = (Long[]) attribs.get("community_head"); // 所在学校-管理社团-社团编号
		if (current_school.longValue() != this.school_id.longValue()) {
			logger.debug("不能进入该校等级");
			return false;
		}
		// 进入学校
		Client ci = this.findClientByUserId(user_id);
		if (ci != null) {
			ci.addSession(session);
		} else {
			ci = new Client();
			ci.setUser_id(user_id);
			ci.addSession(session);
			clients.add(ci);
			// 添加班级学生组
			if (class_id != null) {
				for (Long classId : class_id) {
					Set<Client> ccs = students.get(classId);
					if (ccs == null) {
						ccs = new TreeSet<Client>();
						students.put(classId, ccs);
					}
					ccs.add(ci);
				}
			}
			// 添加老师组
			if (teach_id != null && teach_id.length > 0) {
				teacher.add(ci);
			}
			if (position_id != null && position_id.length > 0) {
				teacher.add(ci);
			}
			if (class_head != null && class_head.length > 0) {
				teacher.add(ci);
			}
			// 社团
			if (community_id != null) {
				for (Long communityId : community_id) {
					Set<Client> ccs = communities.get(communityId);
					if (ccs == null) {
						ccs = new TreeSet<Client>();
						communities.put(communityId, ccs);
					}
					ccs.add(ci);
				}
			}
			if (community_head != null) {
				for (Long communityHead : community_head) {
					Set<Client> ccs = communities.get(communityHead);
					if (ccs == null) {
						ccs = new TreeSet<Client>();
						communities.put(communityHead, ccs);
					}
					ccs.add(ci);
				}
			}
		}
		logger.debug("进入房间:schoolId-" + this.school_id);
		this.printRoom();
		return true;

	}

	private void printRoom() {
		System.out.println("=====打印房间=======");
		System.out.println("School ID: " + this.school_id);
		System.out.println("Client Count: " + this.clients.size());
		System.out.println("Teacher Count: " + this.teacher.size());
		System.out.println("Class:");
		for (Long class_id : this.students.keySet()) {
			System.out.println("\t - " + class_id + ": "
					+ this.students.get(class_id).size());
		}
		System.out.println("Communities:");
		for (Long community_id : this.communities.keySet()) {
			System.out.println("\t - " + community_id + ": "
					+ this.communities.get(community_id).size());
		}
		System.out.println("打印连接:");
		for (Client client : clients) {
			System.out.println("\t - " + client.getUser_id() + ": "
					+ client.getSessions().size());
		}
		System.out.println("=====打印房间结束=======");
	}

	/**
	 * 移除用户再该校
	 * 
	 * @param session
	 * @return
	 */

	public synchronized boolean removeClient(WebSocketSession session) {
		int removeCount = 0;
		Map<String, Object> attribs = session.getAttributes();
		Long user_id = (Long) attribs.get("user_id"); // 当前登录用户
		Long[] class_id = (Long[]) attribs.get("class_id"); // 所在学校-就读班级-班级编号
		Long[] community_id = (Long[]) attribs.get("community_id"); // 所在学校-参与社团-社团编号
		Long[] community_head = (Long[]) attribs.get("community_head"); // 所在学校-管理社团-社团编号

		Client client = this.findClientByUserId(user_id);
		if (client == null) {
			logger.debug("用户再该校没有登记");
			return false;
		}
		client.removeSession(session);
		if (client.getSessions().size() > 0) {
			logger.debug("移除该连接,但仍用连接占该用户");
			this.printRoom();
			return true;
		}
		logger.debug("清扫改用户在整个房间");
		clients.remove(client);
		// 班级
		List<Client> t_clts = new ArrayList<Client>();
		if (class_id != null) {
			for (Long classId : class_id) {
				Set<Client> cc = this.students.get(classId);
				if (cc != null)
					for (Client c : cc) {
						if (c.getUser_id().longValue() == user_id.longValue()) {
							t_clts.add(c);
						}
					}
				for (Client c : t_clts) {
					this.students.get(classId).remove(c);
					removeCount++;
				}
				t_clts.clear();
			}
		}
		// 老师
		for (Client c : teacher) {
			if (c.getUser_id().longValue() == user_id.longValue()) {
				t_clts.add(c);
			}
		}
		for (Client c : t_clts) {
			teacher.remove(c);
			removeCount++;
		}
		t_clts.clear();
		// 社团
		if (community_id != null) {
			for (Long communityId : community_id) {
				Set<Client> ccs = communities.get(communityId);
				for (Client c : ccs) {
					if (c.getUser_id().longValue() == user_id.longValue()) {
						t_clts.add(c);
					}
				}
				for (Client c : t_clts) {
					ccs.remove(c);
					removeCount++;
				}
				t_clts.clear();
			}
		}
		if (community_head != null) {
			for (Long communityHead : community_head) {
				Set<Client> ccs = communities.get(communityHead);
				if (ccs != null)
					for (Client c : ccs) {
						if (c.getUser_id().longValue() == user_id.longValue()) {
							t_clts.add(c);
						}
					}
				for (Client c : t_clts) {
					ccs.remove(c);
					removeCount++;
				}
				t_clts.clear();
			}
		}
		this.printRoom();
		return removeCount > 0;
	}

	/**
	 * 发送动作消息
	 * 
	 * @param client
	 * @param handler
	 * @param value
	 */
	private void sendHandlerMessage(Client client, String handler, Object value) {
		HandlerMessage msg = new HandlerMessage();
		msg.setHandler(handler);
		msg.setValue(value);
		for (WebSocketSession s : client.getSessions()) {
			try {
				s.sendMessage(new TextMessage(new Gson().toJson(msg)));
				logger.debug("推送数据到客户端 - userid:"+client.getUser_id());
			} catch (IOException e) {
				logger.error("向客户端发送消息发生错误", e);
			}
		}

	}

	/**
	 * 根据用户编号获得客户对象
	 * 
	 * @param userId
	 * @return
	 */
	private Client findClientByUserId(Long userId) {
		for (Client client : this.clients) {
			if (client.getUser_id().longValue() == userId.longValue()) {
				return client;
			}
		}
		return null;
	}

	/**
	 * 向所有用户发送消息
	 * 
	 * @param handler
	 * @param value
	 */
	public void sendAll(String handler, Object value) {
		for (Client client : clients) {
			this.sendHandlerMessage(client, handler, value);
		}
	}

	/**
	 * 向全部学生发送消息
	 * 
	 * @param handler
	 * @param value
	 */
	public void sendOnStudent(String handler, Object value) {
		// 搜集学生
		Set<Client> students = new HashSet<Client>();
		for (Long cid : this.students.keySet()) {
			for (Client ci : this.students.get(cid)) {
				students.add(ci);
			}
		}
		// 发送
		for (Client client : students) {
			this.sendHandlerMessage(client, handler, value);
		}
	}

	/**
	 * 向班级发送消息
	 * 
	 * @param class_id
	 * @param handler
	 * @param value
	 */
	public void sendOnClass(Long class_id, String handler, Object value) {
		Set<Client> cc = this.students.get(class_id);
		for (Client ci : cc) {
			this.sendHandlerMessage(ci, handler, value);
		}
	}

	/**
	 * 
	 * 向全部老师发送消息
	 * 
	 * @param handler
	 * @param value
	 */
	public void sendOnTeacher(String handler, Object value) {
		Set<Client> cc = this.teacher;
		for (Client ci : cc) {
			this.sendHandlerMessage(ci, handler, value);
		}
	}

	/**
	 * 
	 * 向社团发送消息
	 * 
	 * @param handler
	 * @param value
	 */
	public void sendOnCommunity(Long community_id, String handler, Object value) {
		Set<Client> cc = this.communities.get(community_id);
		for (Client ci : cc) {
			this.sendHandlerMessage(ci, handler, value);
		}
	}

	/**
	 * 向某用户发送消息
	 * 
	 * @param userId
	 * @param handler
	 * @param value
	 */
	public void sendByUserId(Long userId, String handler, Object value) {
		Client ci = this.findClientByUserId(userId);
		this.sendHandlerMessage(ci, handler, value);
	}

	/**
	 * 根据用户编号获得session
	 * 
	 * @param userId
	 * @return
	 */
	public List<WebSocketSession> findSessionByUserId(Long userId) {
		Client c = this.findClientByUserId(userId);
		if (c != null) {
			return c.getSessions();
		} else {
			return null;
		}
	}

	/**
	 * 判断是否有该用户在该校
	 * 
	 * @param userId
	 * @return
	 */
	public boolean hasUser(Long userId) {
		Client c = this.findClientByUserId(userId);
		if (c != null) {
			return true;
		} else {
			return false;
		}
	}

}

@Data
class Client implements Comparable<Client> {
	private Long user_id;
	private Vector<WebSocketSession> sessions;

	@Override
	public int compareTo(Client o) {
		if (o.user_id.longValue() > this.user_id.longValue()) {
			return 1;
		} else if (o.user_id.longValue() == this.user_id.longValue()) {
			return 0;
		} else {
			return -1;
		}
	}

	public void addSession(WebSocketSession session) {
		if (this.sessions == null) {
			this.sessions = new Vector<WebSocketSession>();
		}
		this.sessions.add(session);
	}

	public boolean removeSession(WebSocketSession session) {
		if (this.sessions != null) {
			return this.sessions.remove(session);
		} else {
			return false;
		}
	}

}

@Data
class HandlerMessage implements java.io.Serializable {
	private static final long serialVersionUID = 3025960425898183113L;
	private String handler;
	private Object value;
}
