package cn.hebei.speed.rabbit.center.empty;

import lombok.Data;

@Data
public class SchoolEmpty implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3205013429209166636L;
	private Long id;
	private String title;
	private String mark;
	private String icon;
	private String welcome_img;
	private String panorama;
	private String address;
	private Float longitude;
	private Float latitude;
	private String phone;
	private String site;
	private String email;
}
