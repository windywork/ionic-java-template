package cn.hebei.speed.rabbit.center.empty;

import java.util.Date;

import lombok.Data;

@Data
public class TeacherEmpty implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1927811465281710847L;
	private Long id;
	private Long user_id;
	private String identity_card;
	private String phone;
	private Date birthday;
	private String affiliation;
	private String address;
	private String positional;
	private String recommend;
	private String education;
	private Date arrival_time;
	private Integer heat;
	
}
