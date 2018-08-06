<!--
Nome do arquivo: registro/06_criarturmaantecipada.jsp
Nome da funcionalidade: Criaçao de Turma Antecipada
Função: Oferecer a lista das turmas antecipadas e longa duracao
Variáveis necessárias/ Requisitos: 
- sessao: 
- parametro: 
Regras de negócio (pagina):
- validar: 
- validar: 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Histórico
Data de atualizacao: 11/03/2003 - Desenvolvedor: Marcelo Marques
Atividade: padronizacao da página; acerto dos contadores de vagas
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*, java.text.*"%>
<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
%>

<!--***FUNÇÕES JAVA SCRIPT***-->
<script language="JavaScript">
  function filtra() {
    frm.action ="06_criarturmaantecipada.jsp";
    frm.submit();
    return false;  
  }

  function exclui(){
    if(frm.int_checks.value == 0){
      alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
  } else {
      if(confirm(<%=("\""+trd.Traduz("Deseja excluir o item selecionado?")+"\"")%>)) {
        frm.action ="10_turmaantecipada_deleta.jsp";
        frm.submit();
      } else {
        return false;  
      }
    }  
  }

  function inclui(){
    document.frm.tipo.value = "I";
    frm.action ="10_criacaoturmaantecipada.jsp";
    frm.submit();
    return false;  
  }

  function altera(){
    if(frm.int_checks.value == 0){
      alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
  } else {
      document.frm.tipo.value = "A";
      frm.action ="10_criacaoturmaantecipada.jsp";
      frm.submit();
      return false;  
    }
  }

  function registra(turma){
    document.frm.turma.value = turma;
    frm.action = "10_turmaantecipada_reg.jsp";
    frm.submit();
    return false;  
  }
</script>

<!--***FUNÇÕES JSP***-->

<%
//try {

//configuracao de cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");

//***DECLARAÇÃO DE VARIÁVEIS***
boolean boo_bloquear = false, boo_check = false, boo_existe = false;
int int_qtd_inscritos = 0, int_checks = 0, int_i = 0;
ResultSet res_rs= null, res_rsv = null, res_inscritos = null;
String str_query = "", str_query_inscritos = "", str_cur = "", str_oi = "", str_oia = "", str_ponto = "";
String str_estilo = "", str_dataf = "", str_datai = "", str_par = "";
Vector vet_desc = new Vector(),  vet_cust = new Vector();
SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

//***RECUPERCAO DE PARAMETROS***
//valores de sessao
String usu_tipo    = (String) session.getAttribute("usu_tipo"); 
String usu_nome    = (String) session.getAttribute("usu_nome"); 
String usu_login  = (String) session.getAttribute("usu_login"); 
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi");
Integer usu_plano   = (Integer)session.getAttribute("usu_plano"); 
Integer usu_cod    = (Integer)session.getAttribute("usu_cod"); 
//valores da pagina
str_cur = ((request.getParameter("selectcur1") == null)?"":(String)request.getParameter("selectcur1"));

//***CORPO DA PÁGINA***

//realiza conexao

//seta os vetores de custo
vet_desc.clear();
vet_cust.clear();
request.getSession(true);
session.setAttribute("vet_descS",vet_desc);
session.setAttribute("vet_custS",vet_cust);

