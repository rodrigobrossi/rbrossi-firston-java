package br.com.crm.components.news;

import java.util.List;

public interface INewsModel {
	
	public void add(NewsObject newsObject);
	public void remove(NewsObject newsObject);
	public NewsObject get(int id);
	public String getNewsFrom(int id);
	public List getAllNews();
	

}
