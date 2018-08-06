<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
    response.setHeader("Cache-Control", "no-cache");
}%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />
<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<%
try{

request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");

String usu_tipo = (String)session.getAttribute("usu_tipo");
String usu_nome = (String)session.getAttribute("usu_nome");
String usu_login = (String)session.getAttribute("usu_login");
String aplicacao = (String) session.getAttribute("aplicacao");
Integer usu_fil = (Integer)session.getAttribute("usu_fil");
Integer usu_idi = (Integer)session.getAttribute("usu_idi");

//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo da Saratoga
String tipo = "";
String cod = "1";
Vector querys = new Vector();
String filial = ""+usu_fil;

String dbFil = "", dbDep = "", dbCel = "", dbTim = "";

if (!(request.getParameter("tipo") == null)){ 
  tipo = request.getParameter("tipo");
}
if (!(request.getParameter("cod") == null)){ 
  cod = request.getParameter("cod");
}

//Se for alteracao faz a query 
ResultSet rs = null, rs_cbo = null, rsFil = null, rsDep = null, rsCel = null, rsTim = null;

String query = "SELECT CAR_CODIGO, CAR_NOME, TB5_CODIGO, TB6_CODIGO, TB7_CODIGO, TB8_CODIGO "+
               "FROM CARGO " + 
               "WHERE CAR_CODIGO = " + cod + " ORDER BY CAR_NOME";     

rs = conexao.executaConsulta(query,session.getId()+"RS_1"); 

String car_codigo = "", car_nome = "", tb5_codigo = "", tb6_codigo = "", tb7_codigo = "", tb8_codigo = "";

if(rs.next()){
    car_codigo  = ((rs.getString(1)==null)?"":rs.getString(1));
    car_nome    = ((rs.getString(2)==null)?"":rs.getString(2));
    tb5_codigo  = ((rs.getString(3)==null)?"":rs.getString(3));
    tb6_codigo  = ((rs.getString(4)==null)?"":rs.getString(4));
    tb7_codigo  = ((rs.getString(5)==null)?"":rs.getString(5));
    tb8_codigo  = ((rs.getString(6)==null)?"":rs.getString(6));
}
if(rs!=null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS_1");
}
String unidade = ""+usu_fil, diretoria = "", celula = "", time = "";
if (request.getParameter("op_uni") != null){
    unidade = request.getParameter("op_uni");
}
else if(!tipo.equals("I")){
    unidade = tb5_codigo;
}
else{
    unidade = ""+usu_fil;
}

if (request.getParameter("op_dir") != null){
    diretoria = request.getParameter("op_dir");
}
else if(!tipo.equals("I")){
    diretoria = tb6_codigo;
}
if (request.getParameter("op_cel") != null){
    celula = request.getParameter("op_cel");
}
else{
    celula = tb7_codigo;
}
if (request.getParameter("op_tim") != null){
    time = request.getParameter("op_tim");
}
else{
    time = tb8_codigo;
}
String carnome = "";
if(!tipo.equals("I")){
    carnome = (((String)request.getParameter("carnome")==null)?car_nome:(String)request.getParameter("carnome"));
}
else{
    carnome = "";
}

String lotacao = prm.buscaparam("LOTACAO");
String opt_filtro = "Cargo";

if(lotacao.equals("S")){
    if(usu_tipo.equals("F")){
        querys = pos.montaCombo(opt_filtro, "null", "null", aplicacao, unidade, diretoria, celula, time);
    }
    if(usu_tipo.equals("P") || usu_tipo.equals("G")){
        querys = pos.montaCombo(opt_filtro, filial, "null", aplicacao, unidade, diretoria, celula, time);
    }
}
else{
    if(usu_tipo.equals("F")){
        query = cmb.montaCombo(opt_filtro, "null", "null", aplicacao);
    }
    if(usu_tipo.equals("P") || usu_tipo.equals("G")){
        query = cmb.montaCombo(opt_filtro, filial, "null", aplicacao);
    }
}







%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - 
<%
if(tipo.equals("I")){
  %>
  <%=trd.Traduz("INCLUSAO DE CARGO")%></title>
  <%
}
else{
  %>
  <%=trd.Traduz("ALTERACAO DE CARGO")%></title>
  <%
}
%>

<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function envia(){
  if(document.frm.sel_filial.value == ""){
    alert(<%=("\""+trd.Traduz("SELECIONE UMA FILIAL ")+"\"")%>);
    return false;
  }
  else if(document.frm.sel_dept.value == ""){
    alert(<%=("\""+trd.Traduz("SELECIONE UM DEPARTAMENTO")+"\"")%>);
    return false;
  }
  else if(document.frm.carnome.value==""){
    alert(<%=("\""+trd.Traduz("DIGITE O CARGO")+"\"")%>);
    return false;
  }
  else{
    frm.submit();
    return false;
  }
}

function cancela(){
  window.open("auxiliares.jsp","_self");
}
function aspa(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 == "\"" || aux2 == "\'"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function aspa2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == "\"" || aux2 == "\'")
      k = k+1;
    tam--;
  }
  if(k != 0){
    alert(<%=("\""+trd.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA")+"\"")%>);
    campo.focus();
    campo.value = "";
  }
}

