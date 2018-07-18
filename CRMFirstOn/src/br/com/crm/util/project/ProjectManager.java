package br.com.crm.util.project;

public class ProjectManager {
	
	private Integer selectedCotact;

	public static final ProjectManager projetcManger = new ProjectManager();

	private ProjectManager() {

	}

	public static ProjectManager getIsntance() {

		return projetcManger;
	}

	public Integer getSelectedCotact() {
		return selectedCotact;
	}

	public void setSelectedCotact(Integer selectedCotact) {
		this.selectedCotact = selectedCotact;
	}
}
