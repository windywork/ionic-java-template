package cn.hebei.speed.rabbit.center.empty;

import lombok.Data;

@Data
public class ClassHeadEmpty implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5676843939447650482L;
	private Long id;
	private Long course_level_id ;
	private String course_level;
	private Long class_id;
	private String class_name;
	private String year_th;
	private Boolean finish;
	
}
