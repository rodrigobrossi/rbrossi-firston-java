package firston.eval.access;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import firston.eval.connection.FODBConnectionBean;

public class FOAccessBean {

	public FOAccessBean() {
		rst_acesso = null;
		conn = null;
		str_erro = "";
		str_queryAlteraLogin = "";
		int_ace_codigo = 0;
		SESSION_ID = "";
	}

	public void validaAcesso(FODBConnectionBean conn, Date dat_DataAtual, Integer usu_cod,
			String endHost, String endGetId, String SESSION_ID) {
		this.SESSION_ID = SESSION_ID;
		SimpleDateFormat sdf_data = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdf_hora = new SimpleDateFormat("HH:mm:ss");
		String str_data = sdf_data.format(dat_DataAtual);
		String str_hora = sdf_hora.format(dat_DataAtual);
		this.conn = conn;
		String str_queryInsereAcesso = "INSERT INTO acesso (fun_codigo ,ace_session,ace_ip,ace_data,ace_hora,ace_operacao) VALUES ("
				+ usu_cod
				+ ",'"
				+ endGetId
				+ "','"
				+ endHost
				+ "',CONVERT(datetime,'"
				+ str_data
				+ "',103),"
				+ "CONVERT(datetime,'" + str_hora + "',103),0)";
		try {
			conn.executaAlteracao(str_queryInsereAcesso);
		} catch (Exception e) {
			str_erro = str_erro + " SQL2 = " + e;
		}
		String str_queryVerificaUsuario = "SELECT COUNT(fun_codigo) FROM userlogin WHERE fun_codigo="
				+ usu_cod + "";
		String str_queryVerificaACE_CODIGO = "SELECT MAX(ace_codigo) FROM acesso WHERE fun_codigo = "
				+ usu_cod + "";
		try {
			rst_acesso = conn.executaConsulta(str_queryVerificaACE_CODIGO,
					SESSION_ID + "RES_1_ACESSO");
			if (rst_acesso.next())
				int_ace_codigo = rst_acesso.getInt(1) != 0 ? rst_acesso
						.getInt(1) : 777;
		} catch (SQLException e2) {
			str_erro = str_erro + " SQL2 = " + e2;
		} finally {
			try {
				if (rst_acesso != null) {
					rst_acesso.close();
					//conn.finalizaConexao(SESSION_ID + "RES_1_ACESSO");
				}
			} catch (SQLException e2) {
				str_erro = str_erro + " SQL2 = " + e2;
			}
		}
		try {
			rst_acesso = conn.executaConsulta(str_queryVerificaUsuario,
					SESSION_ID + "RES_2_ACESSO");
			rst_acesso.next();
			int int_flag = rst_acesso.getInt(1);
			if (int_flag == 1)
				str_queryAlteraLogin = "UPDATE userlogin SET use_acesso="
						+ int_ace_codigo + ",use_session ='" + endGetId + "',"
						+ "use_datalogin=CONVERT(datetime,'" + str_data
						+ "',103)," + "use_hora=CONVERT(datetime,'" + str_hora
						+ "',103)" + " where fun_codigo=" + usu_cod + "";
			else
				str_queryAlteraLogin = "INSERT INTO userlogin (fun_codigo,use_acesso,use_login,use_datalogin,use_identy,use_hora,use_session)VALUES("
						+ usu_cod
						+ ","
						+ int_ace_codigo
						+ ",'S',CONVERT(datetime,'"
						+ str_data
						+ "',103),"
						+ "'"
						+ endHost
						+ "',CONVERT(datetime,'"
						+ str_hora
						+ "',103),'" + endGetId + "')";
		} catch (SQLException e3) {
			str_erro = str_erro + " SQL3 = " + e3;
		} finally {
			try {
				if (rst_acesso != null) {
					rst_acesso.close();
					//conn.finalizaConexao(SESSION_ID + "RES_2_ACESSO");
				}
			} catch (SQLException e2) {
				str_erro = str_erro + " SQL2 = " + e2;
			}
		}
		try {
			conn.executaAlteracao(str_queryAlteraLogin);
		} catch (Exception e4) {
			str_erro = str_erro + " SQL4 = " + e4;
		}
	}

	public String devolveErro() {
		return str_erro;
	}

	public void mataUsuario(FODBConnectionBean conn, Integer usu_cod) {
		this.conn = conn;
		String str_queryMataAcesso = "UPDATE userlogin SET use_session='SESSAOINVALIDA7777' WHERE fun_codigo="
				+ usu_cod + "";
		try {
			conn.executaAlteracao(str_queryMataAcesso);
		} catch (Exception e5) {
			str_erro = str_erro + " SQL5 = " + e5;
		} finally {
		}
	}

