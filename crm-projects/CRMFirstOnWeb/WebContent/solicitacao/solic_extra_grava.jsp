<%
//Limpa cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<body  onunload='return fecha();' >
<form name="frm" method="post">
<%
//try{

//Recupera parametros
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");
Integer usu_cod  = (Integer) session.getAttribute("usu_cod"); 

ResultSet rs = null, rscom = null, rsc = null, rsv = null, rsfn = null; 

String origem = "", operacao = "", extra = "", cur = "", usu_plano = "", turant = "", fun_codigo = "";
String reloaded = "";

if(request.getParameter("origem") != null)
	origem = (String)request.getParameter("origem");

if(request.getParameter("operacao") != null)
	operacao = (String)request.getParameter("operacao");

if(request.getParameter("extra") != null)
	extra = (request.getParameter("extra"));

if(request.getParameter("selectcur") != null)
	cur = request.getParameter("selectcur");

if(request.getParameter("reload") != null)
	reloaded = request.getParameter("reload");

if(request.getParameter("selecttur") != null)
	turant = request.getParameter("selecttur");
else
	turant = "-1";


usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); 
String res = "";
if (request.getParameter("tf_result") != null)
  res = request.getParameter("tf_result");
String dur = "";
if (request.getParameter("dur") != null)
  dur = request.getParameter("dur");
String cus1 = "";
if (request.getParameter("cus1") != null)
  cus1 = request.getParameter("cus1");
String prev = "";
if (request.getParameter("selectprev") != null)
  prev = request.getParameter("selectprev");
String funcio = "";
if (request.getParameter("fun_codigo") != null) 
	funcio = request.getParameter("fun_codigo");

String query = "";
int j = 0;
String ji = "";

Vector funcvet = new Vector();

funcvet = (Vector)session.getAttribute("funcs");

/*out.println("<br>VETOR DE FUNCIONARIO: "+funcvet);
out.println("<br>ORIGEM: "+origem);
out.println("<br>OPERACAO: "+operacao);
out.println("<br>RELOADED: "+reloaded);*/

if(!origem.equals("porcompetencias") && !origem.equals("result_filtro"))
	reloaded = "1";

String st_make = "S";
String tcar = "";
if (request.getParameter("checkboxcargo") != null) {

	String queryv = "SELECT FUN_CODIGO "+
					"FROM FUNCIONARIO " +
					"WHERE CAR_CODIGO IN (SELECT CAR_CODIGO FROM " + 
					" FUNCIONARIO WHERE FUN_CODIGO = " + funcvet.elementAt(0) +
					") ";

	String par = "";

	if(usu_tipo.equals("F")){
		par = "";
	}
	else if (usu_tipo.equals("P") || usu_tipo.equals("G")){
		par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " "; 
	}
	else if (usu_tipo.equals("S")){
		par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " AND FUNCIONARIO.FUN_CODSOLIC = " + usu_cod + " "; 
	}
			
	queryv = queryv + par;

	rsc = conexao.executaConsulta(queryv,session.getId()+"RS1");
	if (rsc.next()){
		do{ 
			funcvet.add(rsc.getString(1));
		}while (rsc.next());
	}

        if(rsc != null){
	    rsc.close();
            conexao.finalizaConexao(session.getId()+"RS1");
        }

	tcar = "S";
}
else{
	tcar = "N";
}


