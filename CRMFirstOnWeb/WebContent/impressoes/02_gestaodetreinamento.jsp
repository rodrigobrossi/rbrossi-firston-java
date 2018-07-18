<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*, java.math.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  
Integer usu_plano = (Integer)session.getAttribute("usu_plano");  

ResultSet rs = null, rs_tit = null, rs_fun = null, rs_plan_car = null, rs1 = null, rs2 = null;

String op="", curso_nome_tit="", query="", query_tit="", query_fun="", fun_cod="", titulo="", ultimo_fun="", usu_plano_desc="";
String query_fun_null="", query_plano_car="";
int sel=0, ind=0, cont=0, cont_func=0, cont_tit=0;
Vector titulos = new Vector();
boolean primeiro=false, contem=false, fun_null=false, tem_curso=false;
String fun_codigo = "", tit_codigo = "", cur_codigo = "";
String reload = "";
if(request.getParameter("reload") != null)
	reload = request.getParameter("reload");

//Checagem de demitidos e terceiros
String fun_filtro = "";

/*codigos comentados abaixo pois o tipo DEMITIDO foi excluido dos filtros*/

/*if(request.getParameter("check_d") != null)//demitido
	fun_filtro = " AND F.FUN_DEMITIDO = 'S' ";*/

if((request.getParameter("check_a") != null) || (reload.equals("")))//ativo
	fun_filtro = " AND F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N' ";

if(request.getParameter("check_t") != null)//terceiro
	fun_filtro = " AND F.FUN_TERCEIRO = 'S' ";

/*if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null))//demitido e ativo
	fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N')) ";
if((request.getParameter("check_d") != null) && (request.getParameter("check_t") != null))//demitido e terceiro
	fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'S')) ";*/

