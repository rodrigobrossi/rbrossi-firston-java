<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*, java.math.*, java.text.*"%>


<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  
Integer usu_plano = (Integer)session.getAttribute("usu_plano");  
String aplicacao = (String)session.getAttribute("aplicacao"); 

int ava_codigo = 0, que_codigo = 0, indice = 1, cur_codigo = 0;
String query = "", comentario = "", per_codigo = "", per_nome = "", per_tipo = "", res_nome = "", max = "", min = "", cor = "", planoTitulo = "";

ResultSet rs = null, rs1 = null, rs2 = null;

SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

if(request.getParameter("sel_avaliacao") != null)
	ava_codigo = Integer.parseInt(request.getParameter("sel_avaliacao"));
if(request.getParameter("sel_questionario") != null)
	que_codigo = Integer.parseInt(request.getParameter("sel_questionario"));
if(request.getParameter("selpergunta") != null)
	cur_codigo = Integer.parseInt(request.getParameter("selpergunta"));

query = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
rs = conexao.executaConsulta(query,session.getId());
if(rs.next()) planoTitulo = rs.getString(1);
if(rs!=null){rs.close(); conexao.finalizaConexao(session.getId());}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Tabulacao das Avaliacoes")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%"> 
            <table border="0" cellspacing="1" cellpadding="0" width="100%">
              <tr> 
                <td class="trcurso" ><img src="../art/Logo_Cliente.gif" width="317" height="42"></td>
              </tr>			  
    	      <tr>
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("Tabulacao das Avaliacoes")%> / <%=planoTitulo%></td>                              
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>  
      </table>	
	  <%
 		// ******************** FOLHA DE RESPOSTA ********************
		%>
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr> 
			  <td width="20">&nbsp;</td>
	          <td width="100%" align="center"> 
		        <table border="0" cellspacing="0" cellpadding="0">
			      <tr> 

		          </tr>
			    </table>
	          </td>
		      <td width="20">&nbsp;</td>
			</tr>
	        <tr> 
		      <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
			  <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
	          <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
		    </tr>
			<tr> 
	          <td width="20" valign="top"></td>
		  <FORM name = "frm">
			  <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr> 
		            <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
			      </tr>
		    <tr align="left" class="ftverdanacinza">
		     <td align="left" width="25%">
			  <b><%=trd.Traduz("QUESTIONARIO")%></b>:&nbsp;&nbsp;&nbsp;
		     </td>
				 <%
					query = "SELECT QUE_NOME, QUE_COMENTARIO FROM QUESTIONARIO WHERE QUE_CODIGO = "+ que_codigo;
					rs = conexao.executaConsulta(query,session.getId());		

					if(rs.next())
					{
						%> <td> <%=rs.getString(1)%> </td> <%
						comentario = rs.getString(2);
					}
					else
					{
						%> <td> &nbsp; </td> <%
					}
                                        if(rs!=null){
                                        rs.close();
                                        conexao.finalizaConexao(session.getId());
                                        }
				 %>	     
			</tr>

            <tr align="left" class="ftverdanacinza">
		     <td align="left" width="25%">
			  <b><%=trd.Traduz("CURSO")%></b>:&nbsp;&nbsp;&nbsp;
		    </td>
			 <%
					query = "SELECT CUR_NOME FROM CURSO WHERE CUR_CODIGO = "+ cur_codigo;
					rs = conexao.executaConsulta(query,session.getId());		

					if(rs.next())
					{
						%> <td> <%=rs.getString(1)%> </td> <%
					}
					else
					{
						%> <td> &nbsp; </td> <%
					}
                                        if(rs!=null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId());
                                        }
				 %>	
			</tr>

		    <tr>
		     <td colspan="100%">
			 &nbsp;
		     </td>
		    </tr>
			<tr align="left" class="ftverdanacinza">	    
		     <td align="left" width="10%" valign="top">
		      <b><%=trd.Traduz("AVALIACOES ANALISADAS")%></b>: 
			 </td>
		     <td>
				<%
					query = "SELECT COUNT (A.AVD_CODIGO) "+
							"FROM AVALIADO A, PROCESSO P, TURMA T, CURSO C "+
							"WHERE C.CUR_CODIGO = "+cur_codigo+" "+
							"AND T.CUR_CODIGO = C.CUR_CODIGO "+
							"AND P.TUR_CODIGO = T.TUR_CODIGO "+
							"AND P.QUE_CODIGO = "+que_codigo+" "+
							"AND A.PRO_CODIGO = P.PRO_CODIGO";
					
					rs = conexao.executaConsulta(query,session.getId());		

					if(rs.next()) {
						%>
							<%=rs.getInt(1)%>
						<%
					}
                                        if(rs!=null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId());
                                            }
				%>
		     </td>
		    </tr>
			<tr align="left" class="ftverdanacinza">	    
		     <td align="left" width="10%" valign="top">
		      <b><%=trd.Traduz("AVALIACOES RESPONDIDAS")%></b>: 
			 </td>
		     <td>
				<%
					query = "SELECT COUNT (A.AVD_CODIGO) "+
							"FROM AVALIADO A, PROCESSO P, TURMA T, CURSO C "+
							"WHERE C.CUR_CODIGO = "+cur_codigo+" "+
							"AND T.CUR_CODIGO = C.CUR_CODIGO "+
							"AND P.TUR_CODIGO = T.TUR_CODIGO "+
							"AND A.PRO_CODIGO = P.PRO_CODIGO "+
							"AND P.QUE_CODIGO = "+que_codigo+" "+
							"AND A.AVD_STATUS = 'S'";
					
					rs = conexao.executaConsulta(query,session.getId());		

					if(rs.next()) {
						%>
							<%=rs.getInt(1)%>
						<%
					}
                                        if(rs!=null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId());
                                            }
				%>
		     </td>
		    </tr>

            <tr align="left" class="ftverdanacinza">	    
		     <td align="left" width="10%" valign="top">
		      <b>&nbsp;&nbsp;&nbsp;</b>
			 </td>
		     <td>
		     </td>
		    </tr>


            <tr align="left" class="ftverdanacinza">	    
		     <td align="left" width="10%" valign="top">
		      <b><%=trd.Traduz("QUESTOES MULTIPLA ESCOLHA")%></b>
			 </td>
		     <td>
		     </td>
		    </tr>
			<tr>
              <tr> 
                <td height="12" colspan="100%"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1" colspan="100%"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
                  <td align="center" colspan="100%">&nbsp;<br>
                   <p>
                    <table border="0" cellspacing="1" cellpadding="2" width="60%">
					<%
						//Query de perguntas 
						query = "SELECT P.PER_NOME, P.PER_CODIGO,P.PER_TIPO "+
								"FROM PERGUNTA P, QUEST_PERGUNTA Q "+
								"WHERE Q.QUE_CODIGO = "+que_codigo+ " " +
								"AND P.PER_CODIGO = Q.PER_CODIGO AND P.PER_TIPO = 'ME'";
		
						rs = conexao.executaConsulta(query,session.getId());

						while(rs.next())
						{
							if(!per_nome.equals(rs.getString(1)))
							{
								per_nome = rs.getString(1);
								per_codigo = rs.getString(2);
								per_tipo = rs.getString(3);
								%>
								<tr>
								  <td  align="left" class="celtittab" colspan="3"><b><%=indice%>. <%=per_nome%></b></td>
								</tr>
								<tr>
								  <td class="celnortab" align="center"> &nbsp; </td>
								  <td class="celnortab" align="center"><b><%=trd.Traduz("RESPONDIDA(S)")%></b></td>
								  <td class="celnortab" align="center"><b><%=trd.Traduz("VALOR")%></b></td>
								</tr>

								<%
								indice++;
								if(per_tipo.equals("ME")) 
								{
									//Query de respostas tipo Multipla Escolha
									query = "SELECT R.RES_NOME, R.RES_CODIGO, QR.QGR_VALOR "+
											"FROM QUESTIONARIO Q, QUEST_RESP QR, RESPOSTA R "+
											"WHERE QR.QUE_CODIGO = "+que_codigo+ " " +
											"AND QR.PER_CODIGO = "+per_codigo+ " " +
											"AND Q.QUE_CODIGO = QR.QUE_CODIGO "+
											"AND QR.RES_CODIGO = R.RES_CODIGO";									

									rs1 = conexao.executaConsulta(query,session.getId()+"RS_1");

									while(rs1.next())
									{
										//Conta quantas respostas teve de cada questAo
										query = "SELECT COUNT(L.LAU_CODIGO) "+
												"FROM LAUDO L, PROCESSO P, CURSO C, TURMA T "+
												"WHERE C.CUR_CODIGO = "+cur_codigo+" "+
												"AND T.CUR_CODIGO = C.CUR_CODIGO "+
												"AND P.TUR_CODIGO = T.TUR_CODIGO "+
												"AND L.PRO_CODIGO = P.PRO_CODIGO "+
												"AND P.QUE_CODIGO = "+que_codigo+" "+
												"AND L.RES_CODIGO = "+rs1.getInt(2)+" "+
												"AND L.PER_CODIGO = "+per_codigo+" ";

										rs2 = conexao.executaConsulta(query,session.getId()+"RS_2");

										if(rs2.next()) {
											res_nome = rs1.getString(1);
											%>
											<tr>
											  <td class="celnortab"> <%=rs1.getString(1)%> </td>
											  <td class="celnortab" align="center"> <%=rs2.getInt(1)%> </td>
											  <td class="celnortab" align="center"> <%=rs1.getString(3)%> </td>
											</tr>
											<%
										}
                                                                                if(rs2!=null){
                                                                                  rs2.close();
                                                                                  conexao.finalizaConexao(session.getId()+"RS_2");
                                                                                }
									}
								}
								else if(per_tipo.equals("N "))
								{
									//Query de respostas tipo NumErica
									query = "SELECT QPG_MINIMO, QPG_MAXIMO "+
											"FROM QUEST_PERGUNTA "+
											"WHERE PER_CODIGO = "+per_codigo+" "+
											"AND QUE_CODIGO = "+que_codigo;

									rs1 = conexao.executaConsulta(query,session.getId());
									rs1.next();
									min = rs1.getString(1);
									max = rs1.getString(2);
                                                                        rs1.close();
                                                                        conexao.finalizaConexao(session.getId()+"RS_1");
									%>
									<tr>
									 <td class="celnortab">
									  <input type="text" name="num_<%=per_codigo%>" size="5" maxlength="9" onBlur="numero2(this)" onKeyUp="numero(this);">
									  <%=trd.Traduz("DE")%> <b><%=min%></b> <%=trd.Traduz("ATE")%> <b><%=max%></b>
									 </td>
									</tr>
									<%
								}
								else
								{
									//Respostas Dissertativas
									%>
										<tr>
										  <td>
											<textarea name="txt_<%=per_codigo%>" cols="90%" rows="3" onBlur="aspa2(this);" onKeyUp="aspa(this)"></textarea>
										  </td>
										</tr>
									<%
								}
							}
						}
                                                if(rs!=null){
                                                rs.close();
                                                conexao.finalizaConexao(session.getId());
                                                }
					%>
                    </table>
                    <br>
                  </td>
              </tr>
    </td>
  </tr>
</table>

<%
%>

</body>
</html>
