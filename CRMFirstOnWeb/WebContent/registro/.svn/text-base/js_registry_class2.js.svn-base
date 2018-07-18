function checatudo(count) {
    var contador = 0;
    for (i = 0; i < eval(cont); i++)
	if (eval("frm.checkbox" + i + ".checked"))
	    contador++;
    if (contador === eval(cont)) {
	for (i = 0; i < cont; i++) {
	    eval("frm.checkbox" + i).checked = false;
	}
    } else {
	for (i = 0; i < cont; i++) {
	    eval("frm.checkbox" + i).checked = true;
	}
    }
}

function enviar() {
    var c = frm.cont_avaliacao.value; // aux. loop de verificacao das datas de
					// envio e vencimento
    var gera_a = "0"; // aux. loop de verificacao se esta gerando avaliacao

    for (i = 1; i <= c; i++) {
	if (eval("frm.chk_" + i + ".checked")
		&& ((eval("frm.txt_dt_vencimento_" + i + ".value") == "") || (eval("frm.txt_dt_envio_"
			+ i + ".value") == ""))) {
	    alert("Favor escolher data de envio e data de vencimento para as avaliacoes escolhidas!");
	    return false;
	} else {
	    if (eval("frm.chk_" + i + ".checked")
		    && (eval("frm.cbo_questionario_" + i + ".value") == "")) {
		alert("Favor escolher um questionArio para a avaliacao escolhida!");
		return false;
	    }
	}

	if (eval("frm.chk_" + i + ".checked")) {
	    gera_a = "1";
	}

    }
    var cont = 0;
    for (i = 1; i <= frm.n_funcionario.value; i++) {
	if (eval("frm.checkbox" + i + ".checked") == true) {
	    cont = cont + 1;
	}
    }
    if ((cont == 0) && funcvet.size() == 0) {
	alert("NENHUM ITEM SELECIONADO");
    } else {
	if (frm.selectprev.value == "") {
	    alert("FAVOR SELECIONAR A PREVISAO!");
	    return false;
	} else if (frm.textdurh.value == "" || frm.textdurm.value == "") {
	    alert("FAVOR DIGITAR A DURACAO (HH:MM)!");
	    return false;
	} else if (frm.textcusto.value == "") {
	    alert("FAVOR DIGITAR O CUSTO!");
	    return false;
	} else if (frm.textreembolso.value == "") {
	    alert("FAVOR DIGITAR O REEMBOLSO!");
	    return false;
	} else if (frm.texthist.value == "") {
	    alert("FAVOR DIGITAR O HISTORICO!");
	    return false;
	}

	document.frm.gera_av.value = gera_a;
	frm.action = "09_criarlancamento_grava.jsp";
	frm.submit();
    }
    return false;
}

function FormataData(campo, evento, direcao) {
    if (campo.value.length < 10000) {
	if (evento != 9) {// tab
	    if (evento != 8 && evento != 46 && evento != 16
		    && !(evento > 36 && evento < 41)) { // delete, backspace,
							// shift nAo causam
							// evento
		var tam = campo.value.length
		if ((evento >= 48 && evento <= 57)
			|| (evento >= 96 && evento <= 105)) {
		    if (tam == 2 || tam == 5) {
			campo.value = campo.value + "/";
		    }
		} else {
		    if (direcao == "up") {
			if (campo.value.length == 0) {
			    campo.value = ""
			} else {
			    campo.value = campo.value.substring(0,
				    campo.value.length - 1)
			}
		    }
		}
		campo.focus()
	    }
	} else {
	    if (direcao == "down") {
		ChecaData(campo)
	    }
	}
    }
}

function ChecaData(THISDATE) {
    var erro = 0
    var data = THISDATE.value
    if (data.length != 10)
	erro = 1
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
    if (mes == 4 || mes == 6 || mes == 9 || mes == 11) {
	if (dia == 31)
	    erro = 1
    }
    if (mes == 2) {
	var bis = parseInt(ano / 4)
	if (isNaN(bis)) {
	    erro = 1
	}
	if (dia > 29)
	    erro = 1
	if (dia == 29 && ((ano / 4) != parseInt(ano / 4)))
	    erro = 1
    }
    if ((erro == 1) && (THISDATE.value != "")) {
	alert(THISDATE.value + ' trd.Traduz("E uma data invAlida!")');
	THISDATE.value = "";
    }
}
function DoCal(elTarget) {
    if (showModalDialog) {
	var sRtn;
	sRtn = showModalDialog("calendar.htm", "",
		"center=yes;status=no;dialogWidth=306px;dialogHeight=220px");
	if (sRtn != "")
	    elTarget.value = sRtn;
    } else
	alert("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")
}

