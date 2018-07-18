package br.ibm.com.bean;

/**
 * KPI.java represents the Key Point of Interesting bean.
 * 
 * @author Rodrigo Luis Nolli Brossi
 *
 */
public class KPI {

	private String KPI_sector;
	private String KPI_creation_date;
	private String KPI_name;
	private String KPI_value;
	private String KPI_Target;
	private String KPI_value_type;
	private String KPI_source;

	public KPI() {
	}

	public String getKPI_source() {
		return KPI_source;
	}

	public void setKPI_source(String kPI_source) {
		KPI_source = kPI_source;
	}

	public String getKPI_sector() {
		return KPI_sector;
	}

	public void setKPI_sector(String kPI_sector) {
		KPI_sector = kPI_sector;
	}

	public String getKPI_creation_date() {
		return KPI_creation_date;
	}

	public void setKPI_creation_date(String kPI_creation_date) {
		KPI_creation_date = kPI_creation_date;
	}

	public String getKPI_name() {
		return KPI_name;
	}

	public void setKPI_name(String kPI_name) {
		KPI_name = kPI_name;
	}

	public String getKPI_value() {
		return KPI_value;
	}

	public void setKPI_value(String kPI_value) {
		KPI_value = kPI_value;
	}

	public String getKPI_Target() {
		return KPI_Target;
	}

	public void setKPI_Target(String kPI_Target) {
		KPI_Target = kPI_Target;
	}

	public String getKPI_value_type() {
		return KPI_value_type;
	}

	public void setKPI_value_type(String kPI_value_type) {
		KPI_value_type = kPI_value_type;
	}

	public String getKPI_max_value() {
		return KPI_max_value;
	}

	public void setKPI_max_value(String kPI_max_value) {
		KPI_max_value = kPI_max_value;
	}

	public String getKPI_min_value() {
		return KPI_min_value;
	}

	public void setKPI_min_value(String kPI_min_value) {
		KPI_min_value = kPI_min_value;
	}

	private String KPI_max_value;
	private String KPI_min_value;

}
