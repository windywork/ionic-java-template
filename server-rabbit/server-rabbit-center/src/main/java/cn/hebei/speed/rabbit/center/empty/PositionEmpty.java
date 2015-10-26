package cn.hebei.speed.rabbit.center.empty;

import java.util.Date;

import lombok.Data;

@Data
public class PositionEmpty implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -9177815007464015460L;
	private Long id;
	private Long position_id;
	private String position_title;
	private Integer position_level;
	private Date entry_date;
	private Long higher_up;
}
