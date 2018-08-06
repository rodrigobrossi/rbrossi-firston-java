function cancelar() {
  window.open("06_criarturmaantecipada.jsp", "_parent");
}

function enviar() {
  var c = frm.cont_avaliacao.value; 
  for(i=1;i<=c;i++) {
    if(eval("frm.chk_"+i+".checked") && ((eval("frm.txt_dt_vencimento_"+i+".value")=="") || (eval("frm.txt_dt_envio_"+i+".value")==""))) {
      alert("Favor escolher data de envio e data de vencimento para as avaliacoes escolhidas!");
      return false;
    } else {
      if(eval("frm.chk_"+i+".checked") && (eval("frm.cbo_questionario_"+i+".value")=="")) {
        alert("Favor escolher um questionArio para a avaliacao escolhida!");
        return false;
      }
    }
  }
  frm.action = "10_turmaantecipada_reg_grava.jsp";
  frm.submit();
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
		alert("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")
}

function incpart() {
	document.frm.extra.value = "S";
	//frm.action = "10_turmaantecipada_reg.jsp";//Estava chamando a mesma pAgina, resultando em erro(NullPointerException)
	frm.action = "10_turmaantecipada_part_inc.jsp";
    frm.submit();
	return false;
} 
function incpartpla() {          
	document.frm.extra.value = "S";
	//frm.action = "10_turmaantecipada_reg.jsp";//Estava chamando a mesma pAgina, resultando em erro(NullPointerException)
	frm.action = "10_turmaantecipada_part_incpla.jsp";
    frm.submit();
	return false;
} 
function excpart() {          
	document.frm.extra.value = "S";
	//frm.action = "10_turmaantecipada_reg.jsp";//Estava chamando a mesma pAgina, resultando em erro(NullPointerException)
	frm.action = "10_turmaantecipada_part_del.jsp";
    frm.submit();
	return false;
}
function ProximaPag(valor){
	document.frm.p.value = valor.value;
	document.frm.i.value = "-1";  
	frm.action = "10_turmaantecipada_reg.jsp";
	frm.submit();
	return false;
}            
function AnteriorPag(valor){
	document.frm.p.value = valor.value;
	document.frm.i.value = "-1";  
	frm.action = "10_turmaantecipada_reg.jsp";
	frm.submit();
	return false;
}            

function PrimeiraPag(){
	document.frm.p.value = "1";
	document.frm.i.value = "-1";  
	frm.action = "10_turmaantecipada_reg.jsp";
	frm.submit();
	return false;
}   
function irpag(pagTotal){
	if(document.frm.textir.value == ""){
		alert("Digite o nUmero da pAgina");
		frm.textir.focus();
	}
	else if((document.frm.textir.value > pagTotal) || (document.frm.textir.value < 1)){
		alert("NUmero da pAgina invAlido");
		frm.textir.focus();
	}
	else{
		document.frm.p.value = "1";
		document.frm.i.value = document.frm.textir.value;
		frm.action = "";
		frm.submit();
		return false;
	}
}            
function irpag2(){
	if(document.frm.textir2.value == ""){
		alert("Digite o nUmero da pAgina");
		frm.textir2.focus();
	}
	else if((document.frm.textir2.value > pagtotal) || (document.frm.textir2.value < 1)){
		alert("NUmero da pAgina invAlido");
		frm.textir2.focus();
	}
	else{
		document.frm.p.value = "1";
		document.frm.i.value = document.frm.textir2.value;
		frm.action = "10_turmaantecipada_reg.jsp";
		frm.submit();
		return false;
	}
}         