function Unidade(){
    /*window.open("../cadastro/inclusaodecargo.jsp?op_uni="+frm.sel_filial.value+"&tipo=I","_parent");*/
    frm.op_uni.value = frm.sel_filial.value;
    frm.action = "../cadastro/inclusaodecargo.jsp";
    frm.submit();
    return true;
}    
function Diretoria(){
    /*window.open("../cadastro/inclusaodefuncionario.jsp?op_uni="+frm.sel_filial.value+"&op_dir="+frm.sel_departamento.value,"_parent");*/
    frm.op_uni.value = frm.sel_filial.value;
    frm.op_dir.value = frm.sel_dept.value;
    frm.action = "../cadastro/inclusaodecargo.jsp";
    frm.submit();
    return true;
}    
function Celula(){
    /*window.open("../cadastro/inclusaodefuncionario.jsp?op_uni="+frm.cbo_filial.value+"&op_dir="+frm.cbo_departamento.value+"&op_cel="+frm.cbo_tb2.value,"_parent");*/
    frm.op_uni.value = frm.sel_filial.value;
    frm.op_dir.value = frm.sel_dept.value;
    frm.op_cel.value = frm.sel_cel.value;
    frm.action = "../cadastro/inclusaodecargo.jsp";
    frm.submit();
    return true;
}    
function Time(){
    /*window.open("../cadastro/inclusaodefuncionario.jsp?op_uni="+frm.cbo_filial.value+"&op_dir="+frm.cbo_departamento.value+"&op_cel="+frm.cbo_tb2.value+"&op_tim="+frm.cbo_tb3.value,"_parent");*/
    frm.op_uni.value = frm.sel_filial.value;
    frm.op_dir.value = frm.sel_dept.value;
    frm.op_cel.value = frm.sel_cel.value;
    frm.op_tim.value = frm.sel_tim.value;
    frm.action = "../cadastro/inclusaodecargo.jsp";
    frm.submit();
    return true;
}    