function incpart() {
    document.frm.extra.value("S");
    frm.action("10_turmaantecipada_part_inc.jsp");
    frm.submit();
}
function incpartpla() {
    document.frm.extra.value("S");
    frm.action("10_turmaantecipada_part_incpla.jsp");
    frm.submit();
    return false;
}
function excpart() {
    document.frm.extra.value = "S";
    frm.action = "10_turmaantecipada_part_del.jsp";
    frm.submit();
    return false;
}
function ProximaPag(valor) {
    document.frm.p.value = valor.value;
    document.frm.i.value = "-1";
    frm.action = "09_criarlancamento.jsp";
    frm.submit();
    return false;
}
function AnteriorPag(valor) {
    document.frm.p.value = valor.value;
    document.frm.i.value = "-1";
    frm.action = "09_criarlancamento.jsp";
    frm.submit();
    return false;
}
function PrimeiraPag() {
    document.frm.p.value = "1";
    document.frm.i.value = "-1";
    frm.action = "09_criarlancamento.jsp";
    frm.submit();
    return false;
}
function irpag() {
    if (document.frm.textir.value == "") {
	alert("Digite o nUmero da pAgina");
	frm.textir.focus();
    } else if ((document.frm.textir.value > eval(pagtotal))
	    || (document.frm.textir.value < 1)) {
	alert("NUmero da pAgina invAlido");
	frm.textir.focus();
    } else {
	document.frm.p.value = "1";
	document.frm.i.value = document.frm.textir.value;
	frm.action = "";
	frm.submit();
	return false;
    }
}
function irpag2() {
    if (document.frm.textir2.value == "") {
	alert("Digite o nUmero da pAgina");
	frm.textir2.focus();
    } else if ((document.frm.textir2.value > eval(pagtotal))
	    || (document.frm.textir2.value < 1)) {
	alert("NUmero da pAgina invAlido");
	frm.textir2.focus();
    } else {
	document.frm.p.value = "1";
	document.frm.i.value = document.frm.textir2.value;
	frm.action = "09_criarlancamento.jsp";
	frm.submit();
	return false;
    }
}

function duracao(campo) {
    aux = campo.value;
    tam = aux.length
    aux2 = aux.substring(tam - 1, tam);
    if (aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4"
	    && aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8"
	    && aux2 != "9") {
	aux = campo.value;
	aux = aux.length;
	aux = aux - 1;
	pal = campo.value;
	campo.value = pal.substring(0, aux);
    }

}
function duracao2(campo) {
    aux = campo.value;
    tam = aux.length;
    i = 0;
    nova = "";
    while (i != tam) {
	aux2 = aux.substring(i, i + 1);
	if (aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3"
		&& aux2 != "4" && aux2 != "5" && aux2 != "6" && aux2 != "7"
		&& aux2 != "8" && aux2 != "9") {
	    nova = nova;
	} else {
	    nova = nova + aux2;
	}
	i++;

    }
    campo.value = nova;
}
function numero(campo) {
    aux = campo.value;
    tam = aux.length
    aux2 = aux.substring(tam - 1, tam);
    if (aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4"
	    && aux2 != "," && aux2 != "5" && aux2 != "6" && aux2 != "7"
	    && aux2 != "8" && aux2 != "9") {
	aux = campo.value;
	aux = aux.length;
	aux = aux - 1;
	pal = campo.value;
	campo.value = pal.substring(0, aux);
    }
}

function numero2(campo) {
    aux = campo.value;
    tam = aux.length;
    k = 0;
    v = 0;
    if (tam == 1) {
	aux2 = aux.substring(tam - 1, tam);
	if (aux2 == ",") {
	    campo.value = "";
	}
    }
    while (tam > 0) {
	aux2 = aux.substring(tam - 1, tam);
	if (aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3"
		&& aux2 != "4" && aux2 != "," && aux2 != "5" && aux2 != "6"
		&& aux2 != "7" && aux2 != "8" && aux2 != "9") {
	    k = k + 1;
	}
	if (aux2 == ",") {
	    v = v + 1;
	}
	tam--;
    }
    if (k != 0 || v > 1) {
	alert("FORMATO INVALIDO");
	campo.value = "";
	campo.focus();
    }
}

function aspa(campo) {
    aux = campo.value;
    tam = aux.length
    aux2 = aux.substring(tam - 1, tam);
    if (aux2 == "\"" || aux2 == "\'") {
	aux = campo.value;
	aux = aux.length;
	aux = aux - 1;
	pal = campo.value;
	campo.value = pal.substring(0, aux);
    }
}

function aspa2(campo) {
    aux = campo.value;
    tam = aux.length;
    i = 0;
    nova = "";
    while (i != tam) {
	aux2 = aux.substring(i, i + 1);
	if (aux2 == "\"" || aux2 == "\'")
	    nova = nova;
	else
	    nova = nova + aux2;
	i++;

    }
    campo.value = nova;
}
