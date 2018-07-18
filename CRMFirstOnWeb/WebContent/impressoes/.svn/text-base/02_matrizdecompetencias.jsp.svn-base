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
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  
Integer usu_plano = (Integer)session.getAttribute("usu_plano");  

String op="", curso_nome_comp="", query="", query_comp="", query_fun="", fun_cod="", titulo="", ultimo_fun="";
String query_fun_null="", query_plano_car="", query_ind_atual="", ind_atual="", valor="", tipo_valor="";
int sel=0, ind=0, cont=0, cont_func=0, cont_comp=0;
Vector competencias = new Vector();
boolean primeiro=false, contem=false, fun_null=false, tem_curso=false;

ResultSet rs = null, rs_comp = null, rs_fun = null, rs_ia = null, rs_plano = null;

//recupera valores
op = request.getParameter("radio1");//combo tipo filtro
if (request.getParameter("ind_requerido") != null && request.getParameter("ind_atual") != null) {
  tipo_valor = "B"; //ambos os tipos
} else if (request.getParameter("ind_requerido") != null) {
  tipo_valor = "R"; //requerido
} else if (request.getParameter("ind_atual") != null) {
  tipo_valor = "A"; //atual
}

//filtro selecao
if(op.equals("cargo"))
  sel = Integer.parseInt(request.getParameter("select_cargo"));
else
  sel = Integer.parseInt(request.getParameter("select_sol"));
//filtro funcionarios sem competencias
if(request.getParameter("fun_null") != null)
  fun_null = true;
else
  fun_null = false;
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("RELATORIO DE MATRIZ DE COMPETENCIAS")%></title>
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
<%    String query_plano = "SELECT PLA_NOME FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
    rs_plano = conexao.executaConsulta(query_plano,session.getId());
    if(rs_plano.next())%>
                <td class="trontrk" width="100%" align="center"><%=trd.Traduz("RelatOrio Matriz de COMPETENCIAS")%> / <%=rs_plano.getString(1)%></td>                              
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
                            <img src="../art/blue.gif" width="17" height="17"> = <%=trd.Traduz("INDICE ATUAL")%>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <img src="../art/green.gif" width="17" height="17"> = <%=trd.Traduz("INDICE REQUERIDO")%>
                        </td>
                    </tr>
                    <tr>
                        <td class="ftverdanacinza" align="center" colspan="100%"> * - <%=trd.Traduz("TERCEIRO")%> </td>
        </tr>
    </table>
                <p>
                <table width="100%" border="1" cellspacing="1" cellpadding="2">
                  <tr>
                    <td width="20%" class="celcnzrela" align="center" valign="middle">

<% 
if(rs!=null){
rs.close();
conexao.finalizaConexao(session.getId());
}