</script>

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
               <%
            String ponto = (String)session.getAttribute("barra");
        if(ponto.equals("..")){%>
               <jsp:include page="../menu/banner.jsp" flush="true">
               <jsp:param value="opt" name="SO"/>
               </jsp:include>
               <%}else{%>
               <jsp:include page="/menu/banner.jsp" flush="true">
               <jsp:param value="opt" name="SO"/>
               </jsp:include>
               <%}%>
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
        if (request.getParameter("op") == null)
        {
                  oi = "../menu/menu.jsp?op="+"C";
        }
        else
        {
                  oi = "../menu/menu.jsp?op="+request.getParameter("op");
        }
        if (request.getParameter("opt") == null)
        {
                  oia = "../menu/menu1.jsp?opt="+"AX"; //out.println("nulo = " + oia);
        } 
        else
        {  
                  oia = "../menu/menu1.jsp?opt="+request.getParameter("opt"); //out.println("cheio = " + oia);
        }
    }else{
    if (request.getParameter("op") == null)
            {
                      oi = "/menu/menu.jsp?op="+"C";
            }
            else
            {
                      oi = "/menu/menu.jsp?op="+request.getParameter("op");
            }
            if (request.getParameter("opt") == null)
            {
                      oia = "/menu/menu1.jsp?opt="+"AX"; //out.println("nulo = " + oia);
            } 
            else
            {  
                      oia = "/menu/menu1.jsp?opt="+request.getParameter("opt"); //out.println("cheio = " + oia);
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
    <td class="trontrk">
    <%
    if (tipo.equals("I")){
      %>
            <%=trd.Traduz("INCLUSAO DE CARGO")%>
            <%
        }
        else{
             %>
             <%=trd.Traduz("ALTERACAO DE CARGO")%>
             <%
        }
        %>
                </td>
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
      <FORM name = "frm" action="cargograva.jsp" method="POST">
          <td valign="top"> <img src="../art/bit.gif" width="159" height="1">&nbsp;<br><center>
                <table border="0" cellspacing="2" cellpadding="3" width="90%">
                 <tr class="celnortab">
                  <td><%=trd.Traduz("FILIAL")%><br>
                  <select name="sel_filial" onChange="return Unidade();">
                  <%
                    rs_cbo = conexao.executaConsulta((String)querys.elementAt(1),session.getId()+"RS_2");
                    /*
                    if(!tipo.equals("I")){
                        String queryFil = "SELECT TB5_CODIGO, TB5_DESCRICAO FROM TABELA5";
                        rsFil = conexaoFil.executaConsulta(queryFil);
                        if(rsFil.next()){
                            dbFil = rsFil.getString(1);
                        }
                    }
                    */
                    if (rs_cbo.next()){
                        if(tipo.equals("I")){
                            //String tab5codigo = (((String)request.getParameter("sel_filial")==null)?"":(String)request.getParameter("sel_filial"));
                            do{
                                if(unidade.equals(rs_cbo.getString(1))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                            }while (rs_cbo.next());
                        }
                        else{
                            do{
                                if(unidade.equals(rs_cbo.getString(1))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                } 
                            }while (rs_cbo.next());
                        }
                       
                    }
                    if(rs_cbo!=null){
                            rs_cbo.close();
                            conexao.finalizaConexao(session.getId()+"RS_2");
                        }
                    %>
                    </select>
                    </td>
                     <td><%=trd.Traduz("DEPARTAMENTO")%><br>
                     <select name="sel_dept" onChange="return Diretoria();">
                     <option value=""><%=trd.Traduz("SELECIONE")%></option>
                    <%
                    rs_cbo = conexao.executaConsulta((String)querys.elementAt(2),session.getId()+"RS_3");
                    /*
                    if(!tipo.equals("I")){
                        String queryDep = "SELECT TB6_CODIGO, TB6_DESCRICAO FROM TABELA6";
                        rsDep = conexaoDep.executaConsulta(queryDep);
                        if(rsDep.next()){
                            dbDep = rsDep.getString(1);
                        }
                    }
                    */
                    if (rs_cbo.next()){
                        if(tipo.equals("I")){
                            do{
                                if(diretoria.equals(rs_cbo.getString(1))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                            }while (rs_cbo.next());
                        }
                        else{
                            do{
                                if((tb6_codigo.equals(rs_cbo.getString(1)) || diretoria.equals(rs_cbo.getString(1))) && (!diretoria.equals(""))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                } 
                            }while (rs_cbo.next());
                        }
                    }
                 if(rs_cbo!=null){
                            rs_cbo.close();
                            conexao.finalizaConexao(session.getId()+"RS_3");
                        }
                    %>
                     </select>
                     </td>
                    </tr>
                    <tr class="celnortab">
                     <td><%=trd.Traduz("CELULA")%><br>
                     <select name="sel_cel" onChange="return Celula();">
                     <option value=""><%=trd.Traduz("SELECIONE")%></option>
                    <%
                    rs_cbo = conexao.executaConsulta((String)querys.elementAt(3),session.getId()+"RS_4");
                    /*
                    if(!tipo.equals("I")){
                        String queryCel = "SELECT TB7_CODIGO, TB7_DESCRICAO FROM TABELA7";
                        rsCel = conexaoCel.executaConsulta(queryCel);
                        if(rsCel.next()){
                           dbCel = rsCel.getString(1);
                       }
                    }
                    */
                    if (rs_cbo.next()){
                        if(tipo.equals("I")){
                            do{
                                if(celula.equals(rs_cbo.getString(1))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                            }while (rs_cbo.next());
                        }
                        else{
                            do{
                                if((tb7_codigo.equals(rs_cbo.getString(1)) || celula.equals(rs_cbo.getString(1))) && (!celula.equals(""))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                } 
                            }while (rs_cbo.next());
                        }
                    }
                       if(rs_cbo!=null){
                            rs_cbo.close();
                            conexao.finalizaConexao(session.getId()+"RS_4");
                        }
                    %>
                     </select>
                     </td>
                     <td><%=trd.Traduz("TIME")%><br>
                     <select name="sel_tim">
                     <option value=""><%=trd.Traduz("SELECIONE")%></option>
                    <%
                    rs_cbo = conexao.executaConsulta((String)querys.elementAt(4),session.getId()+"RS_5");
                    /*
                    if(!tipo.equals("I")){
                        String queryCel = "SELECT TB7_CODIGO, TB7_DESCRICAO FROM TABELA7";
                        rsCel = conexaoCel.executaConsulta(queryCel);
                        if(rsCel.next()){
                           dbCel = rsCel.getString(1);
                       }
                    }
                    */
                    if (rs_cbo.next()){
                        if(tipo.equals("I")){
                            do{
                                if(time.equals(rs_cbo.getString(1))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                            }while (rs_cbo.next());
                        }
                        else{
                            do{
                                if((tb8_codigo.equals(rs_cbo.getString(1)) || time.equals(rs_cbo.getString(1))) && (!time.equals(""))){
                                    %><option selected value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                }
                                else{
                                    %><option value="<%=rs_cbo.getString(1)%>"><%=rs_cbo.getString(2)%></option><%
                                } 
                            }while (rs_cbo.next());
                        }
                    }
                    if(rs_cbo!=null){
                            rs_cbo.close();
                            conexao.finalizaConexao(session.getId()+"RS_5");
                        }
                    %>
                     </td>
                    </tr>
                   <tr class="celnortab"> 
                    <td colspan="100%">        
                      <p><%=trd.Traduz("CARGO")%><br>
                       <input type="text" name="carnome" maxlength="30" size="70" value="<%=carnome%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">
                       &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                        <input type="hidden" name="tipo" value="<%=tipo%>">
                        <input type="hidden" name="cod" value="<%=cod%>">
                        <input type="hidden" name="op_uni">
                        <input type="hidden" name="op_dir">
                        <input type="hidden" name="op_cel">
                        <input type="hidden" name="op_tim">
                    </td>
                  </tr>
                  <tr> 
                    <td align="center" colspan="100%">&nbsp;<br>
                      <input type="button" onClick="return envia();"  value="        <%=trd.Traduz("OK")%>        " class="botcin" name="buttonok"> 
                      &nbsp; <input type="button" onClick="return cancela()"  value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%> class="botcin" name="buttoncancel"></td>
                  </tr>
                </table>
                <p>&nbsp;
              </center>
          </td>
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
          <td><%if(ponto.equals("..")){%> 
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
/**
if(rs != null)
  
    rs.close();
    conexao.finalizaConexao();
   */ 


}catch(Exception e){out.println("ERRO: "+e);}
%>