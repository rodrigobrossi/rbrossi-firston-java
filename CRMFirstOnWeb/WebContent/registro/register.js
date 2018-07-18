function cancelar() {
    window.open("frame_principal.jsp", "_parent");
}

function atualiza() {
    aux = frm.txtcustocurso.value;
    tam = aux.length;
    var nova = "";
    for (i = 0; i < tam; i++) {
	aux2 = aux.charAt(i);
	if (aux2 == ",") {
	    aux2 = ".";
	    nova = nova + aux2;
	} else if (aux2 == ".") {
	    nova = nova;
	} else {
	    nova = nova + aux2;
	}
    }
    var c1 = nova;

    aux = frm.txtcustolog.value;
    tam = aux.length;
    nova = "";
    for (i = 0; i < tam; i++) {
	aux2 = aux.charAt(i);
	if (aux2 == ",") {
	    aux2 = ".";
	    nova = nova + aux2;
	} else if (aux2 == ".") {
	    nova = nova;
	} else {
	    nova = nova + aux2;
	}
    }
    var c2 = nova;
    var total = eval(c1 + "+" + c2);

    frm.txtcustoreal.value = total;
    aux = frm.txtcustoreal.value;
    tam = aux.length;
    nova = "";
    for (i = 0; i < tam; i++) {
	aux2 = aux.charAt(i);
	if (aux2 == ".") {
	    aux2 = ",";
	    nova = nova + aux2 + aux.charAt(i + 1) + aux.charAt(i + 2);
	    i = tam;
	} else {
	    nova = nova + aux2;
	}
    }

    frm.txtcustoreal.value = nova;

}

function duracao(campo){
	aux = campo.value;
	tam = aux.length
	aux2 = aux.substring(tam-1,tam);
	if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
	   aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
		aux = campo.value;
		aux = aux.length;
		aux = aux - 1;
		pal = campo.value;
		campo.value = pal.substring(0, aux);
	}

}

function duracao2(campo){
	atualiza();
	aux = campo.value;
	tam = aux.length;
	i = 0;
	nova = "";
	while(i != tam){
		aux2 = aux.substring(i,i+1);
		if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
	   		aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
			nova = nova;
		}
		else{
			nova = nova + aux2;
		}
		i++;
		
	}
	campo.value = nova;
}