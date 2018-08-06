package br.ibm.com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hornetq.utils.json.JSONArray;
import org.hornetq.utils.json.JSONException;
import org.hornetq.utils.json.JSONObject;

/**
 * Servlet implementation class RSDListDataServlet
 * 
 * @author Rodrigo Luis Nolli Brossi
 *
 *         This Servlet will be used to build the JSON structure.
 */
public class RSDListDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RSDListDataServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.processRequest(request, response);
	}

	/**
	 * Method to get both GET and POST requests
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @throws ServletException
	 * @throws IOException
	 */
	private synchronized void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		String kpi_name = (String) (request.getAttribute("KPI") == null ? null
				: request.getAttribute("KPI"));

		// Check KPI name for further researches

		try {
			Class.forName("org.postgresql.Driver");
			Connection connection = DriverManager.getConnection(
					"jdbc:postgresql://localhost:5432/RSD", "postgres",
					"kazu99");

			Statement stmt = connection.createStatement();

			ResultSet rs = stmt.executeQuery("SELECT " + "kpi_name,"
					+ "kpi_value," + "kpi_target," + "kpi_sector,"
					+ "kpi_creation," + "kpi_value_type," + "kpi_max_value,"
					+ "kpi_min_value," + "kpi_source from RSD_KPIMAP ");

			JSONArray array = new JSONArray();
			while (rs.next()) {
				JSONObject obj = new JSONObject();

				obj.put("kpi_name", rs.getString(1));
				obj.put("kpi_value", rs.getString(2));
				obj.put("kpi_target", rs.getString(3));
				obj.put("kpi_sector", rs.getString(4));
				obj.put("kpi_creation", rs.getString(5));
				obj.put("kpi_value_type", rs.getString(6));
				obj.put("kpi_max_value", rs.getString(7));
				obj.put("kpi_min_value", rs.getString(8));
				obj.put("kpi_source", rs.getString(9));
				array.put(obj);
			}

			StringWriter strOut = new StringWriter();

			JSONObject mainObj = new JSONObject();
			mainObj.put("dataType", "json");
			mainObj.put("kpi", array);

			mainObj.write(strOut);

			String jsonText = strOut.toString();
			out.print(jsonText);
			// Closing Connections
			rs.close();
			stmt.close();
			connection.close();

			// End process to create the JSON data

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