if((request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//ativo e terceiro
	fun_filtro = " AND ((F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";

/*if((request.getParameter("check_d") != null) && (request.getParameter("check_a") != null) && (request.getParameter("check_t") != null))//demitido, ativo e terceiro
	fun_filtro = " AND ((F.FUN_DEMITIDO = 'S') OR (F.FUN_TERCEIRO = 'N' AND F.FUN_DEMITIDO = 'N') OR (F.FUN_TERCEIRO = 'S')) ";*/

op = request.getParameter("radio1");

//filtro selecao
if(op.equals("cargo")){
  sel = Integer.parseInt(request.getParameter("select_cargo"));
  //out.println("cargo");
} else {
  sel = Integer.parseInt(request.getParameter("select_sol"));
  //out.println("solicitante");
}

//filtro funcionarios sem treinamento
if(request.getParameter("fun_null") != null)
  fun_null = true;
else
  fun_null = false;

//descricao do plano
query = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = " +usu_plano+ " ";
rs = conexao.executaConsulta(query,session.getId()+"RS1");
if (rs.next()){
  usu_plano_desc = rs.getString(1);
}

if(rs != null){
  rs.close();
  conexao.finalizaConexao(session.getId()+"RS1");
}

query = ""; 
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("RelatOrio de GestAo de Treinamento")%></title>
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
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
              <tr> 
                <td class="trcurso" ><img src="../art/Logo_Cliente.gif" width="317" height="42"></td>                                            
              </tr>			  
    	      <tr> 
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("RelatOrio de GestAo de Treinamento")%> / <%=usu_plano_desc%></td>                              
              </tr>
            </table>
          </td>
          <td width="20">&nbsp;</td>
        </tr>        				
        <tr> 
          <td width="20" valign="top"></td>
	  <FORM>
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br>
	     <center>
                <table width="100%" border="0" cellspacing="1" cellpadding="3">                 
                  <tr valign="top"> 
		    <td class="ftverdanapreto" align="center" colspan="100%">
                      <img src="../art/black.gif" width="17" height="17"> = <%=trd.Traduz("PLANEJADOS")%>
                      &nbsp;&nbsp;&nbsp;&nbsp;
		      <img src="../art/blue.gif" width="17" height="17"> = <%=trd.Traduz("JUSTIFICADOS")%>
                      &nbsp;&nbsp;&nbsp;&nbsp;
                      <img src="../art/green.gif" width="17" height="17"> = <%=trd.Traduz("REALIZADOS")%>
                      &nbsp;&nbsp;&nbsp;&nbsp;
                      <img src="../art/red2.gif" width="17" height="17"> = <%=trd.Traduz("REQUERIDO")%>
		      <%if (prm.buscaparam("PREREQDESEJADO").equals("S")){%>
                      &nbsp;&nbsp;&nbsp;&nbsp;
                      <img src="../art/purple.gif" width="17" height="17"> = <%=trd.Traduz("DESEJADO")%>
		      <%}%>
                    </td>
                  </tr> 
                  <tr>
                    <td class="ftverdanacinza" colspan="100%" align="center"> * - <%=trd.Traduz("TERCEIRO")%> </td>
		  </tr>
		</table>
                <p>
                <table width="100%" border="1" cellspacing="1" cellpadding="2">
                  <tr>
                    <td width="20%" class="celcnzrela" align="center" valign="middle">
<%                  //****************PARA CARGO**********************//
                    if(op.equals("cargo")) {
			query = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = "+sel;
			rs = conexao.executaConsulta(query,session.getId()+"RS15");
             		if(rs.next()){
             			%>
				<%=trd.Traduz("CARGO")%>: <%=rs.getString(1)%>
<%
				query_tit = "SELECT DISTINCT T.TIT_NOME, T.TIT_CODIGO "+
					    "FROM TITULO T, PLANOCARREIRA P "+
                        	            "WHERE P.CAR_CODIGO = "+sel+ " "+
                        	            "AND T.TIT_CODIGO = P.TIT_CODIGO "+
                        	            "ORDER BY T.TIT_CODIGO";
                        	//out.println(query_tit);
				rs_tit = conexao.executaConsulta(query_tit,session.getId()+"RS2");
				if(rs_tit.next()){
					tem_curso = true;
					do{
			    			curso_nome_tit = rs_tit.getString(1);
			    			cont++;
                            			titulos.add(rs_tit.getString(2));
                            			%>
                            			<td valign="middle" align="center" class="celcnzrela"><%=curso_nome_tit%></td>
						<%
					}while(rs_tit.next());
			    		//rs_tit.first();
				}
				else{
                          		tem_curso = false;
                          		%>
			    		<td valign="middle" align="center" class="celcnzrela"><%=trd.Traduz("Sem Cursos")%>...</td>
					<%
				}
                                
                                if(rs_tit  != null){
                                  rs_tit.close();
                                  conexao.finalizaConexao(session.getId()+"RS2");
                                }

				%>
                          </tr>
			<% 
			if(fun_null){ //Funcionarios sem curso

                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, CA.CAR_NOME "+
                                      "FROM FUNCIONARIO F, CARGO CA "+
                                      "WHERE F.CAR_CODIGO = " +sel+ " "+
                                      "AND F.CAR_CODIGO = CA.CAR_CODIGO "+ fun_filtro + 
                                      "ORDER BY F.FUN_NOME";
                        }
                        else{

                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, CA.CAR_NOME "+
                                      "FROM FUNCIONARIO F, TITULO TI, CURSO C, TREINAMENTO T, QUEBRA Q, CARGO CA "+
                                      "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                      "AND T.CUR_CODIGO = C.CUR_CODIGO "+
                                      "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
                                      "AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                      "AND F.CAR_CODIGO = " +sel+ " "+
                                      "AND F.CAR_CODIGO = CA.CAR_CODIGO "+
                                      "AND T.PLA_CODIGO = " +usu_plano+ " "+ fun_filtro + 
                                      "ORDER BY F.FUN_NOME";
                        }

                          //out.println("FUN:"+query_fun);
			  rs_fun = conexao.executaConsulta(query_fun,session.getId()+"RS3");

                          if(rs_fun.next() && tem_curso){
                          	do{
                            		cont_tit = 0;
                            		%>
  			    		<tr>
					 <td valign="middle" align="center" class="celcnzrela">
                                	  <%=rs_fun.getString(2)%>
                                	 </td>
					<%
					fun_codigo = rs_fun.getString(1);
					for(int i=0; i<titulos.size(); i++){
		                                query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, TI.TIT_CODIGO, T.CUR_CODIGO, "+
	  	 	                                "T.TUR_CODIGO_REAL, T.JUS_CODIGO, Q.QBR_NOME "+
                 			                "FROM FUNCIONARIO F, TITULO TI, CURSO C, TREINAMENTO T, QUEBRA Q "+
                 			                "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                 			                "AND T.CUR_CODIGO = C.CUR_CODIGO "+
                 			                "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
                                        		"AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                        		"AND F.CAR_CODIGO = " +sel+ " "+
                                        		"AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                        		"AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " "+ fun_filtro;

                                	if(fun_null){ //Funcionarios sem curso
                                  		query = query + "UNION SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, -1, -1, -1, -1,'' "+
                                   				"FROM FUNCIONARIO F "+
                                   		                "WHERE F.CAR_CODIGO = " +sel+ " "+
                                   		                "AND F.FUN_CODIGO NOT IN ("+
                                   		                                          "SELECT DISTINCT F.FUN_CODIGO "+
                                   		                                          "FROM FUNCIONARIO F, TITULO TI, CURSO C, TREINAMENTO T, QUEBRA Q "+
                                   		                                          "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                   	 	                                          "AND T.CUR_CODIGO = C.CUR_CODIGO "+
                                                                             		  "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
                                                                            		  "AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                                                            		  "AND F.CAR_CODIGO = " +sel+ " "+
                                                                            		  "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                                                            		  "AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " "+
                                                  		") "+ fun_filtro +" ORDER BY FUN_NOME";
                                	}
                                	else{
                                  		query = query + "ORDER BY F.FUN_NOME ASC, T.TUR_CODIGO_REAL DESC";
                                	}
                                	//out.println("Query:" + query);
                                	rs = conexao.executaConsulta(query,session.getId()+"RS4");
                                	if(rs.next()){
                                  		contem = false;
                                  		do{
                                    			if(rs.getString(3).equals(titulos.elementAt(i))){
                                      				contem = true;
                                      				cont_tit++;
                                      				if(cont_tit <= titulos.size()){
                                        				if(rs.getString(5) != null){//Realizado
                                        					%>
                                          					<td valign="middle" align="center" class="celnortabvpeq"><%=rs.getString(7)%>/<%=usu_plano_desc%>
                                          					</td>
										<%
									}
									else if(rs.getString(6) != null){//Justificado
										%>
                                          					<td valign="middle" align="center" class="celnortabapeq"><%=rs.getString(7)%>/<%=usu_plano_desc%></td>
										<%
									}
									else{//Planejado
										%>
                                          					<td valign="middle" align="center" class="celnortabppeq"><%=rs.getString(7)%>/<%=usu_plano_desc%></td>
										<%
									}
                                      				}
                                    			} 
                                  		} while (rs.next());
                                    		if(!contem){
                                    			cont_tit++;
                                      			query_plano_car = "SELECT PLC_OBRIGATORIO, TIT_CODIGO "+
                                                        		"FROM PLANOCARREIRA "+
                                                        		"WHERE CAR_CODIGO = " +sel+ " "+
                                                        		"AND TIT_CODIGO = " +titulos.elementAt(i)+ " ";
                                      			rs_plan_car = conexao.executaConsulta(query_plano_car,session.getId()+"RS5");
                                      			
                                      			if(rs_plan_car.next() && cont_tit <= titulos.size()){
                                        			
                                       				String query1 = "SELECT TUR_VERSAO FROM TURMA WHERE TUR_CODIGO IN "+
                                       					 "(SELECT TUR_CODIGO_REAL FROM TREINAMENTO WHERE FUN_CODIGO = "+fun_codigo+")";
                                       				rs1 = conexao.executaConsulta(query1,session.getId()+"RS6");
                                       				rs1.next();
                                       				
                                       				String query2 = "SELECT CUR_VERSAOATUAL FROM CURSO WHERE tit_codigo = "+rs_plan_car.getString(2)+" "+
                                       						"and CUR_CODIGO IN (SELECT CUR_CODIGO FROM TREINAMENTO WHERE FUN_CODIGO = "+fun_codigo+")";
                                       				rs2 = conexao.executaConsulta(query2,session.getId()+"RS7");
                                       				if(rs2.next()){
                                       					if(rs1.getInt(1) == rs2.getInt(1)){
                                       						%>
                                         					<td valign="middle" align="center" class="celnortabv"> <lu><li></lu> </td>
										<%
                                       					}
	                                        			else if(rs_plan_car.getString(1).equals("S")){
	                                        				%>
	                                          				<td valign="middle" align="center" class="celnortabvv"> <lu><li></lu> </td>
										<%
									}								
									else{
										%>
				   						<td valign="middle" align="center" class="celnortabva"> <lu><li></lu> </td>
										<%
									}
								}
	                                        		else if(rs_plan_car.getString(1).equals("S")){
	                                        			%>
	                                          			<td valign="middle" align="center" class="celnortabvv"> <lu><li></lu> </td>
									<%
								}								
								else{
									%>
				   					<td valign="middle" align="center" class="celnortabva"> <lu><li></lu> </td>
									<%
								}
                                      			}
                                      			else if (cont_tit <= titulos.size()){
                                      				%>
                                          			<td valign="middle" align="center" class="celnortabva">&nbsp;</td>
								<%
							}

                                                        if(rs_plan_car  != null){
                                                            rs_plan_car.close();
                                                            conexao.finalizaConexao(session.getId()+"RS5");
                                                        }

                                    		}
                                	  	ultimo_fun = rs_fun.getString(1);
                                	}
                                         
                                        if(rs  != null){
                                            rs.close();
                                            conexao.finalizaConexao(session.getId()+"RS4");
                                        }
 				}
 			} while (rs_fun.next());
 		}
 	}
 	else{
 		%>
                        <p>&nbsp;
                        <table width="100%" border="0" cellspacing="1" cellpadding="2">
                          <tr> 
                            <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></td>
                          </tr>
                          <tr> 
                            <td align="center" class="celbrarela"><a class="lnk" href="01_gestaodetreinamento.jsp"><%=trd.Traduz("Voltar")%></a>
                         </tr>
                        </table>
		<%
	}
        
        if(rs  != null){
                                  rs.close();
                                  conexao.finalizaConexao(session.getId()+"RS15");
        }

        if(rs_fun  != null){
                                  rs_fun.close();
                                  conexao.finalizaConexao(session.getId()+"RS3");
        }

        if(rs1  != null){
                                                            rs1.close();
                                                            conexao.finalizaConexao(session.getId()+"RS6");
        }

        if(rs2  != null){
                                                            rs2.close();
                                                            conexao.finalizaConexao(session.getId()+"RS7");
        }

        //****************PARA SOLICITANTE**********************//
                    } else {

                      query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+sel;
                      rs = conexao.executaConsulta(query,session.getId()+"RS8");
                      if(rs.next()) {%>
			<%=trd.Traduz("SOLICITANTE")%>: <%=rs.getString(1)%>
<%			
			query_tit = "SELECT DISTINCT T.TIT_NOME, T.TIT_CODIGO "+
				    "FROM TITULO T, PLANOCARREIRA P, FUNCIONARIO F "+
                                    "WHERE F.FUN_CODSOLIC = " +sel+ " "+
                                    "AND F.CAR_CODIGO = P.CAR_CODIGO "+
                                    "AND T.TIT_CODIGO = P.TIT_CODIGO "+
                                    "ORDER BY T.TIT_CODIGO";
                        //out.println(query_tit);
			rs_tit = conexao.executaConsulta(query_tit,session.getId()+"RS10");
			if(rs_tit.next()) {
                          tem_curso = true;
			  do {
			    curso_nome_tit = rs_tit.getString(1);
			    cont++;
                            titulos.add(rs_tit.getString(2));%>
                            <td valign="middle" align="center" class="celcnzrela"><%=curso_nome_tit%></td>
<%			  } while(rs_tit.next());
			    //rs_tit.first();
			} else {
                          tem_curso = false;%>
			    <td valign="middle" align="center" class="celcnzrela"><%=trd.Traduz("Sem Cursos")%>...</td>
<%			}
                        if(rs_tit  != null){
                            rs_tit.close();
                            conexao.finalizaConexao(session.getId()+"RS10");
                        }

%>


                        </tr>
<%                      if (fun_null && tem_curso) {//Funcionarios sem curso
                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, F.CAR_CODIGO, CA.CAR_NOME "+
                                      "FROM FUNCIONARIO F, CARGO CA "+
                                      "WHERE F.FUN_CODSOLIC = " +sel+ " "+
                                      "AND F.CAR_CODIGO = CA.CAR_CODIGO "+
                                      "ORDER BY F.FUN_NOME";
                        } else {
                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, F.CAR_CODIGO, CA.CAR_NOME "+
                                      "FROM FUNCIONARIO F, TITULO TI, CURSO C, TREINAMENTO T, QUEBRA Q, CARGO CA "+
                                      "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                      "AND T.CUR_CODIGO = C.CUR_CODIGO "+
                                      "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
                                      "AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                      "AND F.CAR_CODIGO = CA.CAR_CODIGO "+
                                      "AND F.FUN_CODSOLIC = " +sel+ " "+
                                      "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                      "ORDER BY F.FUN_NOME";
                        }
                          //out.println("FUN:"+query_fun);
			  rs_fun = conexao.executaConsulta(query_fun,session.getId()+"RS11");

                          if (rs_fun.next()) {
                            do {
                              cont_tit = 0;%>
  			      <tr>
				<td valign="middle" align="center" class="celcnzrela">
                                  <%=rs_fun.getString(2)%>
                                  <BR>
                                  <%=rs_fun.getString(4)%>
                              </td>

<%                            for (int i=0; i<titulos.size(); i++) {
                           
                                query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, TI.TIT_CODIGO, T.CUR_CODIGO, "+
                                        "T.TUR_CODIGO_REAL, T.JUS_CODIGO, Q.QBR_NOME "+
                                        "FROM FUNCIONARIO F, TITULO TI, CURSO C, TREINAMENTO T, QUEBRA Q "+
                                        "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                        "AND T.CUR_CODIGO = C.CUR_CODIGO "+
                                        "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
                                        "AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                        "AND F.FUN_CODSOLIC = " +sel+ " "+
                                        "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                        "AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " ";

                                if (fun_null) { //Funcionarios sem curso
                                  query = query + "UNION SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, -1, -1, -1, -1, '' "+
                                                  "FROM FUNCIONARIO F "+
                                                  "WHERE F.CAR_CODIGO = " +sel+ " "+
                                                  "AND F.FUN_CODIGO NOT IN ("+
                                                                            "SELECT DISTINCT F.FUN_CODIGO "+
                                                                            "FROM FUNCIONARIO F, TITULO TI, CURSO C, TREINAMENTO T, QUEBRA Q "+
                                                                            "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                                                            "AND T.CUR_CODIGO = C.CUR_CODIGO "+
                                                                            "AND C.TIT_CODIGO = TI.TIT_CODIGO "+
                                                                            "AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                                                            "AND F.FUN_CODSOLIC = " +sel+ " "+
                                                                            "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                                                            "AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " "+
                                                  ") ORDER BY FUN_NOME";
                                } else {
                                  query = query + "ORDER BY F.FUN_NOME ASC, T.TUR_CODIGO_REAL DESC";
                                }

                                //out.println("Query:" + query);
	  	     	        rs = conexao.executaConsulta(query,session.getId()+"RS12");
                                if (rs.next()) {
                                  contem = false;
                                  do {
                                    if (rs.getString(3).equals(titulos.elementAt(i))){
                                      contem = true;
                                      cont_tit++;
                                      if (cont_tit <= titulos.size()) {
                                        if (rs.getString(5) != null) {//Realizado%>
                                          <td valign="middle" align="center" class="celnortabvpeq"><%=rs.getString(7)%>/<%=usu_plano_desc%></td>
<%                                      } else if (rs.getString(6) != null) {//Justificado%>
                                          <td valign="middle" align="center" class="celnortabapeq"><%=rs.getString(7)%>/<%=usu_plano_desc%></td>
<%                                      } else {//Planejado%>
                                          <td valign="middle" align="center" class="celnortabppeq"><%=rs.getString(7)%>/<%=usu_plano_desc%></td>
<%                                      }
                                      }
                                    } 
                                  } while (rs.next());
                                    if (!contem) {
                                      cont_tit++;
                                      query_plano_car = "SELECT PLC_OBRIGATORIO "+
                                                        "FROM PLANOCARREIRA "+
                                                        "WHERE CAR_CODIGO = " +rs_fun.getString(3)+ " "+
                                                        "AND TIT_CODIGO = " +titulos.elementAt(i)+ " ";
                                      rs_plan_car = conexao.executaConsulta(query_plano_car,session.getId()+"RS13");
                                      if (rs_plan_car.next() && cont_tit <= titulos.size()) {
                                        if (rs_plan_car.getString(1).equals("S")) {%>
                                          <td valign="middle" align="center" class="celnortabvv"> <lu><li></lu> </td>
<%                                      } else {%>
                                          <td valign="middle" align="center" class="celnortabva"> <lu><li></lu> </td>
<%                                      }
                                      } else if (cont_tit <= titulos.size()){%>
                                          <td valign="middle" align="center" class="celnortabva">&nbsp;</td>
<%                                    }
                                      if(rs_plan_car  != null){
                                         rs_plan_car.close();
                                         conexao.finalizaConexao(session.getId()+"RS13");
                                      }

                                    }
                                  ultimo_fun = rs_fun.getString(1);
                                } else {
                                  if (!contem) {
                                    cont_tit++;
                                    if (cont_tit <= titulos.size()) {%>
                                      <td valign="middle" align="center" class="celnortabva">&nbsp;</td>
<%                                  }
                                  }
                                  ultimo_fun = rs_fun.getString(1);
                                }
                                if(rs  != null){
                                   rs.close();
                                   conexao.finalizaConexao(session.getId()+"RS12");
                                }
                              }
                            } while (rs_fun.next());
                          }

                          if(rs_fun  != null){
                            rs_fun.close();
                            conexao.finalizaConexao(session.getId()+"RS11");
                          }

                      } else {%>
                        <p>&nbsp;
                        <table width="100%" border="0" cellspacing="1" cellpadding="2">
                          <tr> 
                            <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></td>
                          </tr>
                          <tr> 
                            <td align="center" class="celbrarela"><a class="lnk" href="01_gestaodetreinamento.jsp"><%=trd.Traduz("Voltar")%></a>
                          </tr>
                        </table>
<%                    }
                      if(rs  != null){
                            rs.close();
                            conexao.finalizaConexao(session.getId()+"RS8");
                      }
                    
                    }
%>

                  </td>
                </tr>
              </table>
            </center>
          </FORM>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
  <td><p>&nbsp;</p></td>
  </tr>
</table>

<%

%>

</body>
</html>
