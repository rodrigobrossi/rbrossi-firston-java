<%
  response.setHeader("Pragma", "no-cache");
  if (request.getProtocol().equals("HTTP/1.1"))
  {
    response.setHeader("Cache-Control", "no-cache");
  }
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*"%>

<%
  //recupera da sessAo//
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

//try{

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

ResultSet rst_logados = null, rs_acc = null;/*Para usuArios logados*/

String str_filtro ="";/*Filtro da pAgina*/
String str_queryLogados ="";/*Query que identifica os usuArios logados no sistema*/
String str_pesquisa="";/*Verifica as pesquisas dos dados de log*/
java.text.SimpleDateFormat sdf_data = new java.text.SimpleDateFormat("dd/MM/yyyy");
java.text.SimpleDateFormat sdf_hora = new java.text.SimpleDateFormat("hh:mm:ss");
                  
java.util.Date dte_hoje = new java.util.Date();
java.text.SimpleDateFormat sdf_hoje= new java.text.SimpleDateFormat("dd/MM/yyyy");

String str_hoje = sdf_hoje.format(dte_hoje);


  //Declaracao de variaveis
  String query="", fun_nomedb="", fil_nomedb="", fun_logindb="", fun_senhadb="", fun_cod="";
  int i = 0;

/* *****************************************
INICIO ACC - AREA CONTRA O CLIENTE - VERIFICAR E RETIRAR DO CODIGO QDO NECESSARIO
* *****************************************/


/* ****************************************
FIM ACC
* *****************************************/

%>
<script language="JavaScript">
function mata(){

if(frm.sel_users.value=="todos"){
  alert(<%=("\""+trd.Traduz("SELECIONE UM USUARIO")+"\"")%>);
  frm.sel_users.focus();
  return false;
  }
else{
  window.open("fer_mataUsuario.jsp?cod="+frm.sel_users.value,"_parent");
  return false;
} 


}


