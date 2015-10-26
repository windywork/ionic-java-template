package cn.hebei.speed.rabbit.center.empty;

import java.util.Date;

import lombok.Data;

@Data
public class UserEmpty implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2056309779139418430L;
	private Long id;
	private String login_name;
	private String full_name;
	private String picture;
	private char sex;
	private String email;
	private Date last_login_time;
	private String last_login_ip;
	private String remarks;
	
	private TeacherEmpty teacher;
	private StudentEmpty student;
	
	private PositionEmpty [] positions;
	private TeachEmpty [] teachs; 
	private ClassHeadEmpty [] classHeads;
	private AttendClassEmpty [] attendClasses;
	private CommunityEmpty [] communityHeads;
	private CommunityEmpty [] attendCommunities;
	
 }
