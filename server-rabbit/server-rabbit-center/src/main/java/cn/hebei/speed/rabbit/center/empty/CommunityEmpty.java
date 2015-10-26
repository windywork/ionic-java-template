package cn.hebei.speed.rabbit.center.empty;

import lombok.Data;

@Data
public class CommunityEmpty implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1433936020009545532L;
	private Long id;
	private Long community_id;
	private String community_title;
	private String recommend;
	private String community_icon;
	private String community_picture;
	private String community_remarks;
}