	public boolean verificaAcesso(FODBConnectionBean conn, Integer usu_cod,
			String str_sessao, String SESSION_ID) {
		boolean acesso = false;
		this.conn = conn;
		this.SESSION_ID = SESSION_ID;
		String str_queryPesquisaAcesso = "SELECT COUNT(fun_codigo) FROM userlogin WHERE fun_codigo="
				+ usu_cod + " AND use_session='" + str_sessao + "'";
		try {
			rst_acesso = conn.executaConsulta(str_queryPesquisaAcesso,
					SESSION_ID + "RES_4_ACESSO");
			rst_acesso.next();
			int int_flag = rst_acesso.getInt(1);
			if (int_flag == 1)
				acesso = true;
			else
				acesso = false;
			if (rst_acesso != null) {
				rst_acesso.close();
			//	conn.finalizaConexao(SESSION_ID + "RES_4_ACESSO");
			}
		} catch (SQLException e6) {
			str_erro = str_erro + " SQL6 = " + e6;
		} finally {
			try {
				if (rst_acesso != null) {
					rst_acesso.close();
					//conn.finalizaConexao(SESSION_ID + "RES_4_ACESSO");
				}
			} catch (SQLException e2) {
				str_erro = str_erro + " SQL2 = " + e2;
			}
		}
		return acesso;
	}

	public void validaSaida(FODBConnectionBean conn, Date dat_DataAtual, Integer usu_cod,
			String endHost, String endGetId, String SESSION_ID) {
		SimpleDateFormat sdf_data = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdf_hora = new SimpleDateFormat("HH:mm:ss");
		String str_data = sdf_data.format(dat_DataAtual);
		String str_hora = sdf_hora.format(dat_DataAtual);
		this.conn = conn;
		this.SESSION_ID = SESSION_ID;
		String str_queryInsereAcesso = "INSERT INTO acesso (fun_codigo ,ace_session,ace_ip,ace_data,ace_hora,ace_operacao) VALUES ("
				+ usu_cod
				+ ",'"
				+ endGetId
				+ "','"
				+ endHost
				+ "', CONVERT(datetime,'"
				+ str_data
				+ "',103),"
				+ "CONVERT(datetime,'" + str_hora + "',103),1)";
		try {
			conn.executaAlteracao(str_queryInsereAcesso);
		} catch (Exception e7) {
			str_erro = str_erro + " SQL7 = " + e7;
		}
		String str_queryVerificaACE_CODIGO = "SELECT MAX(ace_codigo) FROM acesso WHERE fun_codigo = "
				+ usu_cod + "";
		try {
			rst_acesso = conn.executaConsulta(str_queryVerificaACE_CODIGO,
					SESSION_ID + "RES_5_ACESSO");
			if (rst_acesso.next())
				int_ace_codigo = rst_acesso.getInt(1) != 0 ? rst_acesso
						.getInt(1) : 777;
		} catch (SQLException e8) {
			str_erro = str_erro + " SQL8 = " + e8;
		} finally {
			try {
				if (rst_acesso != null) {
					rst_acesso.close();
					//conn.finalizaConexao(SESSION_ID + "RES_5_ACESSO");
				}
			} catch (SQLException e2) {
				str_erro = str_erro + " SQL2 = " + e2;
			}
		}
		try {
			str_queryAlteraLogin = "UPDATE userlogin SET use_acesso="
					+ int_ace_codigo + ",use_session ='" + endGetId + "',"
					+ "use_datalogin=CONVERT(datetime,'" + str_data + "',103),"
					+ "use_hora=CONVERT(datetime,'" + str_hora + "',103)"
					+ " where fun_codigo=" + usu_cod + "";
			conn.executaAlteracao(str_queryAlteraLogin);
		} catch (Exception e10) {
			str_erro = str_erro + " SQL10 = " + e10;
		}
	}

	public void validaSaida(FODBConnectionBean conn, Date dat_DataAtual, Integer usu_cod,
			String endHost, String endGetId, String str_op, String SESSION_ID) {
		SimpleDateFormat sdf_data = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdf_hora = new SimpleDateFormat("HH:mm:ss");
		String str_data = sdf_data.format(dat_DataAtual);
		String str_hora = sdf_hora.format(dat_DataAtual);
		this.conn = conn;
		this.SESSION_ID = SESSION_ID;
		String str_queryInsereAcesso = "INSERT INTO acesso (fun_codigo ,ace_session,ace_ip,ace_data,ace_hora,ace_operacao) VALUES ("
				+ usu_cod
				+ ",'"
				+ endGetId
				+ "','"
				+ endHost
				+ "',CONVERT(datetime,'"
				+ str_data
				+ "',103),"
				+ "CONVERT(datetime,'" + str_hora + "',103)," + str_op + ")";
		try {
			conn.executaAlteracao(str_queryInsereAcesso);
		} catch (Exception e11) {
			str_erro = str_erro + " SQL11 = " + e11;
		}
	}

	private ResultSet rst_acesso;
	private FODBConnectionBean conn;
	private String str_erro;
	private String str_queryAlteraLogin;
	private int int_ace_codigo;
	private String SESSION_ID;
}