//****************PARA CARGO**********************//
                    if(op.equals("cargo")) {
                      query = "SELECT CAR_NOME FROM CARGO WHERE CAR_CODIGO = "+sel;
                      rs = conexao.executaConsulta(query,session.getId());
                      if(rs.next()) {%>
      <%=trd.Traduz("CARGO")%>: <%=rs.getString(1)%>
<%  
                        query_comp = "SELECT DISTINCT C.CMP_DESCRICAO, C.CMP_CODIGO FROM COMPETENCIA C, FUNCIONARIO F, COMP_CARGO CC "+
                                     "WHERE F.CAR_CODIGO = " +sel+ " "+
                                     "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                     "AND CC.CMP_CODIGO = C.CMP_CODIGO "+
                                     "ORDER BY CMP_DESCRICAO ";
                        //out.println(query_comp);
      rs_comp = conexao.executaConsulta(query_comp,session.getId()+"RS_1");
      if(rs_comp.next()) {
                          tem_curso = true;
        do {
          curso_nome_comp = rs_comp.getString(1);
          cont++;
                            competencias.add(rs_comp.getString(2));%>
                            <td valign="middle" align="center" class="celcnzrela"><%=curso_nome_comp%></td>
<%        } while(rs_comp.next());
            
          //rs_comp.first();
      } else {
                          tem_curso = false;%>
          <td valign="middle" align="center" class="celcnzrela"><%=trd.Traduz("SEM COMPETENCIAS")%>...</td>
<%      }
if(rs_comp!=null){
rs_comp.close();
conexao.finalizaConexao(session.getId()+"RS_1");
}

%>
                          </tr>
<%                      if (fun_null) { //Funcionarios sem curso

                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME "+
                                      "FROM FUNCIONARIO F "+
                                      "WHERE F.CAR_CODIGO = " +sel+ " AND "+
                                      "F.FUN_DEMITIDO = 'N' " +
                                      "ORDER BY F.FUN_NOME";
                        } else {

                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME "+
                                      "FROM FUNCIONARIO F, COMPETENCIA CO, COMP_CARGO CC, TREINAMENTO T, QUEBRA Q "+
                                      "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                      "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                      "AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                      "AND CO.CMP_CODIGO = CC.CMP_CODIGO "+
                                      "AND F.CAR_CODIGO = " +sel+ " "+
                                      "AND T.PLA_CODIGO = " +usu_plano+ " "+
                                      "AND F.FUN_DEMITIDO = 'N' " +
                                      "ORDER BY F.FUN_NOME";

                        }
              
        rs_fun = conexao.executaConsulta(query_fun,session.getId()+"RS_2");

                          if (rs_fun.next() && tem_curso) {
                            do {
                              cont_comp = 0;%>
              <tr>
        <td valign="middle" align="center" class="celcnzrela">
          <%=rs_fun.getString(2)%>
        </td>

<%                            for (int i=0; i<competencias.size(); i++) {

                                 query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, C.CMP_CODIGO, CC.INDICEREQUERIDO "+
                                         "FROM FUNCIONARIO F, COMPETENCIA C, COMP_CARGO CC, TREINAMENTO T "+
                                         "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                         "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                         "AND CC.CMP_CODIGO = C.CMP_CODIGO "+
                                         "AND F.CAR_CODIGO = " +sel+ " "+
                                         "AND F.FUN_DEMITIDO = 'N' " +
                                         "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                         "AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " ";

                                if (fun_null) { //Funcionarios sem curso
                                  query = query + "UNION SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, -1, -1 "+
                                                  "FROM FUNCIONARIO F "+
                                                  "WHERE F.CAR_CODIGO = " +sel+ " "+
                                                  "AND F.FUN_CODIGO NOT IN (SELECT DISTINCT F.FUN_CODIGO "+
                                                                           "FROM FUNCIONARIO F, COMPETENCIA C, COMP_CARGO CC, TREINAMENTO T "+
                                                                           "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                                                           "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                                                           "AND CC.CMP_CODIGO = C.CMP_CODIGO "+
                                                                           "AND F.CAR_CODIGO = " +sel+ " "+
                                                                           "AND F.FUN_DEMITIDO = 'N' " +
                                                                           "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                                                           "AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " "+
                                                                           ") "+
                                                  "ORDER BY FUN_NOME";
                                }

                                //out.println("Query:" + query);
                                rs = conexao.executaConsulta(query,session.getId()+"RS_3");
                                if (rs.next()) {
                                  contem = false;
                                  do {
                                    if (rs.getString(3).equals(competencias.elementAt(i))){
                                      contem = true;
                                      cont_comp++;
                                      query_ind_atual = "SELECT INDICEATUAL FROM COMP_FUNC "+
                                                        "WHERE FUN_CODIGO = " +rs.getString(1)+ " "+
                                                        "AND CMP_CODIGO = " +rs.getString(3)+ " ";
                                      rs_ia = conexao.executaConsulta(query_ind_atual,session.getId()+"RS_4");
                                      if (rs_ia.next()) {
                                        ind_atual = rs_ia.getString(1);
                                      } else {
                                        ind_atual = "&nbsp;&nbsp;&nbsp;";
                                      }
                                      if(rs_ia!=null){
                                        rs_ia.close();
                                        conexao.finalizaConexao(session.getId()+"RS_4");
                                        }
                                      if (cont_comp <= competencias.size()) {
                                        if (tipo_valor.equals("B")) {//ambos%>
                                          <td valign="middle" align="center" class="celnortabppeq">
                                            <tt class="celnortabvpeq"><%=rs.getString(4)%></tt>
                                            <tt>&nbsp;-&nbsp;</tt> 
                                            <tt class="celnortabapeq"><%=ind_atual%></tt>
                                          </td>
<%                                      }
                                        if (tipo_valor.equals("A")) {//atual%>
                                          <td valign="middle" align="center" class="celnortabppeq">
                                            <tt class="celnortabapeq"><%=ind_atual%></tt>
                                          </td>
<%                                      }
                                        if (tipo_valor.equals("R")) {//requerido%>
                                          <td valign="middle" align="center" class="celnortabppeq">
                                            <tt class="celnortabvpeq"><%=rs.getString(4)%></tt>
                                          </td>
<%                                      }
                                      }
                                    } 
                                  } while (rs.next());

                                    if (!contem) {//Nao contem%>
                                      <td valign="middle" align="center" class="celnortabva">&nbsp;</td>
<%                                  }

                                  ultimo_fun = rs_fun.getString(1);
                                }
                                if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId()+"RS_3");
                                    }
                              }
                            } while (rs_fun.next());
                          }
                        if(rs_fun!=null){
                            rs_fun.close();
                            conexao.finalizaConexao(session.getId()+"RS_2");
                        }
                      } else {%>
                        <p>&nbsp;
                        <table width="100%" border="0" cellspacing="1" cellpadding="2">
                          <tr> 
                            <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></td>
                          </tr>
                          <tr> 
                            <td align="center" class="celbrarela"><a class="lnk" href="01_matrizdecompetencias.jsp"><%=trd.Traduz("Voltar")%></a></tr>
                          </tr>
                        </table>
<%                    }
                    

                    //****************PARA SOLICITANTE**********************//
                    } else {

                      query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+sel;
                      rs = conexao.executaConsulta(query,session.getId());
                      if(rs.next()) {%>
                        <%=trd.Traduz("SOLICITANTE")%>: <%=rs.getString(1)%>
                        <%
                        query_comp = "SELECT DISTINCT C.CMP_DESCRICAO, C.CMP_CODIGO FROM COMPETENCIA C, FUNCIONARIO F, COMP_CARGO CC "+
                                     "WHERE F.FUN_CODSOLIC = " +sel+ " "+
                                     "AND F.FUN_DEMITIDO = 'N' " +
                                     "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                     "AND CC.CMP_CODIGO = C.CMP_CODIGO "+
                                     "ORDER BY CMP_DESCRICAO ";
                        //out.println(query_comp);
                        rs_comp = conexao.executaConsulta(query_comp,session.getId());
                            if(rs_comp.next()) {
                                tem_curso = true;
                            do {
                                curso_nome_comp = rs_comp.getString(1);
                                cont++;
                            competencias.add(rs_comp.getString(2));%>
                            <td valign="middle" align="center" class="celcnzrela"><%=curso_nome_comp%></td>
                <%        } while(rs_comp.next());
          //rs_comp.first();
                        } else {
                          tem_curso = false;%>
                    <td valign="middle" align="center" class="celcnzrela"><%=trd.Traduz("SEM COMPETENCIAS")%>...</td>
                    <%      }
                        if(rs_comp!=null){
                         rs_comp.close(); 
                        }
                        %>
                          </tr>
<%                      if (fun_null) { //Funcionarios sem curso

                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, CA.CAR_NOME "+
                                      "FROM FUNCIONARIO F, CARGO CA "+
                                      "WHERE F.FUN_CODSOLIC = " +sel+ " "+
                                      "AND F.FUN_DEMITIDO = 'N' " +
                                      "AND F.CAR_CODIGO = CA.CAR_CODIGO "+
                                      "ORDER BY F.FUN_NOME";
                        } else {

                          query_fun = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, CA.CAR_NOME "+
                                      "FROM FUNCIONARIO F, COMPETENCIA CO, COMP_CARGO CC, TREINAMENTO T, QUEBRA Q, CARGO CA "+
                                      "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                      "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                      "AND T.QBR_CODIGO = Q.QBR_CODIGO "+
                                      "AND CO.CMP_CODIGO = CC.CMP_CODIGO "+
                                      "AND F.CAR_CODIGO = CA.CAR_CODIGO "+
                                      "AND F.FUN_CODSOLIC = " +sel+ " "+
                                      "AND F.FUN_DEMITIDO = 'N' " +
                                      "AND T.PLA_CODIGO = " +usu_plano+ " "+
                                      "ORDER BY F.FUN_NOME";

                        }

                          //out.println("FUN:"+query_fun);
        rs_fun = conexao.executaConsulta(query_fun,session.getId()+"RS");

                          if (rs_fun.next() && tem_curso) {
                            do {
                              cont_comp = 0;%>
              <tr>
        <td valign="middle" align="center" class="celcnzrela">
                                  <%=rs_fun.getString(2)%>
                                  <BR>
                                  <%=rs_fun.getString(3)%>
                                </td>

<%                            for (int i=0; i<competencias.size(); i++) {

                                 query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, C.CMP_CODIGO, CC.INDICEREQUERIDO "+
                                         "FROM FUNCIONARIO F, COMPETENCIA C, COMP_CARGO CC, TREINAMENTO T "+
                                         "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                         "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                         "AND CC.CMP_CODIGO = C.CMP_CODIGO "+
                                         "AND F.FUN_CODSOLIC = " +sel+ " "+
                                         "AND F.FUN_DEMITIDO = 'N' " +
                                         "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                         "AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " ";

                                if (fun_null) { //Funcionarios sem curso
                                  query = query + "UNION SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, -1, -1 "+
                                                  "FROM FUNCIONARIO F "+
                                                  "WHERE F.FUN_CODSOLIC = " +sel+ " "+
                                                  "AND F.FUN_CODIGO NOT IN (SELECT DISTINCT F.FUN_CODIGO "+
                                                                           "FROM FUNCIONARIO F, COMPETENCIA C, COMP_CARGO CC, TREINAMENTO T "+
                                                                           "WHERE F.FUN_CODIGO = T.FUN_CODIGO "+
                                                                           "AND F.CAR_CODIGO = CC.CAR_CODIGO "+
                                                                           "AND CC.CMP_CODIGO = C.CMP_CODIGO "+
                                                                           "AND F.FUN_CODSOLIC = " +sel+ " "+
                                                                           "AND F.FUN_DEMITIDO = 'N' " +
                                                                           "AND T.PLA_CODIGO = " +usu_plano+ " "+ 
                                                                           "AND F.FUN_CODIGO = " +rs_fun.getString(1)+ " "+
                                                                           ") "+
                                                  "ORDER BY FUN_NOME";
                                }

                                //out.println("Query:" + query);
                                rs = conexao.executaConsulta(query,session.getId()+"OI");
                                if (rs.next()) {
                                  contem = false;
                                  do {
                                    if (rs.getString(3).equals(competencias.elementAt(i))){
                                      contem = true;
                                      cont_comp++;
                                      query_ind_atual = "SELECT INDICEATUAL FROM COMP_FUNC "+
                                                        "WHERE FUN_CODIGO = " +rs.getString(1)+ " "+
                                                        "AND CMP_CODIGO = " +rs.getString(3)+ " ";
                                      rs_ia = conexao.executaConsulta(query_ind_atual,session.getId()+"RS_3");
                                      if (rs_ia.next()) {
                                        ind_atual = rs_ia.getString(1);
                                      } else {
                                        ind_atual = "&nbsp;&nbsp;&nbsp;";
                                      }
                                      if(rs_ia!=null){rs_ia.close();conexao.finalizaConexao(session.getId()+"RS_3");}  
                                      if (cont_comp <= competencias.size()) {
                                        if (tipo_valor.equals("B")) {//ambos%>
                                          <td valign="middle" align="center" class="celnortabppeq">
                                            <tt class="celnortabvpeq"><%=rs.getString(4)%></tt>
                                            <tt>&nbsp;-&nbsp;</tt> 
                                            <tt class="celnortabapeq"><%=ind_atual%></tt>
                                          </td>
<%                                      }
                                        if (tipo_valor.equals("A")) {//atual%>
                                          <td valign="middle" align="center" class="celnortabppeq">
                                            <tt class="celnortabapeq"><%=ind_atual%></tt>
                                          </td>
<%                                      }
                                        if (tipo_valor.equals("R")) {//requerido%>
                                          <td valign="middle" align="center" class="celnortabppeq">
                                            <tt class="celnortabvpeq"><%=rs.getString(4)%></tt>
                                          </td>
<%                                      }
                                      }
                                    } 
                                  } while (rs.next());

                                    if (!contem) {//Nao contem%>
                                      <td valign="middle" align="center" class="celnortabva">&nbsp;</td>
<%                                  }

                                  ultimo_fun = rs_fun.getString(1);
                                }
                                if(rs!=null){
                                    rs.close();
                                    conexao.finalizaConexao(session.getId());
                                    }    
                              }
                            } while (rs_fun.next());
                          }
                      } else {%>
                        <p>&nbsp;
                        <table width="100%" border="0" cellspacing="1" cellpadding="2">
                          <tr> 
                            <td align="center" class="celbrarela"><%=trd.Traduz("NENHUM ITEM SELECIONADO")%></td>
                          </tr>
                          <tr> 
                            <td align="center" class="celbrarela"><a class="lnk" href="01_matrizdecompetencias.jsp"><%=trd.Traduz("Voltar")%></a></tr>
                          </tr>
                        </table>
<%                    }
                    }%>
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
if(rs != null){
 rs.close();
    conexao.finalizaConexao(session.getId());
}
if(rs_fun != null){
 rs_fun.close();
    conexao.finalizaConexao(session.getId()+"RS");
}

%>
</body>
</html>
