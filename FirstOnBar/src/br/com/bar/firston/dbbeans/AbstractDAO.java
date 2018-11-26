package br.com.bar.firston.dbbeans;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import br.com.bar.firston.ConnectionUtils;


public abstract class AbstractDAO {
	
	private static Map<String,String> tableMap;
	
	
	{
		tableMap = new HashMap();
		
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			Document doc = db.parse(AbstractDAO.class.getResourceAsStream("tables.xml"));
			doc.getDocumentElement().normalize();
			System.out.println("Root element "	+ doc.getDocumentElement().getNodeName());
			NodeList nodeLst = doc.getElementsByTagName("table");
			System.out.println("Information of all tables");

			for (int s = 0; s < nodeLst.getLength(); s++) {

				Node fstNode = nodeLst.item(s);

				if (fstNode.getNodeType() == Node.ELEMENT_NODE) {

					Element fstElmnt = (Element) fstNode;
					NodeList fstNmElmntLst = fstElmnt
							.getElementsByTagName("name");
					Element fstNmElmnt = (Element) fstNmElmntLst.item(0);
					NodeList fstNm = fstNmElmnt.getChildNodes();
					System.out.println("Table Name : "
							+ ((Node) fstNm.item(0)).getNodeValue());
					NodeList lstNmElmntLst = fstElmnt
							.getElementsByTagName("classname");
					Element lstNmElmnt = (Element) lstNmElmntLst.item(0);
					NodeList lstNm = lstNmElmnt.getChildNodes();
					System.out.println("Classname Name : "
							+ ((Node) lstNm.item(0)).getNodeValue());
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	public void insert(String tablename, String fields[],String values[]){
		//TODO Implement this facilities
	}
	
	public int insert(String sql){
		int result = 0 ;
		try {
			Connection con  = (Connection) ConnectionUtils.getConnection();
			Statement st = con.createStatement();
			result = st.executeUpdate(sql);
			st.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public List<DAO> getList(String sql,int fieldCount){
		List<DAO> list = new ArrayList<DAO>();
		try {
			Connection con  = (Connection) ConnectionUtils.getConnection();
			Statement st = con.createStatement();
			ResultSet rs  = st.executeQuery(sql);
			String tableName = rs.getMetaData().getTableName(1);
			while(rs.next()){
				for(int i = 1 ; 1<= fieldCount; i++){
					
					Class dao = Class.forName(getClassName(tableName));
					Method[] methods = dao.getMethods();
					
				}
			}
			st.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return list;
	}

	private String getClassName(String tableName) {
		
		return tableMap.get(tableName);
	}
	
	public void main (String args[]){
		AbstractDAO x  = new AbstractDAO() {
			
		};
	}

}
