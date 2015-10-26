package cn.hebei.speed.rabbit.center.empty;

import java.util.Date;

import lombok.Data;

@Data
public class AttendClassEmpty implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6412932348786306047L;
	private Long id;
	private Long course_level_id;
	private String course_level;
	private Long class_id;
	private String class_name;
	private String  year_th;
	private Boolean finish;
	private Date enter_date;
}
