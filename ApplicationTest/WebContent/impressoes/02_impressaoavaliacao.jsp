<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page import=" java.sql.*, java.util.*, java.math.*, java.text.*"%>


<%
try{
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

int ava_codigo = 0, que_codigo = 0, indice = 1, qtd_pendente = 0, qtd_vencida = 0, qtd_respondida = 0, total_pendente = 0, total_vencida = 0, total_respondida = 0, cont_solic = 0;

String query = "", comentario = "", per_codigo = "", per_nome = "", per_tipo = "", res_nome = "", max = "", min = "", cor_linha = "", css = "", plano = "";

ResultSet rs = null, rs1 = null;

java.util.Date hoje = new java.util.Date();
java.util.Date fim = new java.util.Date();
java.util.Date dt_ini = new java.util.Date();
java.util.Date dt_fim = new java.util.Date();

SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

if(request.getParameter("sel_avaliacao") != null)
	ava_codigo = Integer.parseInt(request.getParameter("sel_avaliacao"));
if(request.getParameter("sel_questionario") != null)
	que_codigo = Integer.parseInt(request.getParameter("sel_questionario"));

query = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO ="+usu_plano;
rs = conexao.executaConsulta(query,session.getId());
if(rs.next()){
	plano = rs.getString(1);
}
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("IMPRESSAO")%> - <%=trd.Traduz("AVALIACAO")%></title>
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
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("IMPRESSAO DE AVALIACAO")%> / <%=plano%></td>                              
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>  
      </table>	
	  <%
 		// ******************** FOLHA DE RESPOSTA ********************
		if(request.getParameter("rdo_tipo").equals("R")) 
		{
		%>
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    <tr> 
			  <td width="20">&nbsp;</td>
	          <td width="100%" align="center"> 
		        <table border="0" cellspacing="0" cellpadding="0">
			      <tr> 
				    <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
					<td class="trontrk" align="center"><%=trd.Traduz("RESPONDER")%></td>
	                <td width="29"><img src="../art/bit.gif" width="13" height="15"></td>
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
			  <b><%=trd.Traduz("FUNCIONARIO")%></b>:&nbsp;&nbsp;&nbsp;
		     </td>
				 <%
					if(request.getParameter("func") != null) {
						%> <td> <%=request.getParameter("func")%> </td> <%				
					}
					else
					{
						%> <td> &nbsp; </td> <%
					}
				 %>	     
			</tr>
			<tr align="left" class="ftverdanacinza">
		     <td align="left" width="25%">
			  <b><%=trd.Traduz("CURSO")%></b>:&nbsp;&nbsp;&nbsp;
		     </td>
				 <%
					if(request.getParameter("curso") != null) {
						%> <td> <%=request.getParameter("curso")%> </td> <%				
					}
					else
					{
						%> <td> &nbsp; </td> <%
					}
				 %>	     
			</tr>
			<tr align="left" class="ftverdanacinza">
		     <td align="left" width="25%">
			  <b><%=trd.Traduz("AVALIACAO")%></b>:&nbsp;&nbsp;&nbsp;
		     </td>
				 <%
					if(request.getParameter("avaliacao") != null) {
						%> <td> <%=request.getParameter("avaliacao")%> </td> <%				
					}
					else
					{
						%> <td> &nbsp; </td> <%
					}
				 %>	     
			</tr>
			<tr align="left" class="ftverdanacinza">
		     <td align="left" width="25%">
			  <b><%=trd.Traduz("QUESTIONARIO")%></b>:&nbsp;&nbsp;&nbsp;
		     </td>
				 <%
					if(request.getParameter("questionario") != null) {
						%> <td> <%=request.getParameter("questionario")%> </td> <%				
					}
					else
					{
						%> <td> &nbsp; </td> <%
					}
				 %>	     
			</tr>
			<tr align="left" class="ftverdanacinza">
		     <td align="left" width="25%">
			  <b><%=trd.Traduz("DATA INICIAL")%></b>:&nbsp;&nbsp;&nbsp;
		     </td>
				 <%
					if(request.getParameter("pro_codigo") != null) {
						query = "SELECT T.TUR_DATAINICIO, T.TUR_DATAFINAL "+
								"FROM TURMA T, PROCESSO P "+
								"WHERE P.PRO_CODIGO = "+request.getParameter("pro_codigo")+" "+
								"AND T.TUR_CODIGO = P.TUR_CODIGO";
						
						rs = conexao.executaConsulta(query,session.getId());
						if(rs.next()) {
							dt_ini = rs.getDate(1);
							dt_fim = rs.getDate(2);
						}
                                                if(rs!=null){
                                                rs.close();
                                                conexao.finalizaConexao(session.getId());
                                                }
					}
					%> <td> <%=formato.format(dt_ini)%> </td> 					    
			</tr>
			<tr align="left" class="ftverdanacinza">
		     <td align="left" width="25%">
			  <b><%=trd.Traduz("DATA FINAL")%></b>:&nbsp;&nbsp;&nbsp;
		     </td>
			 <td> <%=formato.format(dt_ini)%> </td> 					    				      
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
								"AND P.PER_CODIGO = Q.PER_CODIGO ";
		
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
								  <td  align="left" width="30%" class="celtittab"><b><%=indice%>. <%=per_nome%></b></td>
								</tr>
								<%
								indice++;
								if(per_tipo.equals("ME")) 
								{
									//Query de respostas tipo Multipla Escolha
									query = "SELECT R.RES_NOME, R.RES_CODIGO "+
											"FROM QUESTIONARIO Q, QUEST_RESP QR, RESPOSTA R "+
											"WHERE QR.QUE_CODIGO = "+que_codigo+ " " +
											"AND QR.PER_CODIGO = "+per_codigo+ " " +
											"AND Q.QUE_CODIGO = QR.QUE_CODIGO "+
											"AND QR.RES_CODIGO = R.RES_CODIGO";

									rs1 = conexao.executaConsulta(query,session.getId()+"RS");

									while(rs1.next())
									{
										res_nome = rs1.getString(1);
										%>
										<tr>
										  <td class="celnortab">									
											&nbsp; (&nbsp;&nbsp;&nbsp;) &nbsp; <%=rs1.getString(1)%>
										  </td>
										</tr>
										<%
									}
                                                                        if(rs1!=null){
                                                                        rs1.close();
                                                                        conexao.finalizaConexao(session.getId()+"RS");
                                                                        } 
								}
								else if(per_tipo.equals("N "))
								{
									//Query de respostas tipo NumErica
									query = "SELECT QPG_MINIMO, QPG_MAXIMO "+
											"FROM QUEST_PERGUNTA "+
											"WHERE PER_CODIGO = "+per_codigo+" "+
											"AND QUE_CODIGO = "+que_codigo;

									rs1 = conexao.executaConsulta(query,session.getId()+"RS_1");
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
	<%
		}
		// ******************** FOLHA DE RESPOSTA ********************

		// ******************** AVALIACAO ********************
		else 
		{
			%>
		      <br>
		      <table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr valign="top"> 
		          <td class="ftverdanapreto" align="right" colspan="100%">
		            <img src="../art/black.gif" width="17" height="17"> = <%=trd.Traduz("Pendente")%>
		            &nbsp;&nbsp;&nbsp;&nbsp;
		            <img src="../art/green.gif" width="17" height="17"> = <%=trd.Traduz("Vencida")%>
		            &nbsp;&nbsp;&nbsp;&nbsp;
		            <img src="../art/red.gif" width="17" height="17"> = <%=trd.Traduz("Respondida")%>
		          </td>
		        </tr>		       
		      </table>
		      <table width="100%" border="0" cellspacing="1" cellpadding="3">                 				
				<%
					//Filtro por Solicitante
					if(!request.getParameter("cbo_solic").equals(""))
					{
						query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME "+
								"FROM FUNCIONARIO F "+
								"WHERE F.FUN_CODIGO = "+request.getParameter("cbo_solic")+" ";
					}

					else
					{				
					  query = "SELECT DISTINCT FS.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME "+
			                   "FROM FUNC_USUARIO FS, TIPOUSUARIO T, FUNCIONARIO F, APLICACAO A "+
			                   "WHERE FS.TIP_TIPO = T.TIP_TIPO "+
							   "AND T.TIP_TIPO = 'S' "+
							   "AND T.APL_CODIGO = A.APL_CODIGO "+
			                   "AND A.APL_SIGLA =  '"+aplicacao+"' "+
							   "AND FS.FUN_CODIGO = F.FUN_CODIGO "+
			                   "AND F.FUN_DEMITIDO = 'N' ";
					}					

					
					rs = conexao.executaConsulta(query + " ORDER BY F.FUN_NOME",session.getId());	
										
					if(rs.next())
					{
						do
						{
							qtd_pendente = qtd_vencida = qtd_respondida = 0;

							query = "SELECT DISTINCT F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, "+
									"A.AVA_DESCRICAO, P.PRO_INICIO, P.PRO_FIM, V.AVD_STATUS "+
									"FROM FUNCIONARIO F, AVALIACAO A, PROCESSO P, CURSO C, "+
									"QUESTIONARIO Q, AVALIADO V, TURMA T "+
									"WHERE F.FUN_CODSOLIC = "+rs.getInt(1)+" "+
									"AND F.FUN_CODIGO = V.FUN_CODIGO "+
									"AND V.PRO_CODIGO = P.PRO_CODIGO "+
									"AND P.QUE_CODIGO = Q.QUE_CODIGO "+
									"AND Q.AVA_CODIGO = A.AVA_CODIGO "+
									"AND T.TUR_CODIGO = P.TUR_CODIGO "+
									"AND T.CUR_CODIGO = C.CUR_CODIGO ";

							//Filtro por Departamento
							if(!request.getParameter("cbo_departamento").equals(""))
							{
								query = query + " AND F.DEP_CODIGO = "+request.getParameter("cbo_departamento")+" ";
							}		

							//Filtro por FuncionArio
							if(!request.getParameter("cbo_func").equals(""))
							{
								query = query + "AND F.FUN_CODIGO = "+request.getParameter("cbo_func")+" ";
							}		

							//Filtro por Curso
							if(!request.getParameter("cbo_curso").equals(""))
							{
								query = query + "AND C.CUR_CODIGO = "+request.getParameter("cbo_curso")+" ";
							}
							
							//Filtro por AvaliaCAo
							if(!request.getParameter("sel_avaliacao").equals(""))
							{
								query = query + "AND A.AVA_CODIGO = "+request.getParameter("sel_avaliacao")+" ";
							}

							//Filtro por QuestionArio
							if(!request.getParameter("sel_questionario").equals(""))
							{
								query = query + "AND Q.QUE_CODIGO = "+request.getParameter("sel_questionario")+" ";
							}

							//Filtro por Data Inicial
							if(!request.getParameter("text_datainicio").equals(""))
							{
								query = query + "AND P.PRO_INICIO >= DATEFMT("+request.getParameter("text_datainicio")+") ";
							}
							
							//Filtro por Data Final
							if(!request.getParameter("text_datafinal").equals(""))
							{
								query = query + "AND P.PRO_FIM <= DATEFMT("+request.getParameter("text_datafinal")+") ";
							}	
							//out.println("<br><br>Query2: "+query);
							rs1 = conexao.executaConsulta(query + " ORDER BY F.FUN_NOME",session.getId()+"RS");

							if(rs1.next())
							{								
								fim = rs1.getDate(6);

								if((rs1.getString(7) != null) && (rs1.getString(7).equals("S"))) 
								{
									//AvaliaCAo Respondida
									qtd_respondida++;
									total_respondida++;
									css = "ftverdanaverm";
								}
								else
								{
									if(hoje.after(fim))
									{
										//AvaliaCAo Vencida
										qtd_vencida++;
										total_vencida++;
										css = "ftverdanaverde";
									}
									else
									{
										//AvaliaCAo Pendente
										qtd_pendente++;
										total_pendente++;
										css = "ftverdanapreto";
									}
								}
								
								cont_solic++;
								
								%>
									<tr>
										<td colspan="6"> &nbsp; </td>
									</tr>	
									<tr>
										<td colspan="8" class="ftverdanapreto">
											<%=trd.Traduz("SOLICITANTE")%>: <%=rs.getString(2)%> - <%=rs.getString(3)%>
										</td>
									</tr>
									<tr class="celtitrela">
										<td width="10%"> <%=trd.Traduz("CHAPA")%> </td>
									    <td width="30%"> <%=trd.Traduz("NOME")%> </td>
									    <td width="3%"> <%=trd.Traduz("CURSO")%> </td>
								        <td width="10%" align="center"> <%=trd.Traduz("AVALIACAO")%> </td>
								        <td width="10%" align="center"> <%=trd.Traduz("ENVIO")%> </td>
									    <td width="10%" align="center"> <%=trd.Traduz("VENCIMENTO")%> </td>
								    </tr>
								<%
								cor_linha = "#FFFFFF";					
	
								do
								{									
									%>
										<tr class="<%=css%>" bgcolor=<%=cor_linha%>>
								          <td width="10%"> <%=((rs1.getString(1)==null)?"":rs1.getString(1))%> </td>
								          <td width="30%"> <%=((rs1.getString(2)==null)?"":rs1.getString(2))%> </td>
									      <td width="30%"> <%=((rs1.getString(3)==null)?"":rs1.getString(3))%> </td>
										      <td width="10%" align="center"> <%=((rs1.getString(4)==null)?"":rs1.getString(4))%> </td>
											  <td width="10%" align="center"> 
												<%=((rs1.getString(5)==null)?"":formato.format(rs1.getDate(5)))%> 
											  </td>
											  <td width="10%" align="center"> 
												<%=((rs1.getString(6)==null)?"":formato.format(rs1.getDate(6)))%>  
											  </td>
									        </tr>
										<%
									    if(cor_linha.equals("#FFFFFF"))
											cor_linha = "#EEEEEE";
									    else
										    cor_linha = "#FFFFFF";
									}while(rs1.next());

									
										%>
											<tr>
												<td colspan="6"> &nbsp; </td>
											</tr>	
											<tr>
											  <td colspan="6">
											    <table border="0" width="100%">
												  <tr>					
													<td class="celtittab" colspan="3" 	align="center"><%=trd.Traduz("SUBTOTALIZACAO")%></td>
												  </tr>
											      <tr class="celcin">
											        <td width="33%" align="center"> <%=trd.Traduz("TOTAL")%> 	<%=trd.Traduz("PENDENTE")%>: <%=qtd_pendente%> </td>
												    <td width="33%" align="center"> <%=trd.Traduz("TOTAL")%> 		<%=trd.Traduz("VENCIDA")%>: <%=qtd_vencida%> </td>
													<td width="34%" align="center"> <%=trd.Traduz("TOTAL")%> 	<%=trd.Traduz("RESPONDIDA")%>: <%=qtd_respondida%> </td>
												  </tr>
											    </table>
											  </td>
										    </tr>									
										<%
									
								}//if(rs1.next())
								if(rs1!=null){
                                                                rs1.close();
                                                                conexao.finalizaConexao(session.getId()+"RS");
                                                                }
						}while(rs.next());
                                              if(rs!=null)  {
                                                rs.close();
                                                conexao.finalizaConexao(session.getId());
                                                }
					}

					if(cont_solic >= 1)
					{
						%>
							<tr>
								<td colspan="6"> &nbsp; </td>
							</tr>	
							<tr>
								<td colspan="6">
								<table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">   	<tr align="center"> 
										<td colspan="10" class="celtittabcin"><%=trd.Traduz("TOTAL GERAL")%></td>
								    </tr>
				                    <tr class="celcin">
								        <td width="33%" align="center"> <%=trd.Traduz("TOTAL")%> <%=trd.Traduz("PENDENTE")%>: <%=total_pendente%> </td>
								        <td width="33%" align="center"> <%=trd.Traduz("TOTAL")%> <%=trd.Traduz("VENCIDA")%>: <%=total_vencida%> </td>
						                <td width="34%" align="center"> <%=trd.Traduz("TOTAL")%> 	<%=trd.Traduz("RESPONDIDA")%>: <%=total_respondida%> </td>
							        </tr>
					            </table>
							  </td>
						    </tr>						
						<%  
					}

					else
					{
						%>				
							<tr>
								<td colspan="6"> &nbsp; </td>
							</tr>
				            <tr> 
				                <td align="center" class="celbrarela" colspan="6"><%=trd.Traduz("NENHUM ITEM ENCONTRADO!")%></td>
				            </tr>         
						<%
					}
				%>
				<tr>
					<td colspan="6"> &nbsp; </td>
				</tr>
				</table>
			<%
		}
		  // ******************** AVALIACAO ********************
	%>
	
    </td>
  </tr>
</table>

<%
} catch(Exception e){
	out.println("ERRO: "+e);
}
%>

</body>
</html>