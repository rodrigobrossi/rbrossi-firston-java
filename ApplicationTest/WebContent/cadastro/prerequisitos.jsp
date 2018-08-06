<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
  response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />
<%@page import="java.util.Vector, java.sql.ResultSet"%>
<%
//try{
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

//conexaouni.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexaodir.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexaocel.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexaotim.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexao1.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
//conexao2.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
Integer usu_cod  = (Integer)session.getAttribute("usu_cod");
Vector per = (Vector)session.getAttribute("vetorPermissoes");

session.setAttribute("vetor_car", null);
session.setAttribute("vetor_tit", null);
session.setAttribute("vetor_seq", null);

String cod_car = (((String)request.getParameter("sel_cargo")==null)?"Todos":(String)request.getParameter("sel_cargo"));
String cod_tit  = (((String)request.getParameter("sel_titulo")==null)?"Todos":(String)request.getParameter("sel_titulo"));

boolean existe=false,mostraCheck=false,existe2=false;;
int cont=0;
ResultSet rs = null, rs_uni = null, rs_dir = null, rs_cel = null, rs_tim = null, rs1 = null, rs2 = null;
String lotacao = "", unidade = "", diretoria = "", celula = "", time = "", query = ""; 
String filial = ""+usu_fil;
String codigo = ""+usu_cod;

unidade = ""+usu_fil;

Vector querys = new Vector();

if (request.getParameter("op_uni") != null)
  unidade = request.getParameter("op_uni");
else
  unidade = ""+usu_fil;

if (request.getParameter("op_dir") != null)
  diretoria = request.getParameter("op_dir");
if (request.getParameter("op_cel") != null)
  celula = request.getParameter("op_cel");
if (request.getParameter("op_tim") != null)
  time = request.getParameter("op_tim");

lotacao = prm.buscaparam("LOTACAO");

if(lotacao.equals("S"))
{
  if(usu_tipo.equals("F"))
    querys = pos.montaCombo("Cargo", "null", "null", aplicacao, unidade, diretoria, celula, time);  
  
  if(usu_tipo.equals("P"))
    querys = pos.montaCombo("Cargo", filial, "null", aplicacao, unidade, diretoria, celula, time);  

  if(usu_tipo.equals("G"))
    querys = pos.montaCombo("Cargo", filial, "null", aplicacao, unidade, diretoria, celula, time);  
  
  if(usu_tipo.equals("S"))
    querys = pos.montaCombo("Cargo", filial, codigo, aplicacao, unidade, diretoria, celula, time);  
}
else
{
  if(usu_tipo.equals("F"))
    query = cmb.montaCombo("Cargo", "null", "null", aplicacao); 

  if(usu_tipo.equals("P"))
    query = cmb.montaCombo("Cargo", filial, "null", aplicacao); 
  
  if(usu_tipo.equals("G"))
    query = cmb.montaCombo("Cargo", filial, "null", aplicacao); 
  
  if(usu_tipo.equals("S"))
    query = cmb.montaCombo("Cargo", filial, codigo, aplicacao);   
}

if(lotacao.equals("S")){
  rs = conexao.executaConsulta((String)querys.elementAt(0),session.getId()+"RS_1");
  }
else{  
  rs = conexao.executaConsulta(query,session.getId()+"RS_1");
  }

