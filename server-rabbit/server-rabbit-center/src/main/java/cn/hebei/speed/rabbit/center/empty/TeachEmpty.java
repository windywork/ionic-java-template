package cn.hebei.speed.rabbit.center.empty;

import java.util.Date;

import lombok.Data;

@Data
public class TeachEmpty  implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8708913840698950534L;
	private Long id;
	private Long course_level_id;
	private String course_level;
    private Long class_id;
    private String class_name;
    private String year_th;
    private Boolean finish;
    private Long subject_id;
    private String subject_title;
    private Date entry_date;
    
	
}
