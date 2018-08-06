<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>
<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />


<!--PROPRIEDADES DA PAGINA DE FILTRO
* Treinamentos efetuados: 
- campos utilizados: tipo de registro, tipo de dado, relatorio, agrupamento
- filtros obrigatorios: filial, tipo funcionario, tipo registro 
* Treinamentos nAo efetuados: 
- campos utilizados: tipo de dado, relatorio
- filtros obrigatorios: curso, tipo funcionario
* Treinamentos por funcionArio: 
- campos utilizados: horas/dia
- filtros obrigatorios:
-->

<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

ResultSet rs = null;
String query = "", filial = ""+usu_fil, codigo = ""+usu_cod;

//Variaveis da pagina
String pag_filial = (request.getParameter("sel_filial")==null)?"":request.getParameter("sel_filial");
String pag_depto = (request.getParameter("sel_depto")==null)?"":request.getParameter("sel_depto");
String pag_tab2 = (request.getParameter("sel_tabela2")==null)?"":request.getParameter("sel_tabela2");
String pag_tab3 = (request.getParameter("sel_tabela3")==null)?"":request.getParameter("sel_tabela3");
String pag_cargo = (request.getParameter("sel_cargo")==null)?"":request.getParameter("sel_cargo");
String pag_tab1 = (request.getParameter("sel_tabela1")==null)?"":request.getParameter("sel_tabela1");
String pag_empresa = (request.getParameter("sel_empresa")==null)?"":request.getParameter("sel_empresa");
String pag_curso = (request.getParameter("sel_curso")==null)?"":request.getParameter("sel_curso");
String pag_titulo = (request.getParameter("sel_titulo")==null)?"":request.getParameter("sel_titulo");
String pag_tab4 = (request.getParameter("sel_tabela4")==null)?"":request.getParameter("sel_tabela4");
String pag_func = (request.getParameter("sel_funcionario")==null)?"":request.getParameter("sel_funcionario");
String pag_solic = (request.getParameter("sel_solic")==null)?"":request.getParameter("sel_solic");
String pag_dt_inicio = (request.getParameter("text_datainicio")==null)?"":request.getParameter("text_datainicio");
String pag_dt_fim = (request.getParameter("text_datafinal")==null)?"":request.getParameter("text_datafinal");
String pag_rdo_ord = (request.getParameter("rb_ord")==null)?"":request.getParameter("rb_ord");
String pag_rdo_dados = (request.getParameter("rb_dados")==null)?"":request.getParameter("rb_dados");
String pag_rdo_relat = (request.getParameter("rb_relat")==null)?"E":request.getParameter("rb_relat");
String pag_plano = (request.getParameter("sel_plano")==null)?"":request.getParameter("sel_plano");
String pag_tipo = (request.getParameter("sel_tipo")==null)?"":request.getParameter("sel_tipo");
String pag_horas = (request.getParameter("horas")==null)?"":request.getParameter("horas");

//try {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("ImpressOes")%> - <%=trd.Traduz("Treinamentos")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function atualiza_func() {
  frm.action = "01_treinamentos.jsp";
  frm.submit();
}

function filtra() {

<%if(pag_rdo_relat.equals("E") || pag_rdo_relat.equals("N")){%>
  if (frm.sel_filial.value == "") {
    alert(<%=("\""+trd.Traduz("Favor selecionar a filial!")+"\"")%>);
    frm.sel_filial.focus;
    return false;
  }
<%}%>
<%if(pag_rdo_relat.equals("F")){%>
  if (frm.horas.value == "") {
    alert(<%=("\""+trd.Traduz("Favor digitar horas/dia!")+"\"")%>);
    frm.horas.focus;
    return false;
  }
<%}%>
<%if(pag_rdo_relat.equals("E")){%>
  if ((frm.cb_lista.checked == false) && (frm.cb_rapido.checked == false) && (frm.cb_duracao.checked == false) && (frm.cb_turma.checked == false) && (frm.cb_anteriores.checked == false)) {
    alert(<%=("\""+trd.Traduz("Favor selecionar um Tipo de Registro!")+"\"")%>);
    return false;
  }
<%}%>
  if (frm.check_a.checked == false && frm.check_t.checked == false && frm.check_d.checked == false) {
    alert(<%=("\""+trd.Traduz("Favor selecionar o Tipo de Funcionario!")+"\"")%>);
    return false;
  }

  if (frm.rb_relat[0].checked) frm.action ="02_treinamentosefetuados.jsp";
  if (frm.rb_relat[1].checked) frm.action ="02_treinamentosnaoefetuados.jsp";
  if (frm.rb_relat[2].checked) frm.action ="02_treinamentosporfuncionario.jsp";

  frm.submit();
  return false;	
}