if(reloaded == ""){
	if (!(operacao.equals("U"))){
		operacao = "I";
	
		for(int k=0 ; k<funcvet.size(); k++){	
			
			
			String queryv = "SELECT FUN_CODIGO " +
					 "FROM TREINAMENTO " +
					 "WHERE CUR_CODIGO = " + cur + 
					 " AND FUN_CODIGO = " + funcvet.elementAt(k) + 
					 " AND PLA_CODIGO = " + usu_plano + 
					 " AND TUR_CODIGO_REAL IS NULL";
			 
			rsv = conexao.executaConsulta(queryv,session.getId()+"RS2");
			if(rsv.next()){
				%>
				<script language="JavaScript">
					alert(<%=("\""+trd.Traduz("O funcionArio selecionado jA possui este Curso Solicitado")+"\"")%>);
					history.go(-1);
					//window.open("result_filtro.jsp?opt=E","_parent");
				</script>
				<%
				st_make = "N";
                                if(rsv != null){
	                            rsv.close();
                                    conexao.finalizaConexao(session.getId()+"RS2");
                                }
			}
			else{
			
			
			
				 queryv = "SELECT FUN_CODIGO "+
								"FROM TREINAMENTO "+
								"WHERE CUR_CODIGO = " + cur +
								" AND FUN_CODIGO = " + funcvet.elementAt(k) +
								" AND PLA_CODIGO = " + usu_plano + 
								" AND TUR_CODIGO_REAL IS NOT NULL";
			
                                if(rsv != null){
	                           rsv.close();
                                   conexao.finalizaConexao(session.getId()+"RS2");
                                }

				rsv = conexao.executaConsulta(queryv, session.getId()+"RS3");
				//out.println("<br>****QUERY****"+query);
				if(rsv.next()){
					//out.println("<br>****passou1****");
					if(origem.equals("porcompetencias")){
						%>
						<script language="JavaScript">
						if(confirm(<%=("\""+trd.Traduz("O funcionArio selecionado jA possui este Curso Realizado, deseja continuar ?")+"\"")%>)){
							window.open("solic_extra_grava.jsp?reload=1&origem=<%=origem%>&operacao=<%=operacao%>&extra=<%=extra%>&selectcur=<%=cur%>&selecttur=<%=turant%>&tf_result=<%=res%>&dur=<%=dur%>&cus1=<%=cus1%>&selectprev=<%=prev%>&fun_codigo=<%=funcio%>","_self");
						}
						else{
							window.open("porcompetencias.jsp?fun_codigo=<%=funcvet.elementAt(0)%>","_self");
						}
						</script>
						<%
					}					else if(origem.equals("result_filtro")){
						%>
						<script language="JavaScript">
						if(confirm(<%=("\""+trd.Traduz("O funcionArio selecionado jA possui este Curso Realizado, deseja continuar ?")+"\"")%>)){
							window.open("solic_extra_grava.jsp?reload=1&origem=<%=origem%>&operacao=<%=operacao%>&extra=<%=extra%>&selectcur=<%=cur%>&selecttur=<%=turant%>&tf_result=<%=res%>&dur=<%=dur%>&cus1=<%=cus1%>&selectprev=<%=prev%>&fun_codigo=<%=funcio%>","_self");
						}
						else{
							window.open("index.jsp?opt=E&op=S","_self");
						}
						</script>
						<%
					}
				}
				else{
					if(origem.equals("result_filtro") || origem.equals("porcompetencias")){
						reloaded = "1";
					}
				}

                                if(rsv != null){
	                           rsv.close();
                                   conexao.finalizaConexao(session.getId()+"RS3");
                                }
			
				//if(origem.equals("result_filtro")){
				//	reloaded = "1";
				//}
			}                       
	 	}
	}
}

//out.println("<br>ST_MAKE: "+st_make);

//Variavel de data atual
java.util.Date  dataAtual = new java.util.Date();
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
String dia = formato.format(dataAtual);

//Verifica o tipo da Solicitacao
String tiposolic = "1";
if (origem.equals("prerequisitos")){
	tiposolic = "2";
}
if (origem.equals("porcompetencias")){
	tiposolic = "3";
}      
if (origem.equals("planosussessorio")){
	tiposolic = "4";
}
if (origem.equals("result_filtro")){
	tiposolic = "1";
}

