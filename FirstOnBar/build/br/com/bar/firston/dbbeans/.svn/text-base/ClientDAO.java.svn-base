package br.com.bar.firston.dbbeans;

import java.util.List;

public class ClientDAO extends AbstractDAO implements DAO{
	
	private String  name ;
	private String phone ;
	private String email;
	private String cep;

	public void delete() {
		// TODO Auto-generated method stub
		
	}

	public ClientDAO(String name, String phone, String email, String cep) {
		super();
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.cep = cep;
	}

	public List<DAO> geList() {
		return null;
	}

	public int  insert() {
	return super.insert("Insert into CLIENT(CLI_NAME,CLI_CEP,CLI_PHONE)"
			+" values ('"+this.getName()+"','"+this.getCep()+"','"+this.getPhone()+"')");	
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}
	
	

}