function FormataData(campo, evento, direcao){
	if (campo.value.length < 10000){
		if (evento != 9 ){//tab
			if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
				var tam = campo.value.length
				if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)) {
					if (tam == 2 || tam == 5){
						campo.value = campo.value + "/";
						}
					} 
				else{
					if (direcao == "up"){
						if (campo.value.length == 0){
							campo.value = ""
							}
						else{
							campo.value = campo.value.substring(0,campo.value.length-1)
							}
						}
					}
				campo.focus()
				}
			} 
		else{
			if (direcao == "down"){
				ChecaData(campo)
				}
			}
		}
	}

function ChecaData(THISDATE){
	var erro = 0
	var data = THISDATE.value
	if (data.length != 10) 
		erro=1
	var dia = data.substring(0, 2)// dia
	var barra1 = data.substring(2, 3)// '/'
	var mes = data.substring(3, 5)// mes
	var barra2 = data.substring(5, 6)// '/'
	var ano = data.substring(6, 10)// ano
		
	if (mes < 1 || mes > 12) 
		erro = 1
	if (dia < 1 || dia > 31) 
		erro = 1
	if (ano < 1990) 
		erro = 1
	if (mes == 4 || mes == 6 || mes == 9 || mes == 11){
		if (dia == 31) 
			erro = 1
			}
	if (mes == 2){
		var bis = parseInt(ano/4)
		if (isNaN(bis)){
			erro = 1
			}
		if (dia > 29) 
			erro = 1
		if (dia == 29 && ((ano/4) != parseInt(ano/4))) 
			erro = 1
		}
	if ((erro == 1) && (THISDATE.value != "")) {
		alert(THISDATE.value + ' <%=trd.Traduz("E uma data invAlida!")%>');
		THISDATE.value = "";
		}
	}