//Verifica Bloqueio de Funcionalidades
str_query = "SELECT PLA_REGISTROTREINAMENTO FROM PLANO WHERE PLA_CODIGO = "+usu_plano;
res_rs= conexao.executaConsulta(str_query, session.getId());
if (res_rs.next()) {
  if(res_rs.getString(1) != null) {
    if(res_rs.getString(1).equals("N")){
      boo_bloquear = true;
    }
  }
}
if(res_rs!=null){
res_rs.close();
conexao.finalizaConexao(session.getId());
}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Criar Planejamento de Turma")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
              <%str_ponto = (String)session.getAttribute("barra");
                if(str_ponto.equals("..")){%>
                  <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
              <%}else{%> 
                  <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
              <%}%>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td class="mnfundo"><img src="../art/bit.gif" width="12" height="5"></td>
        </tr>
        <tr> 
          <td height="25" class="mnfundo"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <%if(str_ponto.equals("..")){    
                    if (request.getParameter("op") == null){
                      str_oi = "../menu/menu.jsp?op="+"R";
                    } else {
                      str_oi = "../menu/menu.jsp?op="+request.getParameter("op");
                    }
                    if (request.getParameter("opt") == null){
                      str_oia = "../menu/menu1.jsp?opt="+"CTA";
                    } else {
                      str_oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
                    }
                  } else {
                    if (request.getParameter("op") == null){
                      str_oi = "/menu/menu.jsp?op="+"R";
                    } else {
                      str_oi = "/menu/menu.jsp?op="+request.getParameter("op");
                    }
                    if (request.getParameter("opt") == null){
                      str_oia = "/menu/menu1.jsp?opt="+"CTA";
                    } else {
                      str_oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
                    }
                  }%>
                  <jsp:include page="<%=str_oi%>" flush="true"></jsp:include>
              </tr>
            </table>
          </td>
        </tr>
      <jsp:include page="<%=str_oia%>" flush="true"></jsp:include>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" align="center"><%=trd.Traduz("CRIAR PLANEJAMENTO DE TURMA")%></td>
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
                <td height="2"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td height="55" class="ctfontc" align="center"><%=trd.Traduz("CURSO")%>: 
                <select name="selectcur1">
                  <option value="-1" selected><%=trd.Traduz("Todos")%></option>
                  <%str_query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO " + 
                            "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' ORDER BY CUR_NOME";
                    res_rs= conexao.executaConsulta(str_query,session.getId()+"RS_1");
                    if (res_rs.next()) {
                      do {
                        if (res_rs.getString(1).equals(str_cur)) {%>
                          <option value = "<%=res_rs.getString(1)%>" selected><%=res_rs.getString(2)%></option>
                      <%} else {%>
                          <option value = "<%=res_rs.getString(1)%>"><%=res_rs.getString(2)%></option><%
                        }
                      } while (res_rs.next());
                    }
                    if(res_rs!=null){
                    res_rs.close();
                    conexao.finalizaConexao(session.getId()+"RS_1");
                    }
                    %>
                    </select>
                    &nbsp; &nbsp; 
                    <input type="button"  onClick="return filtra();"  value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button">
                  </td>
                </tr>
                <tr>
                  <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td height="51"> 
                    <div align="center"><img src="../art/bit.gif" width="1" height="1"> 
                      <table border="0" cellspacing="3" cellpadding="0" width="100%">
                        <tr class="ctfontb"> 
                          <td width="25%"><img src="../art/black.gif">
                            &nbsp;= <%=trd.Traduz("Nº PARTICIPANTES OK")%></td>
                          <td width="25%"><img src="../art/red.gif">
                            &nbsp;=<%=trd.Traduz("Nº DE PARTICIPANTES EXCEDIDO")%></td>
                          <td width="25%"><img src="../art/blue.gif"> 
                            &nbsp;=<%=trd.Traduz("Nº DE PARTICIPANTES ABAIXO")%></td>
                          <td width="25%"><img src="../art/green.gif">
                            &nbsp;=<%=trd.Traduz("TURMA REGISTRADA")%></td>
                        </tr>
                      </table>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                </tr>
                <tr> 
                  <td>&nbsp;<br>
                    <%if(str_cur.equals("-1")){
                      str_query = "SELECT TURMA.TUR_CODIGO, CURSO.CUR_NOME, TURMA.TUR_DATAINICIO, " + 
                              " TURMA.TUR_DATAFINAL, TIPOCURSO.TCU_NOME, TURMA.TUR_VAGAS, " + 
                              " TURMA.TUR_PARTICIPMIN, TURMA.TUR_PARTICIPMAX, TUR_REGISTRADA, TIPOTREINAMENTO.TTR_NOME, TURMA.TUR_PARTICIPMAX FROM " + 
                              " TURMA, CURSO, TIPOCURSO, TIPOTREINAMENTO WHERE  " + 
                              " CURSO.CUR_CODIGO = TURMA.CUR_CODIGO AND " +
                            //" TURMA.PLA_CODIGO = " + usu_plano + " AND "+//caso queria apenas os dados do plano em questAo//
                              " TIPOTREINAMENTO.TTR_CODIGO = TURMA.TTR_CODIGO AND " +
                              " TIPOCURSO.TCU_CODIGO = TURMA.TCU_CODIGO AND " + 
                              " TURMA.TUR_PLANEJADA = 'S' AND " + 
                              " (TIPOTREINAMENTO.TTR_CODIGO = 2 OR TIPOTREINAMENTO.TTR_CODIGO = 3) " +
                              " ORDER BY CURSO.CUR_NOME, TIPOTREINAMENTO.TTR_NOME, TURMA.TUR_DATAINICIO";
                      } else if (!(str_cur.equals(""))) {
                        str_query = "SELECT TURMA.TUR_CODIGO, CURSO.CUR_NOME, TURMA.TUR_DATAINICIO, " + 
                                " TURMA.TUR_DATAFINAL, TIPOCURSO.TCU_NOME, TURMA.TUR_VAGAS, " + 
                                " TURMA.TUR_PARTICIPMIN, TURMA.TUR_PARTICIPMAX, TURMA.TUR_REGISTRADA, TIPOTREINAMENTO.TTR_NOME, TURMA.TUR_PARTICIPMAX FROM " + 
                                " TURMA, CURSO, TIPOCURSO, TIPOTREINAMENTO WHERE  " + 
                                " CURSO.CUR_CODIGO = TURMA.CUR_CODIGO AND " +
                              //" TURMA.PLA_CODIGO = " + usu_plano + " AND "+//caso queria apenas os dados do plano em questAo//
                                " TIPOTREINAMENTO.TTR_CODIGO = TURMA.TTR_CODIGO AND " +
                                " TIPOCURSO.TCU_CODIGO = TURMA.TCU_CODIGO AND " + 
                              //" TURMA.TUR_REGISTRADA = 'S' AND TURMA.TUR_PLANEJADA = 'S' " + 
                                " TURMA.TUR_PLANEJADA = 'S' " + 
                                " AND TURMA.CUR_CODIGO = " + str_cur + "  " + 
                                " UNION SELECT TURMA.TUR_CODIGO, CURSO.CUR_NOME, TURMA.TUR_DATAINICIO, " + 
                                " TURMA.TUR_DATAFINAL, TIPOCURSO.TCU_NOME, TURMA.TUR_VAGAS, " + 
                                " TURMA.TUR_PARTICIPMIN, TURMA.TUR_PARTICIPMAX, TURMA.TUR_REGISTRADA, TIPOTREINAMENTO.TTR_NOME, TURMA.TUR_PARTICIPMAX FROM " + 
                                " TURMA, CURSO, TIPOCURSO, TIPOTREINAMENTO WHERE  " + 
                                " CURSO.CUR_CODIGO = TURMA.CUR_CODIGO AND " +
                              //" TURMA.PLA_CODIGO = " + usu_plano + " AND "+//caso queria apenas os dados do plano em questAo//
                                " TIPOTREINAMENTO.TTR_CODIGO = TURMA.TTR_CODIGO AND " +
                                " TIPOCURSO.TCU_CODIGO = TURMA.TCU_CODIGO AND " + 
                              //" TURMA.TUR_REGISTRADA = 'S' AND " + 
                                " TURMA.TUR_PLANEJADA = 'S' " + 
                                " AND TUR_CODIGO IN (SELECT TUR_CODIGO_PLAN_ANT FROM TREINAMENTO WHERE " + 
                                " TTR_CODIGO = 2 AND TUR_CODIGO_PLAN_ANT IS NOT NULL)" + 
                                " AND TURMA.CUR_CODIGO = " + str_cur + " ORDER BY CURSO.CUR_NOME, TIPOTREINAMENTO.TTR_NOME, TUR_DATAINICIO";
                      } else{ 
                        str_query = "SELECT TURMA.TUR_CODIGO, CURSO.CUR_NOME, TURMA.TUR_DATAINICIO, " + 
                                " TURMA.TUR_DATAFINAL, TIPOCURSO.TCU_NOME, TURMA.TUR_VAGAS, " + 
                                " TURMA.TUR_PARTICIPMIN, TURMA.TUR_PARTICIPMAX, TUR_REGISTRADA, TIPOTREINAMENTO.TTR_NOME, TURMA.TUR_PARTICIPMAX FROM " + 
                                " TURMA, CURSO, TIPOCURSO, TIPOTREINAMENTO WHERE  " + 
                                " CURSO.CUR_CODIGO = TURMA.CUR_CODIGO AND " +
                              //" TURMA.PLA_CODIGO = " + usu_plano + " AND "+//caso queria apenas os dados do plano em questAo//
                                " TIPOTREINAMENTO.TTR_CODIGO = TURMA.TTR_CODIGO AND " +
                                " TIPOCURSO.TCU_CODIGO = TURMA.TCU_CODIGO AND " + 
                                //" TURMA.TUR_REGISTRADA = 'N' " + 
								" TURMA.TUR_PLANEJADA = 'S' AND " + 
                                " (TIPOTREINAMENTO.TTR_CODIGO = 2 OR TIPOTREINAMENTO.TTR_CODIGO = 3) " +
                                " ORDER BY CURSO.CUR_NOME, TIPOTREINAMENTO.TTR_NOME, TURMA.TUR_DATAINICIO";
                      }