function filtra() {
  var data1 = document.frm.datai.value; //data inicial da tela
  var data2 = document.frm.dataf.value; //data final da tela
     
  i1=0; i2=0; 
  while(i1<data1.length){
      i1++;
  }
  while(i2<data2.length){
    i2++;
  }
  if(data1.length==9)
    data1 ="0"+data1;
  if(data2.length==9)
    data2 ="0"+data2;
  
  var dia1 = data1.substring(0,2);
  var dia2 = data2.substring(0,2);
  var mes1 = data1.substring(3,5);
  var mes2 = data2.substring(3,5);
  var ano1 = data1.substring(6,10);
  var ano2 = data2.substring(6,10);

soma=eval(dia1+"+10");

if(ano1>ano2){
  alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
  document.frm.dataf.value="";
  document.frm.dataf.focus();
  return false; 
}
else if(ano1==ano2){
  if (mes1>mes2){
  alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
  document.frm.dataf.value="";
  document.frm.dataf.focus();
  return false; 
  }
  else if(mes1==mes2){
    if(dia1>dia2){  
    alert(<%=("\""+trd.Traduz("A data final nAo pode ser menor que a data de inicial")+"\"")%>);
    document.frm.dataf.value="";
    document.frm.dataf.focus();
    return false; 
    }
    else if(dia2>soma){
    alert(<%=("\""+trd.Traduz("A data final pode avanCar apenas 10 dias da data inicial")+"\"")%>);
    document.frm.dataf.value="";
    document.frm.dataf.focus();
    return false; 
    }
  } 
}


return true; 

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


<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn EM</title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">

</head>
<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
 <form name = "frm" method="POST" action="fer_administrar_log.jsp">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="59" class="hcfundo">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
               <%
            String ponto=(String)session.getAttribute("barra");
              if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include> 
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include> 
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
              <%if(ponto.equals("..")){%>
                <jsp:include page="../menu/menu.jsp" flush="true"><jsp:param value="op" name="F"/></jsp:include> 
                <%}else{%>
                <jsp:include page="/menu/menu.jsp" flush="true"><jsp:param value="op" name="F"/></jsp:include> 
                <%}%>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0" height="8">
        <tr>
        <%if(ponto.equals("..")){%>
          <jsp:include page="../menu/menu_ferramentas.jsp" flush="true"><jsp:param value="op" name="A"/></jsp:include> 
          <%}else{%>
          <jsp:include page="/menu/menu_ferramentas.jsp" flush="true"><jsp:param value="op" name="A"/></jsp:include> 
          <%}%>
        </tr>
      </table>
      <center>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr> 
          <td width="20">&nbsp;</td>
          <td width="100%" align="center"> 
            <table border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
        <td class="trontrk" align="center"><%=trd.Traduz("Administrador de LOG")%></td>
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
          <td width="20" valign="top">&nbsp;</td>
    <td valign="top"> <br>
   
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
      <td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("USUARIOS ATIVOS")%>: 
                      <%
                      str_filtro = (((String)request.getParameter("filtro")==null)?"":(String)request.getParameter("filtro"));
                      str_queryLogados="SELECT F.fun_codigo, F.fun_nome FROM funcionario F,userlogin U WHERE F.fun_codigo in (SELECT fun_codigo from " +
                      " userlogin ) AND F.fun_codigo=U.fun_codigo order by F.fun_nome";
                      
                      rst_logados = conexao.executaConsulta(str_queryLogados,session.getId() + "RS1");
                      
                      String str_opUsers = (((String)request.getParameter("sel_users")==null)?"todos":(String)request.getParameter("sel_users"));
                      
                      %>
                      <select name="sel_users">
                        <%if (str_opUsers.equals("todos")){%>
                        <option value="todos" selected><%=trd.Traduz("TODOS")%></option>
                        <%}else{%>
                        <option value="todos" ><%=trd.Traduz("TODOS")%></option>
                        <%}%>
                      <%
                      if(rst_logados.next()){
                        do{
                        
                        if (str_opUsers.equals(""+rst_logados.getInt(1))){
                          %>
                          <option value="<%=rst_logados.getInt(1)%>"selected><%=rst_logados.getString(2)%></option>
                          <%
                          }
                        else{
                          %>
            <option value="<%=rst_logados.getInt(1)%>"><%=rst_logados.getString(2)%></option>
                          <%
                          } 
                        
                        }while(rst_logados.next());
                      
                        }
                        if(rst_logados != null){
                            rst_logados.close();
                            conexao.finalizaConexao(session.getId() + "RS1");
                        }
                      
                      %>
                      </select><br><br>
                      &nbsp; <%=trd.Traduz("OPERACOES")%>: 
        <select name="sel_operacao">
          <%String str_opOperacoes = (((String)request.getParameter("sel_operacao")==null)?"":(String)request.getParameter("sel_operacao"));%>      
          <%if (str_opOperacoes.equals("todos")){%>
          <option value="todos" selected><%=trd.Traduz("SELECIONE UMA OPCAO")%></option>
          <%}else {%>
          <option value="todos"><%=trd.Traduz("SELECIONE UMA OPCAO")%></option>
          <%}%>
          <%if (str_opOperacoes.equals("0")){%>
          <option value="0" selected><%=trd.Traduz("ENTRADA")%></option>
          <%}else {%>
          <option value="0"><%=trd.Traduz("ENTRADA")%></option>
          <%}%>
          <%if (str_opOperacoes.equals("1")){%>
          <option value="1" selected><%=trd.Traduz("SAIDA")%></option>
          <%}else {%>
          <option value="1"><%=trd.Traduz("SAIDA")%></option>
          <%}%>
          <%if (str_opOperacoes.equals("3")){%>
          <option value="3" selected><%=trd.Traduz("DESCONECTADO")%></option>
          <%}else {%>
          <option value="3"><%=trd.Traduz("DESCONECTADO")%></option>
          <%}%>
          
          <!--<option value="4"><%=trd.Traduz("DESC. ADM")%></option>-->
            </select>
             &nbsp; <%=trd.Traduz("ORDENACAO")%>: 
        <select name="sel_ordenacao">
          <%String str_opOrdenacao = (((String)request.getParameter("sel_ordenacao")==null)?"":(String)request.getParameter("sel_ordenacao"));%>
          <%if (str_opOrdenacao.equals("todos")){%>
          <option value="todos" selected><%=trd.Traduz("SELECIONE UMA OPCAO")%></option>
          <%}else {%>
          <option value="todos"><%=trd.Traduz("SELECIONE UMA OPCAO")%></option>
          <%}%>
          <!--Comnetado pela falta de necessisade de usu-->
          <!--<option value="0"><%=trd.Traduz("DATA")%></option>-->
          <%if (str_opOrdenacao.equals("1")){%>
          <option value="1" selected><%=trd.Traduz("USUARIO")%></option>
          <%}else {%>
          <option value="1"><%=trd.Traduz("USUARIO")%></option>
          <%}%>
          <%if (str_opOrdenacao.equals("2")){%>
          <option value="2"selected><%=trd.Traduz("LOGIN")%></option>
          <%}else {%>
          <option value="2"><%=trd.Traduz("LOGIN")%></option>
          <%}%>
          <!--<option value="4"><%=trd.Traduz("DESC. ADM")%></option>-->
            </select>
            
                </td>
            </tr> 
            <tr>
          <td class="ctfontc" align="center">
            &nbsp;  
          </td>
            </tr>
            <tr>
               <td height="20" class="ctfontc" align="center"><%=trd.Traduz("Data Inicial")%>:&nbsp;      
        <% 
        String str_visualiza = (((String)request.getParameter("datai")==null)? str_hoje : (String)request.getParameter("datai"));
        
        %>
        <input type="text" name="datai" value="<%=str_visualiza%>" size="9" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
              &nbsp;<img onclick="DoCal(datai)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16"> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
        <%=trd.Traduz("Data Final")%>:&nbsp;
              <input type="text" name="dataf" value="<%=str_hoje%>" size="9" onChange="ChecaData(this)" onKeyDown="FormataData(this, window.event.keyCode,'down')" onKeyUp="FormataData(this, window.event.keyCode,'up')">
              &nbsp;<img onclick="DoCal(dataf)" style="cursor:hand" src="../art/icon_cal.gif" title="CalendArio" WIDTH="17" HEIGHT="16">
                </td> 
           </tr>
           
           <tr>
                <td align="center">
                       <br>&nbsp; &nbsp; &nbsp; 
                  <input type="submit"  value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button1">&nbsp;&nbsp;    
                  <!--<input type="button" onClick="return mata();"  value=<%=("\""+trd.Traduz("DESCONECTAR USUARIO")+"\"")%> class="botcin" name="button2">-->
               </td>
                           
          </tr>
          <tr> 
            <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
          </tr>
            <tr> 
            <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
      </tr>
                  </table> 
    </td>
   
      
        </tr>
          <td  class="ctfontc" align="center" colspan="100%">
          <br>
          <br>
           <table border="0" cellspacing="1" cellpadding="1" width="80%">
      <tr> 
                    <td width="4%">&nbsp;</td>
        <td  class="celtittab">
        <%=trd.Traduz("NOME DO USUARIO")%>
        </td>
        <td  class="celtittab">
        <%=trd.Traduz("LOGIN")%>
        </td>
        <td  class="celtittab" align="center">
        <%=trd.Traduz("DATA")%>
        </td>
        <td  class="celtittab" align="center">
        <%=trd.Traduz("HORA")%>
        </td>
        <td  class="celtittab" align="center">
        <%=trd.Traduz("IP")%>
        </td>
        <td  class="celtittab" align="center">
        <%=trd.Traduz("OPERACAO")%>
        </td>
        <td  class="celtittab" align="center">
        <%=trd.Traduz("SESSAO")%>
        </td>
                  </tr>
                  <%
                  String str_filtrosDeUsuarios="";
                  String str_filtrosDeDatai=" AND a.ace_data >= DATEFMT("+str_hoje+") "; 
                  String str_filtrosDeDataf=" AND a.ace_data <= DATEFMT("+str_hoje+") ";
                  String str_filtrosDeOperacao="";
                  String str_filtrosDeOrdenacao="";
                  str_pesquisa="select  f.fun_nome , "+
                      " a.ace_data, "+
                      " a.ace_hora,"+
                      " a.ace_ip,"+
                      " a.ace_operacao,"+
                      " a.ace_session, "+
                      " f.fun_login "+
                      " from  funcionario f,"+
                      " acesso a "+
                      " where a.fun_codigo=f.fun_codigo ";
                      //USUARIOS
                      if(((String)request.getParameter("sel_users")==null)){
                      str_filtrosDeUsuarios="";
                      }
                      else {
                      String str_teste =(String)request.getParameter("sel_users");
                      if(!str_teste.equals("todos")){
                        str_filtrosDeUsuarios=" AND f.fun_codigo="+(String)request.getParameter("sel_users")+" ";
                        }
                      else{
                      str_filtrosDeUsuarios="";
                      } 
                      }
                      //OPERACOES
                      if(((String)request.getParameter("sel_operacao")==null)){
            str_filtrosDeOperacao="";
          }
          else {
          String str_teste =(String)request.getParameter("sel_operacao");
            if(!str_teste.equals("todos")){
            str_filtrosDeOperacao =" AND a.ace_operacao = "+str_teste+" ";
            }
          }
          //ORDENACAO
          if(((String)request.getParameter("sel_operacao")==null)){
            str_filtrosDeOrdenacao="order by  a.ace_hora desc,f.fun_nome";
          }
          else {
            String str_teste =(String)request.getParameter("sel_ordenacao");
            if(str_teste.equals("todos")){
              str_filtrosDeOrdenacao ="order by a.ace_hora desc,f.fun_nome ";
            }
            //nAo E necessArio a utilizaCAo
            //else if(str_teste.equals("0")){str_filtrosDeOrdenacao =" order by a.ace_data desc,a.ace_hora,f.fun_nome ";}
            else if(str_teste.equals("1")){str_filtrosDeOrdenacao =" order by f.fun_nome,a.ace_hora desc";}
            else if(str_teste.equals("2")){str_filtrosDeOrdenacao =" order by f.fun_login,a.ace_hora desc,f.fun_nome";}
          }
          
          //DATA INICIAL
          if((String)request.getParameter("datai")==null){
          str_filtrosDeDatai=" AND a.ace_data >= DATEFMT("+str_hoje+") "; 
                      }else{
                      String str_teste =(String)request.getParameter("datai");
                      str_teste.trim();
                      
                        if((str_teste.equals(""))|| (str_teste==null)){
                        str_filtrosDeDatai=" AND a.ace_data >= DATEFMT("+str_hoje+") "; 
                        }
                      else{
                        str_filtrosDeDatai=" AND a.ace_data >= DATEFMT("+(String)request.getParameter("datai")+") ";
                        }
                      }
                      
          //DATA FINAL
          if((String)request.getParameter("dataf")==null){
          str_filtrosDeDataf=" AND a.ace_data <= DATEFMT("+str_hoje+") ";
          }else{
          String str_teste =(String)request.getParameter("dataf");
          str_teste.trim();
          if((str_teste.equals(""))|| (str_teste==null)){
            str_filtrosDeDataf=" AND a.ace_data <= DATEFMT("+str_hoje+") ";
          }
          else{
            str_filtrosDeDataf=" AND a.ace_data <= DATEFMT("+(String)request.getParameter("dataf")+") ";
            }
          }
                      
                      //ORDER BY DATA DEFAULT
                      
                      
                      
                      
                  str_pesquisa = str_pesquisa +str_filtrosDeUsuarios+str_filtrosDeOperacao+str_filtrosDeDatai+ str_filtrosDeDataf + str_filtrosDeOrdenacao;
                  //try{
                    rst_logados =conexao.executaConsulta(str_pesquisa,session.getId() + "RS2");   
                  //}catch(Exception ex){out.println("FirstOn EM :"+ex);}
                  if(rst_logados.next()){
                  
                  do{
                  String  str_session="";
                  %>
                   
                  <tr class="celnortab"> 
        <td width="4%">&nbsp;</td>
        <td >
        <%=rst_logados.getString(1)%>
        </td>
        <td >
        <%=rst_logados.getString(7)%>
        </td>
        <td >
        <%=sdf_data.format(rst_logados.getDate(2))%>
        </td>
        <td >
        <%=rst_logados.getTime(3)%>
        </td>
        <td >
        <%=rst_logados.getString(4)%>
        </td>
        <td >
        <%
        int int_operacao = rst_logados.getInt(5);
        if(int_operacao==0){
        out.println(""+trd.Traduz("ENTRADA"));
        str_session="4";
        }
        else if(int_operacao==1){
        out.println(""+trd.Traduz("SAIDA"));
        str_session="3";
        }
        else if(int_operacao==3){
        out.println(""+trd.Traduz("DESCONECTADO"));
        str_session="2";
        }
        else if(int_operacao==4){
        out.println(""+trd.Traduz("DESC. ADM"));
        str_session="1";
        }
        
        %>
        </td>
        <td align="CENTER"> 
        <%
              
        
        if (str_session.equals("1")){
        out.println("<font color=BLUE>"+trd.Traduz("DESCONECTADO PELO ADMINISTRADOR")+"</font>");
        }
        else if (str_session.equals("2")){
        //out.println(""+rst_logados.getString(6));
        out.println("<BLINK><A><font color=RED>"+trd.Traduz("DUPLICIDADE")+"</font></a></BLINK>");
        }
        else if (str_session.equals("3")){
        out.println("<font color=BLACK>"+trd.Traduz("DESATIVADA")+"</font>");
        }
        else if (str_session.equals("4")){
        out.println("<font color=GREEN>"+trd.Traduz("ATIVA")+"</font>");
        }
        
        %>
        </td>
      </tr>
      <%
      }while(rst_logados.next());
      }else{
      %>
      <tr class="celnortab"> 
        <td width="100%" colspan="100%" align="center">
          <b><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%></b>
        </td>
      </tr>
      
      <%
      }
      if(rst_logados != null){
         rst_logados.close();
         conexao.finalizaConexao(session.getId() + "RS2");
      }
      //out.println("str_pesquisa = " + str_pesquisa);
      %>
                  
                  
                  
                  
                  
                 </table> 
          
          
          <br>
          <br>
                  
    </td>
  </table>
        
      </center>
    </td>
  </tr>
  <tr>
    <td align="right" height="30" class="difundo">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <%if(ponto.equals("..")){%>
        <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
        <%}else{%>
        <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
        <%}%>
      </table>
    </td>
  </tr>
</table>

<%
/*}
catch (Exception e)
{
out.println(e);
}*/

%>
 </form>
</body>
</html>
 