%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Cadastro de PrE-Requisitos")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language  ="JavaScript">
function exclui() {
  var teste = 0;
  var cod = 0;
        var obrigatorio;
  for(i=1;i<=frm.cont.value;i++)
  {
    if(eval("frm.pre"+i+".checked")==true)
    {
      teste = teste+1;
      cod = eval("frm.pre"+i+".value");
                        obrigatorio = eval("frm.obrigatorio"+cod+".value");
    }
  }
  if(teste == 0)
  {
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else
  {
                if(confirm(<%=("\""+trd.Traduz("Deseja Excluir o item selecionado?")+"\"")%>))
                {
                    frm.action ="deleta_prerequisitos.jsp?cargo=<%=cod_car%>&titulo=<%=cod_tit%>"
                    frm.submit();
                }
                else
                { 
                    return false;
                }
  }
}

function Unidade()
{
  window.open("../cadastro/prerequisitos.jsp?op_uni="+filtro.select_uni.value,"_parent");
  return true;
}    
function Diretoria()
{
  window.open("../cadastro/prerequisitos.jsp?op_uni="+filtro.select_uni.value+"&op_dir="+filtro.select_dir.value,"_parent");
  return true;
}    
function Celula()
{
  window.open("../cadastro/prerequisitos.jsp?op_uni="+filtro.select_uni.value+"&op_dir="+filtro.select_dir.value+"&op_cel="+filtro.select_cel.value,"_parent");
  return true;
}    
function Time()
{
  window.open("../cadastro/prerequisitos.jsp?op_uni="+filtro.select_uni.value+"&op_dir="+filtro.select_dir.value+"&op_cel="+filtro.select_cel.value+"&op_tim="+filtro.select_tim.value,"_parent");
  return true;
}    

function inclui()
{
  window.open("grade_req.jsp","_parent");
  return false;
}

function filtra()
{
  filtro.submit();
  return true; 
}

function altera()
{
  var teste = 0;
  var cod = 0;
        var obrigatorio;
  for(i=1;i<=frm.cont.value;i++)
  {
    if(eval("frm.pre"+i+".checked")==true)
    {
      teste = teste+1;
      cod = eval("frm.pre"+i+".value");
                        obrigatorio = eval("frm.obrigatorio"+cod+".value");
    }
  }
  if(teste == 0)
  {
    alert(<%=("\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\"")%>);
    return false;
  }
  else
  {
    if(teste>1)
    {
      alert(<%=("\""+trd.Traduz("Selecione apenas um item!")+"\"")%>);
    }
    else
    {
      frm.action="altera_prerequisito.jsp?codigo="+cod+"&obrigatorio="+obrigatorio;
                        frm.submit();
                        return false;
    }
  }
  return false;
}
</script>

<body  onunload='return fecha();'  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="59" class="hcfundo"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <%
                String ponto = (String)session.getAttribute("barra");
                %>
              <%if(ponto.equals("..")){%>
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
                <td class="trontrk"><%=trd.Traduz("CADASTRO DE PRE-REQUISITOS")%></td>
                <td width="13"><img src="../art/bit.gif" width="13" height="15"></td>
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
          <FORM name="filtro" action ="prerequisitos.jsp">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1"><br>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                  <td height="13"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
        <%
         if (lotacao.equals("S"))
             {
           %>
             <tr>
            <td class="ctfontc"> <%=trd.Traduz("TABELA5")%>: </td>            
            <td>
              <select name="select_uni" onChange="return Unidade();"> 
              <%
                  if(usu_tipo.equals("F")) {
                  %>
                    <option value = "-1"><%=trd.Traduz("Todos")%></option> 
                  <%
                }
                rs_uni = conexao.executaConsulta((String)querys.elementAt(1),session.getId()+"RS_2");
                if (rs_uni.next()){                   
                  do{
                    if((rs_uni.getInt(1)) == (Integer.parseInt(unidade))){
                      %>
                      <option selected value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
                       <%
                    }
                      
                    else
                    {
                      %>
                        <option value = "<%=rs_uni.getInt(1)%>"><%=rs_uni.getString(2)%></option>
                        <%
                    }
                  }while (rs_uni.next());
                  %> </select> <%                 
                  if(rs_uni!=null){
                    conexao.finalizaConexao(session.getId()+"RS_2");
                    }
                }
              %>
            </td>
            
              <td class="ctfontc"> <%=trd.Traduz("TABELA6")%>: </td>  
            
            <td>
              <select name="select_dir" onChange="return Diretoria();"> <option value = "-1">Todos</option> 
              <%
                rs_dir = conexao.executaConsulta((String)querys.elementAt(2), session.getId()+"RS_3");
                if (rs_dir.next())
                {                 
                  do
                  {               
                    if(!(diretoria.equals("")))
                    {
                      if((rs_dir.getInt(1)) == (Integer.parseInt(diretoria)))
                      {                                     %>
                          <option selected value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
                          <%
                      }
                      
                      else
                      {
                        %>
                          <option value =   "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
                          <%    
                      }
                    }
                    else
                    {
                      %>
                        <option value = "<%=rs_dir.getInt(1)%>"><%=rs_dir.getString(2)%></option>
                        <%
                    }
                  }while (rs_dir.next());
                  %> </select> <%                 

                }
                if(rs_dir!=null){
                    conexao.finalizaConexao(session.getId()+"RS_3");
                }
              %>
            </td>
          </tr>         
          
          <tr>
            <td class="ctfontc"> <%=trd.Traduz("TABELA7")%>: </td>                      
              <td>
              <select name="select_cel" onChange="return Celula();"> <option value = "-1">Todos</option>
              <%
                rs_cel = conexao.executaConsulta((String)querys.elementAt(3),session.getId()+"RS_4");
                if (rs_cel.next())
                {
                  do
                  {
                    if(!(celula.equals("")))
                    {
                      if((rs_cel.getInt(1)) == (Integer.parseInt(celula)))
                      {                                     %>
                          <option selected value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
                          <%
                      }
                      
                      else
                      {
                        %>
                          <option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
                          <%    
                      }
                    }
                    else
                    {
                      %>
                        <option value = "<%=rs_cel.getInt(1)%>"><%=rs_cel.getString(2)%></option>
                        <%
                    }
                  }while (rs_cel.next());
                  %> </select> <%                 
                }
                if(rs_cel!=null){
                    conexao.finalizaConexao(session.getId()+"RS_4");
                    }
              %>
            </td>
            
              <td class="ctfontc"> <%=trd.Traduz("TABELA8")%>: </td> 
            
            <td>
              <select name="select_tim" onChange="return Time();"> <option value = "-1">Todos</option> 
              <%
                rs_tim = conexao.executaConsulta((String)querys.elementAt(4),session.getId()+"RS_5");
                if (rs_tim.next())
                {
                  do
                  {
                    if(!(time.equals("")))
                    {
                      if((rs_tim.getInt(1)) == (Integer.parseInt(time)))
                      {                                     %>
                          <option selected value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
                          <%
                      }
                      
                      else
                      {
                        %>
                          <option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
                          <%    
                      }
                    }
                    else
                    { 
                      %>
                        <option value = "<%=rs_tim.getInt(1)%>"><%=rs_tim.getString(2)%></option>
                        <%
                    }
                  }while (rs_tim.next());
                  %> </select> <%                 
                  if(rs_tim!=null){
                    conexao.finalizaConexao(session.getId()+"RS_5");
                    }  
                }
              %>
            </td>
            </tr>
            <%                    
         }
          %>

        <tr>            
        <td colspan="4">&nbsp;  </td>
        </tr>
        </table>

              <table width="100%" border="0" cellspacing="0" cellpadding="0">
        
                <tr> 
                  <td height="20" class="ctfontc" align="center"><%=trd.Traduz("TITULO")%>: 
                  <select name="sel_titulo">
              <option >Todos</option>
                  <%
                String query1 = "SELECT tit_codigo, tit_nome FROM titulo ORDER BY TIT_NOME ";
                    rs1 = conexao.executaConsulta(query1,session.getId()+"RS_6");
                    while (rs1.next())
                    {
                      if(rs1.getString(1).equals(request.getParameter("sel_titulo")))
                      {
                        %>
                        <option selected value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
                        <%
                      }
                      else
                      {
                        %>
                        <option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%></option>
                        <%
                      }
                     
                    }
                if(rs1!=null){
                        conexao.finalizaConexao(session.getId()+"RS_6");
                        }
              %>
                      </select>

                      &nbsp; &nbsp; &nbsp;<%=trd.Traduz("CARGO")%>: 
                    <select name="sel_cargo">
            <option >Todos</option> 
            <%
            
              if(lotacao.equals("S"))
              {
                if(usu_tipo.equals("F"))
                  querys = pos.montaCombo("Cargo", "null", "null", aplicacao, unidade, diretoria, celula, time);  

                if(usu_tipo.equals("P"))
                  querys = pos.montaCombo("Cargo", filial, "null", aplicacao, unidade, diretoria, celula, time);  

                if(usu_tipo.equals("G"))
                  querys = pos.montaCombo("Cargo", filial, "null", aplicacao, unidade, diretoria, celula, time);  
  
                if(usu_tipo.equals("S"))
                  querys = pos.montaCombo("Cargo", filial, codigo, aplicacao, unidade, diretoria, celula, time);  
              }

              else
              {
                if(usu_tipo.equals("F"))
                  query = cmb.montaCombo("Cargo", "null", "null", aplicacao); 

                if(usu_tipo.equals("P"))
                  query = cmb.montaCombo("Cargo", filial, "null", aplicacao); 
  
                if(usu_tipo.equals("G"))
                  query = cmb.montaCombo("Cargo", filial, "null", aplicacao); 

                if(usu_tipo.equals("S"))
                  query = cmb.montaCombo("Cargo", filial, codigo, aplicacao); 
              }                 

              if(lotacao.equals("S"))
                rs = conexao.executaConsulta((String)querys.elementAt(0),session.getId()+"RS_7");
              else  
                rs = conexao.executaConsulta(query,session.getId()+"RS_7");      

              if(rs.next())
              {
                existe=true;
              }

              while (rs.next())
              {    
                if(rs.getString(1).equals(request.getParameter("sel_cargo")))
                {
                  %>
                    <option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                  <%
                }
                else
                {
                  %>
                    <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                  <%
                }
              }
              if(rs!=null){
                conexao.finalizaConexao(session.getId()+"RS_7");
                }
              %>
                    </select>
                   <input type="button" class="botcin" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> onClick="return filtra();">
                  </td>
              </tr>
                </FORM>
              <tr> 
                <td height="12"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                <td class="ctvdiv" height="1"><img src="../art/bit.gif" width="1" height="1"></td>
              </tr>
              <tr> 
                  <td align="center">&nbsp;<br>
                  <!--OpCOes -->
                  <% 
    

   //Filtra os dados para o Tipo de usuário
   String par = "";

   if (usu_tipo.equals("F"))
   { 
       par = "";
   }
   else if (usu_tipo.equals("P"))
   {
	   par = " AND C.TB5_CODIGO = " + usu_fil + " "; 
   }
   else if (usu_tipo.equals("G"))
   {
       par = " AND C.TB5_CODIGO = " + usu_fil + " "; 
   }
   else if (usu_tipo.equals("S"))
   {
       par = " AND C.TB5_CODIGO = " + usu_fil + " AND C.CAR_CODIGO IN (SELECT CAR_CODIGO FROM FUNCIONARIO WHERE FUN_CODSOLIC = " + usu_cod + ") "; 
   }


                      //<%
                      //  out.println("<p>"+cod_car);
                      //    out.println("<p>"+cod_tit+"<p>");
                        String query2 ="";
                        
                        if(cod_car.equals("Todos")&&cod_tit.equals("Todos")){
          query2=" SELECT p.plc_codigo, c.car_nome, t.tit_nome,c.car_codigo,t.tit_codigo,p.plc_obrigatorio"+
                      " FROM planocarreira p, cargo c, titulo t "+
                      " WHERE p.car_codigo = c.car_codigo AND p.tit_codigo = t.tit_codigo " + par + " ORDER BY T.TIT_NOME, C.CAR_NOME ";
          }
                        else if ((cod_car.equals("Todos")&&!cod_tit.equals("Todos"))){
                            query2=" SELECT p.plc_codigo, c.car_nome, t.tit_nome,c.car_codigo,t.tit_codigo,p.plc_obrigatorio"+
                      " FROM planocarreira p, cargo c, titulo t "+
                        " WHERE t.tit_codigo= "+cod_tit+" AND p.car_codigo = c.car_codigo AND p.tit_codigo = t.tit_codigo " + par + " ORDER BY T.TIT_NOME, C.CAR_NOME ";
          }              
                        else if ((!cod_car.equals("Todos")&&cod_tit.equals("Todos"))){
                            query2=" SELECT p.plc_codigo, c.car_nome, t.tit_nome,c.car_codigo,t.tit_codigo,p.plc_obrigatorio"+
              " FROM planocarreira p, cargo c, titulo t "+
              " WHERE c.car_codigo="+cod_car+" AND p.car_codigo = c.car_codigo AND p.tit_codigo = t.tit_codigo " + par + " ORDER BY T.TIT_NOME, C.CAR_NOME ";
          }   
                        else if ((!cod_car.equals("Todos")&&!cod_tit.equals("Todos"))){
                            query2=" SELECT p.plc_codigo, c.car_nome, t.tit_nome,c.car_codigo,t.tit_codigo,p.plc_obrigatorio"+
                 " FROM planocarreira p, cargo c, titulo t "+
                 " WHERE t.tit_codigo="+cod_tit+" AND c.car_codigo="+cod_car+" AND p.car_codigo = c.car_codigo AND p.tit_codigo = t.tit_codigo " + par + " ORDER BY T.TIT_NOME, C.CAR_NOME ";
          }
                        
               
                        rs2 = conexao.executaConsulta(query2,session.getId()+"RS_8");
                        boolean check = false;
    
    if (per.contains("CADASTRO PRE-REQ. - MANUTENCAO")){
      mostraCheck=true;
      %>     
                  
                    <table border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
            <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
            <tr> 
              <td onMouseOver="this.className='ctonlnk2';" onClick="return inclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
            </tr>
            </table>
           </td>           
        <%
        if(rs2.next()){
          existe2 = true;
          %>  
                                <td width="10">&nbsp;</td>
        <td> 
                      <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                      <tr> 
                        <td onMouseOver="this.className='ctonlnk2';" onClick="return exclui()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
                      </tr>
          </table>
        </td>
        <td width="10">&nbsp;</td>
        <td> 
                      <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                      <tr> 
                        <td onMouseOver="this.className='ctonlnk2';" onClick="return altera()" width="127" height="22" align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
                      </tr>
          </table>
        </td>
        <%
      }
      if(rs2!=null){
        conexao.finalizaConexao(session.getId()+"RS_8");
        }
      %>
      </tr>                
      </table>
    
    <!--Fim das opCOes em botOes -->
    <%}%>
                    
          <form  name="frm" method="POST">
                    <table border="0" cellspacing="1" cellpadding="0" width="80%">
                  <%
                  if(existe2){
                    %>
                    <tr> 
                       <td width="4%">&nbsp;</td>
                       <td width="48%" class="celtittab"><%=trd.Traduz("TITULO")%></td>
                       <td width="48%" class="celtittab"><%=trd.Traduz("CARGO")%></td>
                    </tr>
                      <%
                          rs2 = conexao.executaConsulta(query2,session.getId()+"RS_9");
                          while(rs2.next()){
                            cont++;
                            %>
                            <tr class="celnortab"> 
                            <td width="4%"> 
                            <%
                            if(mostraCheck){
                              if(check==false){
                                %>
                                <input type="checkbox"   name="pre<%=cont%>"    value="<%=rs2.getInt(1)%>">
                                  <%
                                check=true;
                              }
                              else{
                                  %>
                                <input type="checkbox"   name="pre<%=cont%>"    value="<%=rs2.getInt(1)%>" >
                                <%
                              }
                            }
                            else{
                              %>
                              &nbsp;
                              <%
                            }
                           
                            
                            %>
                            <input type="hidden" name="titulo<%=rs2.getInt(1)%>" value="<%=rs2.getInt(5)%>">
                            <input type="hidden" name="cargo<%=rs2.getInt(1)%>" value="<%=rs2.getInt(4)%>">
                            <input type="hidden" name="obrigatorio<%=rs2.getInt(1)%>" value="<%=rs2.getString(6)%>">
                            </td>
                            <td width="48%"><%=rs2.getString(3)%></td>
                            <td width="48%"><%=rs2.getString(2)%></td>
                            </tr>
                            <%
                          }
                            if(rs2!=null){
                                conexao.finalizaConexao(session.getId()+"RS_9");
                            }
                      }
                      else{
                          %>
                          <tr>
                            <td width="96%" class="celtittab" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
                          </tr>
                          <%
                      }
    
                      %>
                    </table>
                  </td>
              </tr>
            </table>
          </td>
          <td width="20" valign="top"></td>
        </tr>
      </table>
      <input type="hidden" name="cont" value="<%=cont%>">
      </form>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr> 
    <td align="right" height="30" class="difundo"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
          <%if(ponto.equals("..")){%>
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

<%/**
if(rs != null)
  rs.close();
conexao.finalizaConexao();

conexaouni.finalizaConexao();
conexaouni.finalizaBD();

conexaodir.finalizaConexao();
conexaodir.finalizaBD();

conexaocel.finalizaConexao();
conexaocel.finalizaBD();

conexaotim.finalizaConexao();
conexaotim.finalizaBD();

conexao1.finalizaConexao();
conexao1.finalizaBD();

conexao2.finalizaConexao();
conexao2.finalizaBD();**/
%>
</body>
</html>
<%
//}catch(Exception e){out.println("Erro: "+e);}
%>