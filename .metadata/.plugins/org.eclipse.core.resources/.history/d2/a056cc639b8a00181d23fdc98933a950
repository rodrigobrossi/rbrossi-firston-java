<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,br.ibm.com.bean.KPI"%>

<%
	//List of meters according with KPIs
	//shoud be a div

	try {
		Class.forName("org.postgresql.Driver");
		Connection connection = DriverManager.getConnection(
				"jdbc:postgresql://localhost:5432/RSD", "postgres",
				"kazu99");

		Statement stmt = connection.createStatement();

		StringBuffer sbf = new StringBuffer(
				"SELECT DISTINCT ON (kpi_name) kpi_name,");
		sbf.append("kpi_creation,");
		sbf.append("kpi_value,");
		sbf.append("kpi_target,");
		sbf.append("kpi_sector,");
		sbf.append("kpi_value_type,");
		sbf.append("kpi_max_value,");
		sbf.append("kpi_min_value,");
		sbf.append("kpi_source");
		sbf.append(" from RSD_KPIMAP ");
		sbf.append(" ORDER BY kpi_name, kpi_creation DESC");

		ResultSet rs = stmt.executeQuery(sbf.toString());

		ArrayList<KPI> kpis = new ArrayList<KPI>();
		while (rs.next()) {
			KPI kpi = new KPI();
			kpi.setKPI_name(rs.getString(1));
			kpi.setKPI_creation_date(rs.getString(2));
			kpi.setKPI_value(rs.getString(3));
			kpi.setKPI_Target(rs.getString(4));
			kpi.setKPI_sector(rs.getString(5));
			kpi.setKPI_value_type(rs.getString(6));
			kpi.setKPI_max_value(rs.getString(7));
			kpi.setKPI_min_value(rs.getString(8));
			kpi.setKPI_source(rs.getString(9));
			kpis.add(kpi);
		}

		// Closing Connections
		rs.close();
		stmt.close();
		connection.close();
		Thread.sleep(2000);

		if (kpis.size() != 0) {//Start IF-ELSE no data available

			for (int i = 0; i < kpis.size();) {
				/*HTML response for KPI feture*/
%>
<table>
	<tbody>

		<tr>
			<%
				for (int j = 0; j < 3 && i < kpis.size(); j++, i++) {
								KPI kpi = kpis.get(i);

								String value = ((Integer.parseInt(kpi
										.getKPI_value()) <= 0) ? "RED" : "GREEN");
								
								
								String name = (kpi.getKPI_name().length()<=25)?kpi.getKPI_name(): kpi.getKPI_name().substring(0,25)+"...";
			%>
			<td align="left" class="drop-shadow lifted" width="220px"
				height="150px" style="marginpadding-bottom: 5px; margin-right: 5px"
				valign="middle" alt="<%=kpi.getKPI_name()%>"> <%=name%> <br> <font
				face="Helvetica" size="19" color="<%=value%>"><blink><%=kpi.getKPI_value()%></blink></font>
				<br> Target: <%=kpi.getKPI_Target()%> <br> Actual Value: <%=kpi.getKPI_value()%>

				<br> <meter id="meter_<%=kpi.getKPI_name()%>"
					max="<%=kpi.getKPI_max_value()%>" value="<%=kpi.getKPI_value()%>">
					<%=kpi.getKPI_name()%>
				</meter></td>
			<%
				}
			%>
		</tr>
	</tbody>
</table>
<%
	}
		} else {
%>

<table>
	<tbody>

		<tr>
			<td><font face="Helvetica" size="19" color="GREEN"><blink>NO
						DATA AVAILABEL</blink></font></td>
		</tr>
	</tbody>
</table>



<%
	}//End of ELSE


	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
%>
