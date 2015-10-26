package cn.hebei.speed.rabbit.center.empty;

import java.util.Date;

import lombok.Data;

@Data
public class StudentEmpty implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8717165125250436589L;
	private Long id;
	private Long user_id;
	private Date birthdate;
	private String address;
	private String hobbies;
	private String qq;
}
