package cn.hebei.speed.rabbit.common.response;

public class ResponseBody<E> implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6477514249622553669L;
	private MetaData meta;
	private E data;
	public ResponseBody(){
		this.setMeta(new MetaData());
		this.setData(null);
	}
	public ResponseBody(E data){
		this.setMeta(new MetaData());
		this.setData(data);
	}
	public ResponseBody(Integer code,String msg){
		this.setMeta(new MetaData(code,msg));
		this.setData(null);
	}
	public ResponseBody(Integer code,String msg,E data){
		this.setMeta(new MetaData(code,msg));
		this.setData(data);
	}
	public ResponseBody(MetaData meta,E data){
		this.setMeta(meta);
		this.setData(data);
	}
	public MetaData getMeta() {
		return meta;
	}
	public void setMeta(MetaData meta) {
		this.meta = meta;
	}
	public E getData() {
		return data;
	}
	public void setData(E data) {
		this.data = data;
	}
	
	
}