function DoCal(elTarget){
	if (showModalDialog){
		var sRtn;
		sRtn = showModalDialog("calendar.htm","","center=yes;status=no;dialogWidth=306px;dialogHeight=220px");
		if (sRtn!="")
			elTarget.value = sRtn;
		} 
	else
		alert(<%=("\""+trd.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")+"\"")%>)
}
</script>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
<%	       String ponto = (String)session.getAttribute("barra");
               if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="IM"/></jsp:include> 
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
<%              String oi = "", oia = "";
		if(ponto.equals("..")){	  
				if (request.getParameter("op") == null)
				{
                  oi = "../menu/menu.jsp?op="+"I";
				}
				else
				{
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
				}
				if (request.getParameter("opt") == null)
				{
                  oia = "../menu/menu1.jsp?opt="+"T";
				} 
				else
				{  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}else{
		
		if (request.getParameter("op") == null)
						{
		                  oi = "/menu/menu.jsp?op="+"I";
						}
						else
						{
		                  oi = "/menu/menu.jsp?op="+request.getParameter("op");
						}
						if (request.getParameter("opt") == null)
						{
		                  oia = "/menu/menu1.jsp?opt="+"T";
						} 
						else
						{  
		                  oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
				}
		}%>
                <jsp:include page="<%=oi%>" flush="true"></jsp:include>
              </tr>
            </table>
          </td>
        </tr>
	<jsp:include page="<%=oia%>" flush="true"></jsp:include>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
                <td class="trontrk" align="center"><%=trd.Traduz("Treinamentos")%></td>
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
	  <form name = "frm">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
            <table width="80%" border="0" cellspacing="2" cellpadding="2">
              <tr> 
                <!--///////////////////////FILIAL///////////////////////////-->
                <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("FILIAL")%>:</td>
                <td width="33%"> 
		  <select name="sel_filial">
		    <option value="" selected><%=trd.Traduz("Todos")%></option>						
<%  		    if(usu_tipo.equals("F"))
                      query = cmb.montaCombo("Filial", "null", "null", aplicacao);	
		    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                      query = cmb.montaCombo("Filial", filial, "null", aplicacao);	
		    if(usu_tipo.equals("S"))
                      query = cmb.montaCombo("Filial", filial, codigo, aplicacao);
		    rs = conexao.executaConsulta(query,session.getId()+"RS0");
		    if(rs.next())	{
		      do {
                        if (pag_filial.equals(rs.getString(1))) {%>
                          <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
		    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS0");
                    }%>
		  </select>
                </td>
                <!--///////////////////////DEPARTAMENTO///////////////////////////-->
                <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("DEPARTAMENTO")%>:</td>
                <td width="36%">
		  <select name="sel_depto">
		    <option value="" selected><%=trd.Traduz("Todos")%></option>
<%                  if(usu_tipo.equals("F"))
                      query = cmb.montaCombo("Departamento", "null", "null", aplicacao);	
                    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
		      query = cmb.montaCombo("Departamento", filial, "null", aplicacao);	
                    if(usu_tipo.equals("S"))
		      query = cmb.montaCombo("Departamento", filial, codigo, aplicacao);	
		    rs = conexao.executaConsulta(query,session.getId()+"RS1");
                    if(rs.next()) {
		      do {
                        if (pag_depto.equals(rs.getString(1))) {%>
                          <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
			  <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%		        }
                      } while(rs.next());
		    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS1");
                    }%>
		  </select>						
                </td>
              </tr>
              <tr>
                <!--////////////////////////TABELA2//////////////////////////////-->
<%              if(prm.buscaparam("USE_TB2").equals("S")) {%>
                <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA2")%>:</td>
                <td width="33%">
		<select name="sel_tabela2">
		  <option value="" selected><%=trd.Traduz("Todos")%></option>
<%		  if(usu_tipo.equals("F"))
		    query = cmb.montaCombo("Tabela2", "null", "null", aplicacao);	
                  if(usu_tipo.equals("P") || usu_tipo.equals("G"))
		    query = cmb.montaCombo("Tabela2", filial, "null", aplicacao);	
	          if(usu_tipo.equals("S"))
		    query = cmb.montaCombo("Tabela2", filial, codigo, aplicacao);	
                  rs = conexao.executaConsulta(query,session.getId()+"RS2");
                  if(rs.next()) {
		    do {
                      if (pag_tab2.equals(rs.getString(1))) {%>
                        <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                    } else {%>
                        <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                    }
                    } while(rs.next());
		  }
                  if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS2");
                  }%>
		</select>
<%              } else {%>
                   <td>&nbsp;</td>
<%              }%>
                </td>
                <!--/////////////////////TABELA3/////////////////////////-->
<%              if(prm.buscaparam("USE_TB3").equals("S")) {%>
  		<td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA3")%>:</td>
                <td width="36%">
		  <select name="sel_tabela3">
		    <option value=""><%=trd.Traduz("Todos")%></option>
<%                  if(usu_tipo.equals("F"))
                      query = cmb.montaCombo("Tabela3", "null", "null", aplicacao);	
                    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                      query = cmb.montaCombo("Tabela3", filial, "null", aplicacao);	
                    if(usu_tipo.equals("S"))
                      query = cmb.montaCombo("Tabela3", filial, codigo, aplicacao);	
                    rs = conexao.executaConsulta(query,session.getId()+"RS3");
                    if(rs.next()) {
                      do {
                        if (pag_tab3.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
                    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS3");
                    }%>
		  </select>						
<%              } else {%>
                   <td>&nbsp;</td>
<%              }%>
                </td>
              </tr>
              <tr> 
                <!--////////////////////////CARGO//////////////////////////////-->
		<td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("CARGO")%>:</td>
                <td width="33%"> 
		  <select name="sel_cargo">
                    <option value=""><%=trd.Traduz("Todos")%></option>						
<%                  if(usu_tipo.equals("F"))
                      query = cmb.montaCombo("Cargo", "null", "null", aplicacao);	
                    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                      query = cmb.montaCombo("Cargo", filial, "null", aplicacao);	
                    if(usu_tipo.equals("S"))
                      query = cmb.montaCombo("Cargo", filial, codigo, aplicacao);	
                    rs = conexao.executaConsulta(query,session.getId()+"RS4");
                    if(rs.next()) {
                      do {
                        if (pag_cargo.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
                    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS4");
                    }%>
		  </select>												
                </td>
                <!--////////////////////////TABELA1//////////////////////////////-->
<%              if(prm.buscaparam("USE_TB1").equals("S")) {%>
                <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA1")%>:</td>
                <td width="33%"> 
		  <select name="sel_tabela1">
   		    <option value=""><%=trd.Traduz("Todos")%></option>
<%                  if(usu_tipo.equals("F"))
                      query = cmb.montaCombo("Tabela1", "null", "null", aplicacao);	
                    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                      query = cmb.montaCombo("Tabela1", filial, "null", aplicacao);	
                    if(usu_tipo.equals("S"))
                      query = cmb.montaCombo("Tabela1", filial, codigo, aplicacao);	
                    rs = conexao.executaConsulta(query,session.getId()+"RS5");
                    if(rs.next()) {
                      do {
                        if (pag_tab1.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%		        } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
                    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS5");
                    }%>
		  </select>						
                </td>
<%              } else {%>
                  <td width="13%" class="ftverdanacinza" align="right">&nbsp;</td>
                  <td width="36%">&nbsp;</td>
<%              }%>
              </tr>
              <tr> 
                <!--////////////////////////ENTIDADE//////////////////////////////-->
                <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("ENTIDADE")%>:</td>
                <td width="36%"> 
		  <select name="sel_empresa">
                    <option value=""><%=trd.Traduz("Todos")%></option>
<%                  query = "SELECT EMP_CODIGO, EMP_NOME "+
                            "FROM EMPRESA "+
                            "ORDER BY EMP_NOME";
                    rs = conexao.executaConsulta(query,session.getId()+"RS6");
                    if(rs.next()) {
                      do {
                        if (pag_empresa.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
                    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS6");
                    }%>
		  </select>						
                </td>
                <!--////////////////////////CURSO//////////////////////////////-->
                <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("CURSO")%>:</td>
                <td width="33%"> 
		  <select name="sel_curso">
	  	    <option value=""><%=trd.Traduz("Todos")%></option>
<%		    query = "SELECT CUR_CODIGO, CUR_NOME "+
                            "FROM CURSO WHERE CUR_SIMPLES = 'N' "+
                            "ORDER BY CUR_NOME";
                    rs = conexao.executaConsulta(query,session.getId()+"RS7");
                    if(rs.next()) {
                      do {
                        if (pag_curso.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
		    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS7");
                    }%>
		  </select>						
                </td>
              </tr>
              <tr>
                <!--////////////////////////TITULO//////////////////////////////-->
                <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("TITULO")%>:</td>
                <td width="36%"> 
		  <select name="sel_titulo">
                    <option value=""><%=trd.Traduz("Todos")%></option>
<%                  query = "SELECT TIT_CODIGO, TIT_NOME "+
                            "FROM TITULO "+
                            "ORDER BY TIT_NOME";
                    rs = conexao.executaConsulta(query,session.getId()+"RS8");
                    if(rs.next()) {
                      do {
                        if (pag_titulo.equals(rs.getString(1))) {%>
                          <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
		    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS8");
                    }%>
                  </select>						
                </td>
                <!--////////////////////////TABELA4//////////////////////////////-->
<%              if(prm.buscaparam("USE_TB4").equals("S")) {%>
                <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("TABELA4")%>:</td>
                <td width="36%">					
                  <select name="sel_tabela4">
                    <option value="0"><%=trd.Traduz("Todos")%></option>
<%                  if(usu_tipo.equals("F"))
                      query = cmb.montaCombo("Tabela4", "null", "null", aplicacao);	
                    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                      query = cmb.montaCombo("Tabela4", filial, "null", aplicacao);	
                    if(usu_tipo.equals("S"))
                      query = cmb.montaCombo("Tabela4", filial, codigo, aplicacao);	
                    rs = conexao.executaConsulta(query,session.getId()+"RS9");
                    if(rs.next()) {
                      do {
                        if (pag_tab4.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
		    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS9");
                    }%>
		  </select>						
                </td>
<%              } else {%>
                  <td width="13%" class="ftverdanacinza" align="right">&nbsp;</td>
                  <td width="36%">&nbsp;</td>
<%              }%>
              </tr>
              <tr>                       
                <!--/////////////////////////FUNCIONARIO/////////////////////////-->
                <td width="18%" class="ftverdanacinza" align="right"><%=trd.Traduz("FUNCIONARIO")%>:</td>
                <td width="33%"> 
        	  <select name="sel_funcionario">
                    <option value=""><%=trd.Traduz("Todos")%></option>
<%                  if(usu_tipo.equals("F"))
		      query = cmb.montaCombo("Funcionario", "null", "null", aplicacao);	
                    if(usu_tipo.equals("P") || usu_tipo.equals("G"))
                      query = cmb.montaCombo("Funcionario", filial, "null", aplicacao);	
                    if(usu_tipo.equals("S"))
                      query = cmb.montaCombo("Funcionario", filial, codigo, aplicacao);	
                    rs = conexao.executaConsulta(query,session.getId()+"RS10");
                    if(rs.next()) {
                      do {
                        if (pag_func.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
                    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS10");
                    }%>
                  </select>						
                </td>
                <!--/////////////////////////SOLICITANTE/////////////////////////-->
<%		if(usu_tipo.equals("S")) {%>
                <td width="13%" class="ftverdanacinza" align="right">&nbsp;</td>
                <td width="36%">&nbsp;</td>
<%		} else {%>
                <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("SOLICITANTE")%>:</td>
		<td width="36%"> 
                  <select name="sel_solic">
		    <option value="" selected><%=trd.Traduz("Todos")%></option>
<%		      if(usu_tipo.equals("F"))
			query = cmb.montaCombo("Solicitante", "null", "null", aplicacao);
                      if(usu_tipo.equals("P") || usu_tipo.equals("G"))
			query = cmb.montaCombo("Solicitante", filial, "null", aplicacao);
                      if(usu_tipo.equals("S"))
			query = cmb.montaCombo("Solicitante", filial, codigo, aplicacao);
                      rs = conexao.executaConsulta(query,session.getId()+"RS11");
                      if(rs.next()) {
                        do {
                          if (pag_func.equals(rs.getString(1))) {%>
			    <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                        } else {%>
                            <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                        }
                        } while(rs.next());
                      }
                      if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS11");
                      }%>			
                  </select>
                </td>
<%              }%>
              </tr>
              <tr>
                <!--//////////////////////// DATA INICIAL //////////////////////////////-->
		<td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("DATA INICIAL")%>:</td>
                <td width="33%">							
		  <input type="text" name="text_datainicio" value="<%=pag_dt_inicio%>" size="10" maxlength="10" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')"> 
		  &nbsp;
		  <img onclick="DoCal(text_datainicio)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
                </td>                 

                <!--//////////////////////// DATA FINAL //////////////////////////////-->
                <td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("DATA FINAL")%>:</td>
                <td width="33%"> 				
		  <input type="text" name="text_datafinal" value="<%=pag_dt_fim%>" size="10" maxlength="10" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
		  &nbsp;
		   <img onclick="DoCal(text_datafinal)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
		</td>
              </tr>
<%            if(pag_rdo_relat.equals("F")){%>
              <tr>
                <!--//////////////////////// Nº HORAS //////////////////////////////-->
		<td width="13%" class="ftverdanacinza" align="right"><%=trd.Traduz("HORAS/DIA")%>:</td>
                <td width="33%">
<%                if (pag_horas.equals("")) {%>
		    <input type="text" name="horas" size="3" value="8" maxlength="3"> 
<%                } else {%>
                    <input type="text" name="horas" size="3" value="<%=pag_horas%>" maxlength="3"> 
<%                }%>
                </td>
              </tr>
<%            }%>
	    </table> 
	    <br>
            <table width="80%" border="0" cellspacing="2" cellpadding="2">
              <tr>
                <td align="center">
<%                String ativo = (request.getParameter("check_a")==null)?"":request.getParameter("check_a");
                  if (ativo.equals("") || ativo.equals("A")){%>
                    <input checked type="checkbox" name="check_a" value="A">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR ATIVO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                } else {%>
                    <input type="checkbox" name="check_a" value="A">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR ATIVO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                }
		  if (request.getParameter("check_t") != null) {%>
                    <input type="checkbox" name="check_t" checked> 
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR TERCEIRO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                } else {%>
                    <input type="checkbox" name="check_t"> 
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR TERCEIRO")%> &nbsp;&nbsp;&nbsp; </tt>
<%                }
                  if(request.getParameter("check_d") == null){%>
                    <input type="checkbox" name="check_d">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR DEMITIDO")%> </tt>
<%                } else {%>
                    <input checked type="checkbox" name="check_d">
                    <tt class="ftverdanacinza"> <%=trd.Traduz("VISUALIZAR DEMITIDO")%> </tt>
<%                }%>
                </td>
              </tr>
            </table>
            <br>
            <table width="100%" border="0" cellspacing="2" cellpadding="2">
              <tr>
<%              if(pag_rdo_relat.equals("E")){%>
                <td class="celtittab" width="25%"><%=trd.Traduz("TIPO DE REGISTRO")%></td>
<%              }%>
<%              if(pag_rdo_relat.equals("F")){%>
                <td class="celtittab" width="25%"><%=trd.Traduz("TIPO DE DADO")%></td>
<%              }%>
                <td class="celtittab" width="25%"><%=trd.Traduz("RELATORIO")%></td>
<%              if(pag_rdo_relat.equals("E")){%>
                <td class="celtittab" width="25%"><%=trd.Traduz("AGRUPAMENTO")%></td>
<%              }%>
<%              if(pag_rdo_relat.equals("N")){%>
                <td class="celtittab" width="25%"><%=trd.Traduz("ORDENACAO")%></td>
<%              }%>
              </tr>
              <tr> 
<%              if(pag_rdo_relat.equals("E")){%>
                <td class="ftverdanacinza"> 
<%                if (request.getParameter("cb_lista") == null) {%>
                    <input type="checkbox" name="cb_lista" value="P"><%=trd.Traduz("LISTA DE PRESENCA")%><br>
<%                } else {%>
                    <input type="checkbox" name="cb_lista" value="P" checked><%=trd.Traduz("LISTA DE PRESENCA")%><br>
<%                }
                  if (request.getParameter("cb_rapido") == null) {%>
                    <input type="checkbox" name="cb_rapido" value="R"><%=trd.Traduz("RAPIDO")%><br>
<%                } else {%>
                    <input type="checkbox" name="cb_rapido" value="R" checked><%=trd.Traduz("RAPIDO")%><br>
<%                }
                  if (request.getParameter("cb_duracao") == null) {%>
                    <input type="checkbox" name="cb_duracao" value="D"><%=trd.Traduz("LONGA DURACAO")%><br>
<%                } else {%>
                    <input type="checkbox" name="cb_duracao" value="D" checked><%=trd.Traduz("LONGA DURACAO")%><br>
<%                }
                  if (request.getParameter("cb_turma") == null) {%>
                    <input type="checkbox" name="cb_turma" value="T"><%=trd.Traduz("TURMA ANTECIPADA")%><br>
<%                } else {%>
                    <input type="checkbox" name="cb_turma" value="T" checked><%=trd.Traduz("TURMA ANTECIPADA")%><br>
<%                }
                  if (request.getParameter("cb_anteriores") == null) {%>
                    <input type="checkbox" name="cb_anteriores" value="A"><%=trd.Traduz("ANTERIORES")%>
<%                } else {%>
                    <input type="checkbox" name="cb_anteriores" value="A" checked><%=trd.Traduz("ANTERIORES")%>
<%                }%>
                </td>
<%              }%>
<%              if(pag_rdo_relat.equals("F")){%>
                <td class="ftverdanacinza">
<%                if(pag_rdo_dados.equals("D") || pag_rdo_dados.equals("")){%>
                    <input type="radio" name="rb_dados" value="D" checked><%=trd.Traduz("DETALHADO")%><br>
<%                } else {%>
                    <input type="radio" name="rb_dados" value="D"><%=trd.Traduz("DETALHADO")%><br>
<%                }
                  if(pag_rdo_dados.equals("R")){%>
                    <input type="radio" name="rb_dados" value="R" checked><%=trd.Traduz("RESUMIDO")%><br><br><br><br><br>
<%                } else {%>
                    <input type="radio" name="rb_dados" value="R"><%=trd.Traduz("RESUMIDO")%><br><br><br><br><br>
<%                }%>
                </td>
<%              }%>
                <td class="ftverdanacinza">
<%                if(pag_rdo_relat.equals("E") || pag_rdo_relat.equals("")){%>
                    <input type="radio" name="rb_relat" value="E" checked onclick="atualiza_func();"><%=trd.Traduz("T. EFETUADOS")%><br>
<%                } else {%>
                    <input type="radio" name="rb_relat" value="E" onclick="atualiza_func();"><%=trd.Traduz("T. EFETUADOS")%><br>
<%                }
                  if(pag_rdo_relat.equals("N")){%>
                    <input type="radio" name="rb_relat" value="N" checked onclick="atualiza_func();"><%=trd.Traduz("T. NAO EFETUADOS")%><br>
<%                } else {%>
                    <input type="radio" name="rb_relat" value="N" onclick="atualiza_func();"><%=trd.Traduz("T. NAO EFETUADOS")%><br>
<%                }
                  if(pag_rdo_relat.equals("F")){%>
                    <input type="radio" name="rb_relat" value="F" checked onclick="atualiza_func();"><%=trd.Traduz("T. POR FUNCIONARIO")%><br><br><br><br>
<%                } else {%>
                    <input type="radio" name="rb_relat" value="F" onclick="atualiza_func();"><%=trd.Traduz("T. POR FUNCIONARIO")%><br><br><br><br>
<%                }%>
                </td>
<%              if(pag_rdo_relat.equals("E")){%>
                <td class="ftverdanacinza"> 
<%                if(pag_rdo_ord.equals("C") || pag_rdo_ord.equals("")){%>
                    <input type="radio" name="rb_ord" value="C" checked><%=trd.Traduz("CURSO")%><br>
<%                } else {%>
                    <input type="radio" name="rb_ord" value="C"><%=trd.Traduz("CURSO")%><br>
<%                }
                  if(pag_rdo_ord.equals("D")){%>
                    <input type="radio" name="rb_ord" value="D" checked><%=trd.Traduz("DATA INICIAL")%><br>
<%                } else {%>
                    <input type="radio" name="rb_ord" value="D"><%=trd.Traduz("DATA INICIAL")%><br>
<%                }
                  if(pag_rdo_ord.equals("A")){%>
                    <input type="radio" name="rb_ord" value="A" checked><%=trd.Traduz("DATA FINAL")%><br>
<%                } else {%>
                    <input type="radio" name="rb_ord" value="A"><%=trd.Traduz("DATA FINAL")%><br>
<%                }
                  if(pag_rdo_ord.equals("T")){%>
                    <input type="radio" name="rb_ord" value="T" checked><%=trd.Traduz("TURMA")%><br>
<%                } else {%>
                    <input type="radio" name="rb_ord" value="T"><%=trd.Traduz("TURMA")%><br>
<%                }
                  if(pag_rdo_ord.equals("F")){%>
                    <input type="radio" name="rb_ord" value="F" checked><%=trd.Traduz("FUNCIONARIO")%><br>
<%                } else {%>
                    <input type="radio" name="rb_ord" value="F"><%=trd.Traduz("FUNCIONARIO")%><br>
<%                }%>
                </td>
<%              }%>
<%              if(pag_rdo_relat.equals("N")){%>
                <td class="ftverdanacinza"> 
                  <input type="radio" name="rb_ord" value="C" checked><%=trd.Traduz("CHAPA")%><br>
                  <input type="radio" name="rb_ord" value="FU"><%=trd.Traduz("FUNCIONARIO")%><br>
                  <input type="radio" name="rb_ord" value="FI"><%=trd.Traduz("FILIAL")%><br>
                  <input type="radio" name="rb_ord" value="D"><%=trd.Traduz("DEPARTAMENTO")%><br>
                  <input type="radio" name="rb_ord" value="T"><%=trd.Traduz("TIME")%><br>
                </td>
<%              }%>
              </tr>
              <tr><td colspan="100%">&nbsp;</td></tr>
            </table>
            <table width="100%" border="0" cellspacing="2" cellpadding="2">
              <tr> 
                <td class="ftverdanacinza" align="right" width="13%"><%=trd.Traduz("PLANO")%>:</td>
                <td width="34%"> 
		  <select name="sel_plano">
                    <option value=""><%=trd.Traduz("Todos")%></option>
<%                  query = "SELECT PLA_CODIGO, PLA_NOME "+
                            "FROM PLANO "+
                            "ORDER BY PLA_NOME";
                    rs = conexao.executaConsulta(query,session.getId()+"RS12");
                    if(rs.next()) {
                      do {
                        if (pag_plano.equals(rs.getString(1))) {%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
                    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS12");
                    }%>
		  </select>		
                </td>
                <td class="ftverdanacinza" align="right" width="18%"><%=trd.Traduz("TIPO DE CURSO")%>:</td>
                <td width="35%"> 
		  <select name="sel_tipo">
	  	    <option value=""><%=trd.Traduz("Todos")%></option>
<%                  query = "SELECT TCU_CODIGO, TCU_NOME "+
                            "FROM TIPOCURSO "+
                            "ORDER BY TCU_NOME";
                    rs = conexao.executaConsulta(query,session.getId()+"RS13");
                    if(rs.next()) {
                      do {
                        if (pag_tipo.equals(rs.getString(1))){%>
			  <option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
<%                      } else {%>
                          <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%                      }
                      } while(rs.next());
		    }
                    if(rs != null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS13");
                    }%>
		  </select>	
                </td>
              </tr>

              <tr> 
                <td colspan="4" align="center">&nbsp;<br>
		  <input type="button" onClick="return filtra();"  value=<%=("\""+trd.Traduz("GERAR RELATORIO")+"\"")%> class="botcin" name="button1">                      
                </td>
              </tr>

            </table><p>&nbsp;
            </center>
          </td>
	  </form>
          <td width="20" valign="top">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>
<%	  if(ponto.equals("..")){%>
	    <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
<%        } else {%>		  
            <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
<%        }%>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
<%
//} catch (Exception e) {
//  out.println(e);
//}
%>