if(reloaded.equals("1")){
	if (st_make.equals("S")){
		for(int k=0 ; k<funcvet.size(); k++){
		
			if (extra.equals("S") && origem.equals("reprogramacao")){
				if (turant.equals("-1")){
					query = "INSERT INTO TREINAMENTO (FUN_CODIGO, CUR_CODIGO, PLA_CODIGO, TTR_CODIGO, QBR_CODIGO, " + 
							"TEF_DURACAO, TEF_CUSTO, TEF_DATASOLICITACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO, TEF_TIPOSOLICITACAO) " + 
							"VALUES (" + funcvet.elementAt(k) + ", " + cur + ", " + usu_plano + ", 1" + ", " + prev + 
							", " + dur + ", " + cus1 + ", DATEFMT("+dia+"), '" + res + "', 'S'" + 
							", " + tiposolic + ")"; 
				}
				else{
					query = "INSERT INTO TREINAMENTO (FUN_CODIGO, CUR_CODIGO, PLA_CODIGO, TTR_CODIGO, QBR_CODIGO, " + 
			        		"TEF_DURACAO, TEF_CUSTO, TEF_DATASOLICITACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO, TEF_TIPOSOLICITACAO, TUR_CODIGO_PLAN_ANT) " + 
			        		"VALUES (" + funcvet.elementAt(k) + ", " + cur + ", " + usu_plano + ", 1" + ", " + prev + 
			        		", " + dur + ", " + cus1 + ", DATEFMT("+dia+"), '" + res + "', 'S'" + 
			        		", " + tiposolic + ", " + turant + ")"; 
				}
				
				conexao.executaAlteracao(query);
				//out.println("1ª query = " + query);
	
				//Para Gravas as competEncias
			  	query = "select treinamento.tef_codigo, cursocomp.cmp_codigo from treinamento, cursocomp where cursocomp.cur_codigo = treinamento.cur_codigo and treinamento.fun_codigo = " + funcvet.elementAt(k) + " and cursocomp.cur_codigo = " + cur + " ";
				rscom = conexao.executaConsulta(query,session.getId()+"RS4" );


			    while (rscom.next()){
					j++;
					ji = ji.valueOf(j);
	                if (request.getParameter("checkbox" + ji) != null){
			        	query = "INSERT INTO TREINCOMP (TEF_CODIGO, CMP_CODIGO) VALUES ("+ rscom.getString(1) +", " + request.getParameter("checkbox" + ji) +")";
			        	conexao.executaAlteracao(query);
					}
				}

                                if(rscom != null){
	                           rscom.close();
                                   conexao.finalizaConexao(session.getId()+"RS4");
                                }

			}
			else{
				if (origem.equals("reprogramacao")){
					query = "UPDATE TREINAMENTO SET CUR_CODIGO = " + cur + ", " + 
							"PLA_CODIGO = " + usu_plano + ", " +
							"QBR_CODIGO = " + prev + ", " +
							"TEF_DURACAO = " + dur + ", " +
							"TEF_CUSTO = " + cus1 + ", " +
							"TEF_DATASOLICITACAO = DATEFMT("+dia+"), " +
							"TEF_RESULTADOESPERADO = '" + res + "', " +
							"TEF_PLANEJADO = 'S', " +
							"TEF_REPROGRAMAR = NULL, " +
		    				"JUS_CODIGO = NULL " +	
			    			"WHERE TEF_CODIGO = " + funcvet.elementAt(k);
	
					conexao.executaAlteracao(query);
					String queryfun = "SELECT FUN_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = " +  funcvet.elementAt(k);
					rsfn = conexao.executaConsulta(queryfun, session.getId()+"RS5");
				  	if(rsfn.next())
						funcio = rsfn.getString(1);
                                        
                                        if(rsfn != null){
	                                    rsfn.close();
                                             conexao.finalizaConexao(session.getId()+"RS5");
                                        }

				}
				else{
					if (operacao.equals("I")){
						if (turant.equals("-1")){
	            			query = "INSERT INTO TREINAMENTO (FUN_CODIGO, CUR_CODIGO, PLA_CODIGO, TTR_CODIGO, QBR_CODIGO, " + 
	              					"TEF_DURACAO, TEF_CUSTO, TEF_DATASOLICITACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO, TEF_TIPOSOLICITACAO) " +
	              					"VALUES (" + funcvet.elementAt(k) + ", " + cur + ", " + usu_plano + ", 1" + ", " + prev + ", " + dur + 
	              					", " + cus1 + ", DATEFMT("+dia+"), '" + res + "', 'S'" + ", " + tiposolic + ")";
	
							funcio = "" + funcvet.elementAt(k);
						}
						else{
	           				query = "INSERT INTO TREINAMENTO (FUN_CODIGO, CUR_CODIGO, PLA_CODIGO, TTR_CODIGO, QBR_CODIGO, " + 
	           						"TEF_DURACAO, TEF_CUSTO, TEF_DATASOLICITACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO, TEF_TIPOSOLICITACAO, TUR_CODIGO_PLAN_ANT) " + 
	           						"VALUES (" + funcvet.elementAt(k) + ", " + cur + ", " + usu_plano + ", 1" + ", " + prev + 
	           						", " + dur + ", " + cus1 + ", DATEFMT("+dia+"), '" + res + "', 'S'" + 
	           						", " + tiposolic + ", " + turant + ")"; 
	
							funcio = "" + funcvet.elementAt(k);
						}
						//out.println("3ª query = " + query);
		  			}	
		  			else{	
	      				query = "UPDATE TREINAMENTO SET CUR_CODIGO = " + cur + ", " + 
	      				        "PLA_CODIGO = " + usu_plano + ", " +
	      				        "QBR_CODIGO = " + prev + ", " +
	      				        "TEF_DURACAO = " + dur + ", " +
	      				        "TEF_CUSTO = " + cus1 + ", " +
		      				        "TEF_DATASOLICITACAO = DATEFMT("+dia+"), " +
	      				        "TEF_RESULTADOESPERADO = '" + res + "', " +
	      				        "TEF_PLANEJADO = 'S', " +
	      				        "TEF_REPROGRAMAR = NULL " +
	      				        "WHERE TEF_CODIGO = " + funcvet.elementAt(k);
						//out.println("4ª query = " + query);
						funcio = "" + funcvet.elementAt(k);      				        
	              		String queryfu = "SELECT FUN_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = " +  funcvet.elementAt(k);
					 	rs = conexao.executaConsulta(queryfu, session.getId()+"RS6");
				  		if(rs.next())
					  		funcio = rs.getString(1);

                                                if(rs != null){
	                                            rs.close();
                                                    conexao.finalizaConexao(session.getId()+"RS6");
                                                }

					}
					conexao.executaAlteracao(query);
					
					if (operacao.equals("I")){
						//Para Gravas as competEncias
						query = "select treinamento.tef_codigo, cursocomp.cmp_codigo from treinamento, cursocomp where cursocomp.cur_codigo = treinamento.cur_codigo and treinamento.fun_codigo = " + funcvet.elementAt(k) + " and cursocomp.cur_codigo = " + cur + " ";
						rscom = conexao.executaConsulta(query,session.getId()+"RS7");
						while (rscom.next()){
							j++;
					  		ji = ji.valueOf(j);
	                		if (request.getParameter("checkbox" + ji) != null){
	                			query = "INSERT INTO TREINCOMP (TEF_CODIGO, CMP_CODIGO) VALUES ("+ rscom.getString(1) +", " + request.getParameter("checkbox" + ji) +")";
	                			conexao.executaAlteracao(query);
							}
	             		}
                                if(rscom != null){
	                            rscom.close();
                                    conexao.finalizaConexao(session.getId()+"RS7");
                                }
 
	            	}
	    		}
			}
		}
	}
}
%>
<script language="JavaScript">
	alert(<%=("\""+trd.Traduz("SolicitaCAo efetuada com sucesso")+"\"")%>);
