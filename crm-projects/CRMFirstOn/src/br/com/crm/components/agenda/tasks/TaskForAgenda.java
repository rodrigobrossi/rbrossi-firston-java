package br.com.crm.components.agenda.tasks;

import java.util.Calendar;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0 
 * 
 * This represents a Task for the Agenda Software.
 * 
 */
public class TaskForAgenda {
	
	/**
	 * 
	 */
	private String schedule;
	
	private Calendar start;
	
	private Calendar end;
	
	private Integer User;

	public TaskForAgenda(String schedule, Calendar end, Calendar start, Integer user) {
		super();
		this.schedule = schedule;
		this.start = start;
		this.end = end;
		
		User = user;
	}

	public TaskForAgenda() {
		super();
		
	}

	public String getSchedule() {
		return schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	public Calendar getEnd() {
		return end;
	}

	public void setEnd(Calendar end) {
		this.end = end;
	}

	public Calendar getStart() {
		return start;
	}

	public void setStart(Calendar start) {
		this.start = start;
	}

	public Integer getUser() {
		return User;
	}

	public void setUser(Integer user) {
		User = user;
	}

}