//out.println("str_query = " + str_query);

                      int_i= 1;
                      //out.println(str_query);
                      res_rs= conexao.executaConsulta(str_query,session.getId()+"RS_2");
                      if(res_rs.next()){
                        boo_existe= true;
                      }
                    
                      if(boo_bloquear == false){%>
                      <center>
                        <table>
                          <tr> 
                            <td> 
                              <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                                <tr> 
                                  <td onMouseOver="this.className='ctonlnk2';" onClick="return inclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("CRIAR TURMA")%></a></td>
                                </tr>
                              </table>
                            </td>
                            <%if(boo_existe) {%>
                            <td> 
                              <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                                <tr> 
                                  <td onMouseOver="this.className='ctonlnk2';" onClick="return exclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
                                </tr>
                              </table>
                            </td>
                            <td> 
                              <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                                <tr> 
                                  <td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                                </tr>
                              </table>
                            </td>
                            <%}%>
                          </tr>
                        </table>
                      </center>
                  <%}//if(boo_bloquear == false) %>
                    <br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr valign="top"> 
                        <td width="48%"> 
                          <table border="0" cellspacing="1" cellpadding="2" width="100%">
                            <tr class="celtittab"> 
                            <%if (boo_existe){
                                if(boo_bloquear == false){%>
                                  <td width="3%" align="center"></td>
                              <%}%>
                              <td width="32%"><%=trd.Traduz("CURSO")%></td>
                              <td width="15%"><%=trd.Traduz("TIPO TURMA")%></td>
                              <td width="10%"><%=trd.Traduz("DATA INICIAL")%></td>
                              <td width="12%"><%=trd.Traduz("DATA FINAL")%></td>
                              <td width="7%"><%=trd.Traduz("TIPO")%></td>
                              <td width="7%"><%=trd.Traduz("N. PART. MAXIMO")%></td>
                              <td width="7%"><%=trd.Traduz("INSCRITOS")%></td>
                              <td width="7%"><%=trd.Traduz("VAGAS")%></td>
                            </tr>
                              <%do{
                                  int_i++;
                                  /*************************************************
                                  ROTINA TEMPORARIA PARA CORRECAO DO NUMERO DE VAGAS
                                  **************************************************/
                                  str_query = "UPDATE TURMA SET "+
                                              "TUR_VAGAS = (TUR_PARTICIPMAX - (SELECT COUNT(*) FROM TREINAMENTO WHERE TUR_CODIGO_PLAN_ANT = " +res_rs.getString(1)+ ")) "+
                                              "WHERE TUR_CODIGO = " + res_rs.getString(1);
                                  conexao.executaAlteracao(str_query);
                                  /*************************************************/
                                  if (res_rs.getInt(6)==0){
                                    str_estilo="celnortab";//numero participantes ok
                                  }
                                  else {
                                    if (res_rs.getInt(6) > 0){
                                      str_estilo="celnortaba";//numero participantes abaixo
                                    }
                                    else{ 
                                      if (res_rs.getInt(6) < 0){
                                        str_estilo="celnortabvv";//numero participantes excedido
                                      }
                                    }
                                  }
                                  if (res_rs.getString(9).equals("S")){
                                    str_estilo="celnortabv";//turma registrada
                                  }
                                  //out.println("str_estilo:"+str_estilo);%>
                                  <tr class="<%=str_estilo%>">
                                  <%if(boo_bloquear == false) {%>
                                    <td width="3%" align="center"> 
                                    <%if (res_rs.getString(9).equals("N")){
                                        int_checks = int_checks + 1;
                                        if (boo_check== false){
                                          boo_check= true;%>
                                          <input type="radio" name="rdo_turma" checked value="<%=res_rs.getString(1)%>">
                                      <%} else {%>
                                          <input type="radio" name="rdo_turma" value="<%=res_rs.getString(1)%>">
                                      <%}
                                      }%>
                                      </td>
                                  <%}
                                    //if(boo_bloquear == false)%>
                                    <td width="32%">
                                    <%if (res_rs.getString(9).equals("N")){%>
                                      <a class="lnk" href="#" onClick="return registra(<%=res_rs.getString(1)%>)"> 
                                    <%}%>
						            <%=res_rs.getString(2)%></td>
                                    <%java.util.Date dia1 = res_rs.getDate(3);
                                      java.util.Date dia2 = res_rs.getDate(4);
                                      str_datai = formato.format(dia1);
                                      str_dataf = formato.format(dia2);
                                      if (usu_tipo.equals("F")) {
                                        str_par = "";
                                      } else {
                                        if (usu_tipo.equals("P") || usu_tipo.equals("G")) {
                                          str_par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " "; 
                                        } else {
                                          if (usu_tipo.equals("S"))
                                            str_par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " AND FUNCIONARIO.FUN_CODSOLIC = " + usu_cod + " "; 
                                        }
                                      }

                                        str_query_inscritos = "SELECT COUNT(FUNCIONARIO.FUN_CODIGO) "+
                                                          "FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, "+
                                                          "TABELA3, TABELA2, FILIAL, TREINAMENTO "+ 
                                                          "WHERE SOLICITANTE.FUN_CODIGO =* FUNCIONARIO.FUN_CODSOLIC "+
                                                          "AND FUNCIONARIO.FUN_DEMITIDO = 'N' "+
                                                          "AND CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO "+
                                                          "AND DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO "+
                                                          "AND TABELA3.TB3_CODIGO =* FUNCIONARIO.TB3_CODIGO "+
                                                          "AND TABELA2.TB2_CODIGO =* FUNCIONARIO.TB2_CODIGO "+
                                                          "AND FILIAL.FIL_CODIGO =* FUNCIONARIO.FIL_CODIGO " +str_par+ " "+
                                                          "AND FUNCIONARIO.FUN_CODIGO = TREINAMENTO.FUN_CODIGO "+
                                                          "AND TREINAMENTO.TUR_CODIGO_PLAN_ANT = " +res_rs.getString(1)+ " ";
                                        res_inscritos = conexao.executaConsulta(str_query_inscritos,session.getId()+"RS_3");
                                        if(res_inscritos.next()) {
                                          int_qtd_inscritos = res_inscritos.getInt(1);
					}
                                        if(res_inscritos!=null){
                                           res_inscritos.close();
                                           conexao.finalizaConexao(session.getId()+"RS_3");
                                        }    
                                            %>
                                        <td width="15%"><%=res_rs.getString(10)%></td>
                                        <td width="10%"><%=str_datai%></td>
                                        <td width="12%"><%=str_dataf%></td>
                                        <td width="7%"><%=res_rs.getString(5)%></td>
                                        <td width="7%"><%=res_rs.getString(11)%></td>
                                        <td width="7%"><%=int_qtd_inscritos%></td>
                                        <td width="7%"><%=res_rs.getInt(6)%></td>
                                      </tr>
                              <%} while (res_rs.next());
                              } else {%>
                                <td align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                            <%}
                            if(res_rs!=null){
                                res_rs.close();
                                conexao.finalizaConexao(session.getId()+"RS_2"); 
                            } 
                            %>                            
                          </table>
                        </td>
                      </tr>
                    </table>
                    <br>
                    &nbsp; </td>
                </tr>
              </table>
          </td>
          <input type="hidden" name="tipo">
          <input type="hidden" name="turma">
          <input type="hidden" name="int_checks" value="<%=int_checks%>">
          </FORM>
          <td width="20" valign="top"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
            <% if(str_ponto.equals("..")){%>
              <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
            <%}else{%>
              <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
      <%}%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%


//} catch(Exception e){
//  out.println("Erro:"+e);
//}
%>