</script>
<%


%>
<input type="hidden" name="origem"		value="<%=origem%>">
<input type="hidden" name="operacao"	value="<%=operacao%>">
<input type="hidden" name="extra" 		value="<%=extra%>">
<input type="hidden" name="selectcur" 	value="<%=cur%>">
<input type="hidden" name="reload" 		value="<%=reloaded%>">
<input type="hidden" name="selecttur" 	value="<%=turant%>">
<input type="hidden" name="tf_result" 	value="<%=res%>">
<input type="hidden" name="dur" 		value="<%=dur%>">
<input type="hidden" name="cus1" 		value="<%=cus1%>">
<input type="hidden" name="selectprev" 	value="<%=prev%>">

<%

/*

out.println("<br><hr><br>ORIGEM: "+origem);
out.println("<br>OPERACAO: "+operacao);
out.println("<br>EXTRA: "+extra);
out.println("<br>CURSO: "+cur);
out.println("<br>RELOADED: "+reloaded);
out.println("<br>TURANT: "+turant);
out.println("<br>RES: "+res);
out.println("<br>DUR: "+dur);
out.println("<br>CUS1: "+cus1);
out.println("<br>PREV: "+prev);
out.println("<br>FUNCIO: "+funcio);
*/





if(origem.equals("prerequisitos")){
  	%>
  	<script language="JavaScript">
	  	window.open("<%=origem%>.jsp?fun_codigo=<%=funcio%>&opt=E","_self");
  	</script>
  	<%
    //response.sendRedirect(origem + ".jsp?fun_codigo=" + funcio);
}

if(origem.equals("result_solics")){
  	%>
  	<script language="JavaScript">
  		window.open("<%=origem%>.jsp?fun_codigo=<%=funcio%>","_self");
  	</script>
  	<%
    //response.sendRedirect(origem + ".jsp?fun_codigo=" + funcio);
}

if(origem.equals("porcompetencias")){
  	%>
  	<script language="JavaScript">
  		window.open("<%=origem%>.jsp?fun_codigo=<%=funcvet.elementAt(0)%>&opt=E","_self");
  	</script>
  	<%
    //response.sendRedirect(origem + ".jsp?fun_codigo=" + funcio);
} 
      
if(origem.equals("reprogramacao")){
  	%>
  	<script language="JavaScript">
  		window.open("<%=origem%>.jsp?fun_codigo=<%=funcio%>&opt=E","_self");
  	</script>
  	<%
	//response.sendRedirect(origem + ".jsp?fun_codigo");   
}

if(origem.equals("result_filtro")){
  	%>
  	<script language="JavaScript">
  		window.open("index.jsp?opt=E&op=S","_self");
  	</script>
  	<%
	//response.sendRedirect(origem + ".jsp");   
}

if(reloaded == "1"){
	funcvet.clear();
	request.getSession(true);
	session.setAttribute("funcs", funcvet);
}

//} catch(Exception e){
//	out.println("ERRO: "+e);
//}
%>
</form>
</body>
</html>