package br.ibm.com.json;
/*
*
* IBM Confidential
*
* OCO Source Materials
*
* 5724-R46
*
* (C) COPYRIGHT IBM CORP. 2009
*
* The source code for this program is not published or otherwise
* divested of its trade secrets, irrespective of what has been
* deposited with the U.S. Copyright Office.
*
*/
/**
 * @author rbrossi
 *
 */
public class MapServiceLayerBean {
	
	private Integer layerID;
	private String layerName;
	private String layerGroup;
	private Integer parentId;
	private Integer[] sublayersIds;
	
	public Integer[] getSublayersId() {
		return sublayersIds;
	}
	public void setSublayersId(Integer[] sublayersId) {
		this.sublayersIds = sublayersId;
	}
	public Integer getLayerID() {
		return layerID;
	}
	public void setLayerID(Integer layerID) {
		this.layerID = layerID;
	}
	public String getLayerName() {
		return layerName;
	}
	public void setLayerName(String layerName) {
		this.layerName = layerName;
	}
	public String getLayerGroup() {
		return layerGroup;
	}
	public void setLayerGroup(String layerGroup) {
		this.layerGroup = layerGroup;
	}
	@Override
	public int hashCode() {
		return this.getLayerID().intValue();
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	public boolean contains(int id){
		for (int i = 0; i < sublayersIds.length; i++) {
			if(sublayersIds[i]==id)
				return true;
		}
		return false;	
	}
	
}
