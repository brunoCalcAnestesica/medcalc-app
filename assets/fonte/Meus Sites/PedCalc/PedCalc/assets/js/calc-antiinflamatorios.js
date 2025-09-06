function checarMedicacao(nome) {
    
    var AI = null;
    
    switch(nome) {
        case "aas":
            AI = "Ácido Acetilsalicílico";
            break;
        case "ceto":
            AI = "Cetoprofeno";
            break;
        case "dicl":
            AI = "Diclofenaco";
            break;
        case "ibup":
            AI = "Ibuprofeno";
            break;
        case "nap":
            AI = "Naproxeno";
            break;
        case "nim":
            AI = "Nimesulida";
            break;
    }
    
    return AI;
    
}




function calcularDroga(AI, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, und, intervalo, cuidados;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    
    
    if(AI == "Ácido Acetilsalicílico") {
        
        var apresentacoes = {
            "apresentacao": ["100mg"],
            "dosePorMl": [100],
            "diluicao": [""],
            "viaAdministracao": ["VO"],
            "unidade": ["comprimidos"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Anti-Pirético", "Anti-Inflamatório"],
            "dosagem": [15, 15, 15],
            "intervaloS": ["6/6 horas", "6/6 horas", "6/6 horas"],
            "intervaloN": [4, 4, 4],
            "doseMaxima": [1000, 1000, 1000],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 6 meses de vida.", "Seu uso deve ser consciente pela alta toxicidade dessas medicações.", "Atentar para o risco de dispepsias e alergia medicamentosa."];
    
    }
    
    if(AI == "Cetoprofeno") {
        
        var apresentacoes = {
            "apresentacao": ["20mg/mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-GT"],
            "unidade": ["gotas"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Anti-Pirético", "Anti-Inflamatório"],
            "dosagem": [1, 1, 1],
            "intervaloS": ["6/6 ou 8/8 horas", "6/6 ou 8/8 horas", "6/6 ou 8/8 horas"],
            "intervaloN": [4, 4, 4],
            "doseMaxima": [50, 50, 50],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Seu uso deve ser consciente pela alta toxicidade dessas medicações.", "Atentar para o risco de dispepsias e alergia medicamentosa."];
    
    }

    if(AI == "Diclofenaco") {
        
        var apresentacoes = {
            "apresentacao": ["15mg/mL", "50mg", "25mg/mL"],
            "dosePorMl": [1, 50, 25],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-GT", "VO", "IM"],
            "unidade": ["gotas", "comprimidos", "mL"],
            "cuidados": ["", "", ""]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Anti-Pirético", "Anti-Inflamatório"],
            "dosagem": [1, 1, 1],
            "intervaloS": ["12/12 horas", "12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2, 2],
            "doseMaxima": [75, 75, 75],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 6 meses de vida.", "Seu uso deve ser consciente pela alta toxicidade dessas medicações.", "Atentar para o risco de dispepsias e alergia medicamentosa."];
    
    }
    
    if(AI == "Ibuprofeno") {
        
        var apresentacoes = {
            "apresentacao": ["100mg/mL", "300mg"],
            "dosePorMl": [10, 300],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-GT", "VO"],
            "unidade": ["gotas", "comprimidos"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Anti-Pirético", "Anti-Inflamatório"],
            "dosagem": [10, 10, 10],
            "intervaloS": ["8/8 horas", "8/8 horas", "8/8 horas"],
            "intervaloN": [3, 3, 3],
            "doseMaxima": [600, 600, 600],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Seu uso deve ser consciente pela alta toxicidade dessas medicações.", "Atentar para o risco de dispepsias e alergia medicamentosa."];
    
    }
    
    if(AI == "Naproxeno") {
        
        var apresentacoes = {
            "apresentacao": ["250mg", "500mg"],
            "dosePorMl": [250, 500],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO", "VO"],
            "unidade": ["comprimidos", "comprimidos"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Anti-Pirético", "Anti-Inflamatório"],
            "dosagem": [7, 7, 7],
            "intervaloS": ["12/12 horas", "12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2, 2],
            "doseMaxima": [500, 500, 500],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 2 anos de idade.", "Seu uso deve ser consciente pela alta toxicidade dessas medicações.", "Atentar para o risco de dispepsias e alergia medicamentosa."];
    
    }
    
    if(AI == "Nimesulida") {
        
        var apresentacoes = {
            "apresentacao": ["50mg/mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-GT"],
            "unidade": ["gotas"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Anti-Pirético", "Anti-Inflamatório"],
            "dosagem": [1, 1, 1],
            "intervaloS": ["12/12 horas", "12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2, 2],
            "doseMaxima": [50, 50, 50],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 12 anos de idade.", "Seu uso deve ser consciente pela alta toxicidade dessas medicações.", "Atentar para o risco de dispepsias e alergia medicamentosa."];
    
    }
    
    //  Processamento das Apresentações e Cálculo de Doses
    for (i = 0; i < Object.keys(apresentacoes["apresentacao"]).length; ++i) {
        
        var1 = apresentacoes["apresentacao"][i];
            
            var2 = (((indicacoes["dosagem"][codIndicacao])*peso)/(apresentacoes["dosePorMl"][i]));
    
            if(var2 > (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])))) {
                var2 = (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])));
            }
           
        var3 = indicacoes["intervaloS"][codIndicacao];
        var4 = apresentacoes["viaAdministracao"][i];
        var5 = indicacoes["diasTratamento"][codIndicacao];
        cuidados = apresentacoes["cuidados"][i];
        und = apresentacoes["unidade"][i];
        
        switch(var4) {
            case "VO":
                var6 = "pills";
                    
                    if(var2 < 0.98) {
                        var2 = null;
                    } else if ( (var2 - (Math.floor(var2, 1)) >= 0) && (var2 - (Math.floor(var2, 1)) <= 0.2) ) {
                        var2 = (Math.floor(var2, 1));
                        if(var2 == 1) { und = "comprimido"; } else { und = "comprimidos"; }
                    } else if ( (var2 - (Math.floor(var2, 1)) >= 0.8) && (var2 - (Math.floor(var2, 1)) < 1) ) {
                        var2 = (Math.floor(var2, 1)) + 1;
                        if(var2 == 1) { und = "comprimido"; } else { und = "comprimidos"; }
                    } else {
                        var2 = (Math.floor(var2, 1));
                        if(var2 == 1) { und = "comprimido"; } else { und = "comprimidos"; }
                    }
                
                var4 = "via oral";
                break;
            case "VO-SO":
                var6 = "prescription-bottle";
                var2 = Math.round(var2*2)/2;
                var4 = "via oral";
                break;
            case "VO-GT":
                var6 = "tint";
                var2 = Math.round(var2);
                var4 = "via oral";
                break;
            case "IV":
                var6 = "syringe";
                var2 = Number((var2).toFixed(1));
                var4 = "via IV";
                break;
            case "IM":
                var6 = "syringe";
                var2 = Number((var2).toFixed(1));
                var4 = "via IM";
                break;
        }
        
        if (apresentacoes["diluicao"][i] == "") { adm = ""; } else { adm = apresentacoes["diluicao"][i] + " e administrar "; }
        
        if (indicacoes["diasTratamento"][codIndicacao] == "") { time = ""; } else { time = "" + indicacoes["diasTratamento"][codIndicacao] + ", "; }
        
        //Peso Mínimo
        
        if(var2 == 0) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AI + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AI + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pela sub-dose ou super-dose.</p></li>';
        } else {
            returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AI + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em intervalos de até ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        /*var2 = (indicacoes["dosagem"][i] * indicacoes["intervaloN"][i]);*/
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + AI + "', " + peso + ", " + i + ");";
        
        returnIndicacoes = returnIndicacoes + '<li><a href="javascript:false;" style="cursor: default">' + var1 + '</a></li>';
        /*returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '<span>' + var2 + 'mg/kg/dia</span></a></li>';*/
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}