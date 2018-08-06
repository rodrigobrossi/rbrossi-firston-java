<!--

function FormataCampo(campo, evento, direcao){
	if (campo.value.length < 1000000){
			if(evento != 9 ){// tab
				if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ // delete,
														    // backspace,
														    // shift
														    // n�o
														    // causam
														    // evento
					var tam = campo.value.length
					if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)){
						if (tam == 2 || tam == 5){
							campo.value = campo.value + "";
							}
						}
						else{
							if (direcao == "up"){
								if (campo.value.length == 0) {
									campo.value = ""
									}
								else{
									campo.value = "";// campo.value.substring(0,campo.value.length-1)
									}
								}
							}
						campo.focus()
						}
					} 
					else{
						if (direcao == "down"){
							var teste = campo.value.substring(0,1);
							if(campo.value<0){
								alert("<%=("+trd.Traduz("Este campo não aceita valores negativos !")+")%>");
								campo.value="";
								campo.focus();
								return false;
								}
							else if(teste=="-"||teste=="+"||teste=="~"||teste=="^"||
								   teste=="\""||teste=="'"||teste=="!"||teste=="@"||
								   teste=="#"||teste=="$"||teste=="%"||teste=="�"||
								   teste=="&"||teste=="*"||teste=="("||teste==")"||
								   teste=="_"||teste=="="||teste=="~"||teste=="`"||
								   teste=="�"||teste=="{"||teste=="["||teste=="}"||
								   teste=="]"||teste=="<"||teste==","||teste=="."||
								   teste==">"||teste==":"||teste==";"||teste=="/"||
								   teste=="?"||teste=="|"||teste=="\\"||teste=="^"){
								alert("<%="+trd.Traduz("Este campo noa aceita caracteres especiais !")+")%>");
								campo.value="";
								campo.focus();
								return false;
								  }
						}
					}
				}
		}// -->
