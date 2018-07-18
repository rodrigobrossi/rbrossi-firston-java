package br.ibm.com.json.api;
/*
*
* IBM Confidential
*
* OCO Source Materials
*
* 5724-R46
*
* (C) COPYRIGHT IBM CORP. 2006,2007
*
* The source code for this program is not published or otherwise
* divested of its trade secrets, irrespective of what has been
* deposited with the U.S. Copyright Office.
*
*/

/**
 * The <code>JSONString</code> interface allows a <code>toJSONString()</code> 
 * method so that a class can change the behavior of 
 * <code>JSONObject.toString()</code>, <code>JSONArray.toString()</code>,
 * and <code>JSONWriter.value(</code>Object<code>)</code>. The 
 * <code>toJSONString</code> method will be used instead of the default behavior 
 * of using the Object's <code>toString()</code> method and quoting the result.
 */
public interface JSONString {
	/**
	 * The <code>toJSONString</code> method allows a class to produce its own JSON 
	 * serialization. 
	 * 
	 * @return A strictly syntactically correct JSON text.
	 */
	public String toJSONString();
}
