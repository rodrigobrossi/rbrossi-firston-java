<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.util.*"%>


<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />

<%
request.getSession();
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

FODBConnectionBean conexao1 = new FODBConnectionBean();
FODBConnectionBean conexao2 = new FODBConnectionBean();

conexao1.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

conexao2.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");

ResultSet rs = null, rs1 = null, rs2 = null;

boolean existe=false,mostraCheck=false;

//try {
String filial = ""+usu_fil;
String codigo = ""+usu_cod;
String query="", query1="", query2="", tipoOperacao="";
Vector vetCargo = new Vector();
Vector vetTitulo = new Vector();
Vector queries = new Vector();
int cont=0, cont_tit=0, cont_car=0;

//limpa vetores
if (request.getParameter("apagavetor") == null) {
  session.setAttribute("vetor_cargo", vetCargo);
  session.setAttribute("vetor_titulo", vetTitulo);
} else {
  vetCargo = (Vector)session.getAttribute("vetor_cargo");
  vetTitulo = (Vector)session.getAttribute("vetor_titulo");
}

//Insere nos vetores
if (request.getParameter("tipo_op") != null) {
  tipoOperacao = request.getParameter("tipo_op");
  
  if (tipoOperacao.equals("IT")){//inclusao de titulo no vetor
    vetTitulo.add(request.getParameter("cbo_titulo"));
  }
  if (tipoOperacao.equals("ET")){//exclusao de titulo no vetor
    int qtde = Integer.parseInt(request.getParameter("c_tit"));
    for (int ii=0; ii<=qtde; ii++) {
      if (request.getParameter("chk_titulo"+ii) != null) {
        vetTitulo.removeElement((String)request.getParameter("chk_titulo"+ii));
        //out.println("apagou" + ii + "-" + qtde);
      }
    }
  }

  if (tipoOperacao.equals("IC")){//inclusao de cargo no vetor
    vetCargo.add(request.getParameter("cbo_cargo"));
  }
  if (tipoOperacao.equals("EC")){//exclusao de titulo no vetor
    int qtde = Integer.parseInt(request.getParameter("c_car"));
    for (int ii=0; ii<=qtde; ii++) {
      if (request.getParameter("chk_cargo"+ii) != null) {
        vetCargo.removeElement((String)request.getParameter("chk_cargo"+ii));
        //out.println("apagou" + ii + "-" + qtde);
      }
    }
  }
}
//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));  
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> -  <%=trd.Traduz("INCLUSAO DE PRE-REQUISITOS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language  ="JavaScript">
function incluir_tit() {
  if (frm_prereq.cbo_titulo.value == "") {
    alert(<%=("\""+trd.Traduz("Favor selecionar um tItulo!")+"\"")%>);
    return false;
  }
  frm_prereq.tipo_op.value = "IT";
  frm_prereq.action = "inclusaodeprerequisito.jsp";
  frm_prereq.submit();
  return true;
}

function excluir_tit() {
  var teste = 0;
  //alert(""+frm_prereq.c_tit.value);
  for(i=1;i<=frm_prereq.c_tit.value;i++) {
    if(eval("frm_prereq.chk_titulo"+i+".checked")==true) {
      teste = teste+1;
    }
  }
  if(teste == 0) {
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else
  {
  frm_prereq.tipo_op.value = "ET";
  frm_prereq.action = "inclusaodeprerequisito.jsp";
  frm_prereq.submit();
  return true;
  }
}

function incluir_car() {
  if (frm_prereq.cbo_cargo.value == "") {
    alert(<%=("\""+trd.Traduz("Favor selecionar um cargo!")+"\"")%>);
    return false;
  }
  frm_prereq.tipo_op.value = "IC";
  frm_prereq.action = "inclusaodeprerequisito.jsp";
  frm_prereq.submit();
  return true;
}

function excluir_car() {
  var teste = 0;
  //alert(""+frm_prereq.c_car.value);
  for(i=1;i<=frm_prereq.c_car.value;i++) {
    if(eval("frm_prereq.chk_cargo"+i+".checked")==true) {
      teste = teste+1;
    }
  }
  if(teste == 0) {
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else
  {
    frm_prereq.tipo_op.value = "EC";
    frm_prereq.action = "inclusaodeprerequisito.jsp";
    frm_prereq.submit();
    return true;
  }
}

function cancela() {
  window.open("prerequisitos.jsp", "_parent");
  return true;
}

function grava() {
  frm_prereq.action = "valida_prerequisitos.jsp";
  frm_prereq.submit();
  return true;
}

function tabela5()
{
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&apagavetor=N","_parent");
  return true;
}    
function tabela6()
{
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&cbo_tabela6="+frm_prereq.cbo_tabela6.value+"&apagavetor=N","_parent");
  return true;
}    
function tabela7()
{
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&cbo_tabela6="+frm_prereq.cbo_tabela6.value+"&cbo_tabela7="+frm_prereq.cbo_tabela7.value+"&apagavetor=N","_parent");
  return true;
}    
function tabela8()
{
  window.open("inclusaodeprerequisito.jsp?cbo_tabela5="+frm_prereq.cbo_tabela5.value+"&cbo_tabela6="+frm_prereq.cbo_tabela6.value+"&cbo_tabela7="+frm_prereq.cbo_tabela7.value+"&cbo_tabela8="+frm_prereq.cbo_tabela8.value+"&apagavetor=N","_parent");
  return true;
}    
</script>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
  <form name="frm_prereq">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> <%
              String ponto=(String)session.getAttribute("barra");
              if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> 
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
    <%String oi = "", oia = "";
    if(ponto.equals("..")){
      if (request.getParameter("op") == null) {
                    oi = "../menu/menu.jsp?op="+"C";
      } else {
                    oi = "../menu/menu.jsp?op="+request.getParameter("op");
      }
      if (request.getParameter("opt") == null){
                    oia = "../menu/menu1.jsp?opt="+"PR";
      } else {  
                    oia = "../menu/menu1.jsp?opt="+request.getParameter("opt");
      }
      
      }else{
      if (request.getParameter("op") == null) {
                          oi = "/menu/menu.jsp?op="+"C";
            } else {
                          oi = "/menu/menu.jsp?op="+request.getParameter("op");
            }
            if (request.getParameter("opt") == null){
                          oia = "/menu/menu1.jsp?opt="+"PR";
            } else {  
                          oia = "/menu/menu1.jsp?opt="+request.getParameter("opt");
            }
      
      
      
      }
      %>
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
                <td class="trontrk"><%=trd.Traduz("INCLUSAO DE PRE-REQUISITOS")%></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
          <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
          <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
        </tr>
        </table>
        <center>          
    

<%      String tabela5="", tabela6="", tabela7="", tabela8="", opt_filtro="";
        opt_filtro = "Cargo";//essa tela nao tem esse filtro, por isso cargo sera fixo
        if (request.getParameter("cbo_tabela5") != null)
          tabela5 = request.getParameter("cbo_tabela5");
        else
          tabela5 = ""+usu_fil;
        if (request.getParameter("cbo_tabela6") != null)
          tabela6 = request.getParameter("cbo_tabela6");
        if (request.getParameter("cbo_tabela7") != null)
          tabela7 = request.getParameter("cbo_tabela7");
        if (request.getParameter("cbo_tabela8") != null)
          tabela8 = request.getParameter("cbo_tabela8");

    if(usu_tipo.equals("F"))
      queries = pos.montaCombo(opt_filtro, "null", "null", aplicacao, tabela5, tabela6, tabela7, tabela8);
  
    if(usu_tipo.equals("P"))
      queries = pos.montaCombo(opt_filtro, filial, "null", aplicacao, tabela5, tabela6, tabela7, tabela8);

    if(usu_tipo.equals("G"))
      queries = pos.montaCombo(opt_filtro, filial, "null", aplicacao, tabela5, tabela6, tabela7, tabela8);
  
    if(usu_tipo.equals("S"))
      queries = pos.montaCombo(opt_filtro, filial, codigo, aplicacao, tabela5, tabela6, tabela7, tabela8);

      //Combos auxiliares para LOTACAO
      if(prm.buscaparam("LOTACAO").equals("S")) {%>
        <table border="0" cellspacing="1" cellpadding="0" width="80%">
            <tr><td width="13"><img src="../art/bit.gif" width="13" height="15"></td></tr>
            <tr>
                <td class="ctfontc" align="left" width="50%">
                    <%=trd.Traduz("TABELA5")%>:&nbsp;<br>

                <select name="cbo_tabela5" onChange="return tabela5();">
          <%
              if(usu_tipo.equals("F")) {
              %>
                <option value="-1"><%=trd.Traduz("Todos")%></option> 
              <%
            }         

        rs = conexao.executaConsulta((String)queries.elementAt(1));

        if (rs.next())
        {
      do
      {
        if((rs.getInt(1)) == (usu_fil.intValue()) && (request.getParameter("cbo_tabela5") == null))
        {
          %>
          <option selected value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
          <%
        }
        else 
        {
                                if (request.getParameter("cbo_tabela5") != null && (rs.getString(1).equals(request.getParameter("cbo_tabela5"))))
                                {
                                  %>
            <option value = "<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
            <%
          }
          else
          {
            %>
                <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
            <%
          }
          }
      }while (rs.next());
      %> 
                        </select>
      <%
      rs = null;
        }
        %>
                </td>
                <td class="ctfontc" align="left" width="50%">
                    <%=trd.Traduz("TABELA6")%>:&nbsp;<br>
                    <select name="cbo_tabela6" onChange="return tabela6();"> <option value="-1" selected><%=trd.Traduz("Todos")%></option> 
                    
    <%    
        rs = conexao.executaConsulta((String)queries.elementAt(2));
    if (rs.next())
    {
      do
      {
        if(tabela6.equals(rs.getString(1)))
        {
            %>
            <option selected value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
          <%
        }
          else
          {
            %>
            <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
          <%
          }
      }while(rs.next());
      %> 
                        </select>
      <%
      rs = null;
    }
    %>
                </td>            
            </tr>
            <tr>
                <td class="ctfontc" align="left" width="50%">
                    <%=trd.Traduz("TABELA7")%>:&nbsp;<br>
                <select name="cbo_tabela7" onChange="return tabela7();"> <option value="-1" selected><%=trd.Traduz("Todos")%></option> 
<%        rs = conexao.executaConsulta((String)queries.elementAt(3));
        if (rs.next()) {
      do {
        if(tabela7.equals(rs.getString(1))) {%>
          <option selected value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%        } else {%>
          <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%        }
      } while (rs.next());%> 
                      </select>
<%                    rs = null;
        }%>
                </td>
                <td class="ctfontc" align="left" width="50%">
                    <%=trd.Traduz("TABELA8")%>:&nbsp;<br>
                <select name="cbo_tabela8" onChange="return tabela8();"> <option value="-1" selected><%=trd.Traduz("Todos")%></option> 
<%        rs = conexao.executaConsulta((String)queries.elementAt(4));
        if (rs.next()) {
      do {
        if(tabela8.equals(rs.getString(1))) {%>
          <option selected value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%        } else {%>
          <option value = "<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
<%        }
      } while (rs.next());%> 
                      </select>
<%                    rs = null;
        }%>
                </td>
            </tr>
        </table>
<%      }%>

        <table border="0" cellspacing="1" cellpadding="0" width="80%">
            <tr><td width="13"><img src="../art/bit.gif" width="13" height="15"></td></tr>
            <tr>  
                <td class="ctfontc" align="left"><%=trd.Traduz("CARGO")%>: 
                    <select name="cbo_cargo">
                        <option value=""><%=trd.Traduz("Selecione")%></option>
<%                      if(prm.buscaparam("LOTACAO").equals("S")) {
                          query1 = (String)queries.elementAt(0);
                        } else {
                          query1 = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);
                        }
                        rs1 = conexao1.executaConsulta(query1);
                        while (rs1.next()) {
                            //cont_car++;
                            if(vetCargo.contains(rs1.getString(1))) {%>
                                <!--nao insere no combo os intens que ja estao na grid-->
<%                          } else {%>
                                <option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
<%                          }
                        }%>
                    </select>
                    </td>
                    </tr>
                    <tr>
                    <td colspan="100%" align="center">
                    <input type="button" class="botcin" name="btn_inc" value=<%=("\""+trd.Traduz("incluir")+"\"")%> onclick="return incluir_car();"> &nbsp;
                    <input type="button" class="botcin" name="btn_del" value=<%=("\""+trd.Traduz("excluir")+"\"")%> onclick="return excluir_car();">
                </td>
            </tr>    
        </table>
        <table border="0" cellspacing="1" cellpadding="0" width="80%">
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
            <tr>

<%        query2 ="SELECT CAR_CODIGO, CAR_NOME FROM CARGO ";
          if (!vetCargo.isEmpty()) {
              query2 = query2 + "WHERE ";
              for (int i=0; i<vetCargo.size(); i++) {
                if (i!=0) 
                  query2 = query2 + " OR ";
                query2 = query2 + "CAR_CODIGO = " + vetCargo.elementAt(i) + " ";
              }
              query2 = query2 + " ORDER BY CAR_NOME";
              //out.println(query2);

            rs2 = conexao2.executaConsulta(query2);
            if(rs2.next()){
                %>
                <td width="70%" class="celtittab" colspan="2"><%=trd.Traduz("CARGOS")%></td>
              </tr>
              <%
                cont_car=0;
                //try{
                    do {
                        cont_car++;%>
                        <tr class="celnortab"> 
                            <td width="3%" align="center"> 
                                <input type="checkbox" name="chk_cargo<%=cont_car%>" value="<%=rs2.getInt(1)%>" >
                            </td>
                            <td width="66%"><%=rs2.getString(2)%></td>
                        <tr>
<%                  } while(rs2.next());
                //}catch(Exception e){//out.println(""+e);}
            }
         }
         else {
            %>
                <td colspan="100%" align="center" class="celtittab"><%=trd.Traduz("NENHUM ITEM ADICIONADO")%>...</td>
                </tr>
<%       }%>
                    
        </table>

        <table border="0" cellspacing="1" cellpadding="0" width="100%">
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
            <tr> 
                <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
                <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
            </tr>
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
        </table>

        <table border="0" cellspacing="1" cellpadding="0" width="80%">
            <tr> 
                <td class="ctfontc" align="left"><%=trd.Traduz("TITULO")%>:
                    <select name="cbo_titulo">
                        <option value=""><%=trd.Traduz("Selecione")%></option>
<%                      query1 = "SELECT tit_codigo, tit_nome FROM titulo ORDER BY TIT_NOME ";
                        rs1 = conexao1.executaConsulta(query1);
                        while (rs1.next()) {
                            //cont_tit++;
                            if(vetTitulo.contains(rs1.getString(1))) {%>
                                <!--nao insere no combo os intens que ja estao na grid-->
<%                          } else {%>
                                <option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
<%                          }
                        }%>
                    </select>
                    </td>
                    </tr>
                    <tr>
                   <td colspan="100%" align="center">
                    <input type="button" class="botcin" name="btn_inc" value=<%=("\""+trd.Traduz("incluir")+"\"")%> onclick="return incluir_tit();"> &nbsp;
                    <input type="button" class="botcin" name="btn_del" value=<%=("\""+trd.Traduz("excluir")+"\"")%> onclick="return excluir_tit();">
                </td>
            </tr>    
        </table>

        <table border="0" cellspacing="1" cellpadding="0" width="80%">
            <tr>
                <td class="ctfontc" align="left" colspan="100%">
                    <input type="radio" name="rdo_req_des" value="S" checked><%=trd.Traduz("Requerido")%> &nbsp;
                    <input type="radio" name="rdo_req_des" value="N"><%=trd.Traduz("Desejado")%>
                </td>
            </tr>
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
            <tr> 
            
<%        query2 ="SELECT TIT_CODIGO, TIT_NOME FROM TITULO ";
          if (!vetTitulo.isEmpty()) {
              query2 = query2 + "WHERE ";
              for (int i=0; i<vetTitulo.size(); i++) {
                if (i!=0) 
                  query2 = query2 + " OR ";
                query2 = query2 + "TIT_CODIGO = " + vetTitulo.elementAt(i);
              }
              query2 = query2 + " ORDER BY TIT_NOME";
              //out.println(query2);

            rs2 = conexao2.executaConsulta(query2);
            if(rs2.next()){
                %>
                <td width="70%" class="celtittab" colspan="2"><%=trd.Traduz("TITULOS")%></td>
              </tr>
              <%
                cont_tit = 0;
                //try{
                    do {
                        cont_tit++;%>
                        <tr class="celnortab"> 
                            <td width="3%" align="center"> 
                                <input type="checkbox" name="chk_titulo<%=cont_tit%>" value="<%=rs2.getString(1)%>" >
                            </td>
                        <td width="66%"><%=rs2.getString(2)%></td>
<%                  } while(rs2.next());
                //}catch(Exception e){//out.println(""+e);}
            }
        }
        else{
          %>
            <td class="celtittab" align="center" colspan="100%"><%=trd.Traduz("NENHUM ITEM ADICIONADO")%>...</td>
            </tr>
      <%
    }%>
        </table>

        <table border="0" cellspacing="1" cellpadding="0" width="100%">
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
            <tr> 
                <td width="20" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
                <td valign="top" class="ctvdiv"><img src="../art/bit.gif" width="1" height="1"></td>
                <td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
            </tr>
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
        </table>

        <table border="0" cellspacing="1" cellpadding="0" width="100%">
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
            <tr> 
                <td align="center" colspan="100%">
                    <input type="button" class="botcin" name="btn_inc" value="        <%=trd.Traduz("OK")%>        " onclick="return grava();"> &nbsp;
                    <input type="button" class="botcin" name="btn_del" value=<%=("\""+trd.Traduz("cancelar")+"\"")%> onclick="return cancela();">
                </td>
            </tr>
            <tr><td height="12"><img src="../art/bit.gif" width="1" height="1"></td></tr>
        </table>
        </center>
        <input type="hidden" name="apagavetor" value="N"> <!--verifica se apaga o vetor da secao-->
        <input type="hidden" name="tipo_op"> <!--tipo da operacao (includao de titulo ou curso-->
        <input type="hidden" name="c_tit" value="<%=cont_tit%>"> <!--contador titulo-->
        <input type="hidden" name="c_car" value="<%=cont_car%>"> <!--contador cargo-->
      
    </td>
  </tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> <%if(ponto.equals("..")){%>
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

</form>
</body>
</html>
<%
if(rs != null)
  rs.close();
conexao.finalizaConexao();

conexao1.finalizaConexao();
conexao1.finalizaConexao();

conexao2.finalizaConexao();
conexao2.finalizaConexao();
//}catch(Exception e){out.println(e);}
%>