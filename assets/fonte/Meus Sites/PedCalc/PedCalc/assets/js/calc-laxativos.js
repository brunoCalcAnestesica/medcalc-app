function checarMedicacao(nome) {
    
    var LX = null;
    
    switch(nome) {
        case "oleo":
            LX = "Óleo Mineral";
            break;
        case "lact":
            LX = "Lactulose";
            break;
        case "hidro":
            LX = "Hidróxido de Magnésio";
            break;
    }
    
    return LX;
    
}



function calcularDroga(LX, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, cuidados, time, und;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    var varX = 0;
    
    
    if(LX == "Óleo Mineral") {
    
        var apresentacoes = {
            "apresentacao": ["100%"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-SO"],
            "unidade": ["mL"],
            "cuidados": ["A posologia deve ser ajustada para que se obtenham duas ou três evacuações por dia."]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 6 a 11 anos", "Crianças acima de 12 anos"],
            "dosagemMin": [5, 15],
            "dosagemMax": [5, 15],
            "intervaloS": ["uma vez ao dia (preferencialmente à noite)", "uma vez ao dia (preferencialmente à noite)"],
            "intervaloN": [1, 1],
            "doseMaxima": [15, 15],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 6 anos de idade.", "Seu uso não deve ser superior a 1 semana."];
        
    }
    
    if(LX == "Lactulose") {
    
        var apresentacoes = {
            "apresentacao": ["667mg/mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-SO"],
            "unidade": ["mL"],
            "cuidados": ["A posologia deve ser ajustada para que se obtenham duas ou três evacuações por dia."]
        };
        var indicacoes = {
            "indicacao": ["Lactentes", "Crianças de 1 a 6 anos", "Crianças de 6 a 12 anos", "Crianças acima de 12 anos"],
            "dosagemMin": [5, 5, 10, 15],
            "dosagemMax": [5, 5, 10, 15],
            "intervaloS": ["uma vez ao dia", "uma vez ao dia", "uma vez ao dia", "uma vez ao dia"],
            "intervaloN": [1, 1, 1, 1],
            "doseMaxima": [15, 15, 15, 15],
            "diasTratamento": ["", "", "", ""]
        };
        var contraindicacoes = ["Preferencialmente, deve ser administrada em uma única tomada pela manhã ou à noite, sozinho ou misturado com qualquer líquido (ex. suco, leite ou iogurte)."];
        
    }
    
    if(LX == "Hidróxido de Magnésio") {
    
        var apresentacoes = {
            "apresentacao": ["90mg/mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-SO"],
            "unidade": ["mL"],
            "cuidados": ["A posologia deve ser ajustada para que se obtenham duas ou três evacuações por dia."]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 2 a 6 anos", "Crianças de 6 a 12 anos", "Crianças acima de 12 anos"],
            "dosagemMin": [5, 15, 30],
            "dosagemMax": [5, 15, 30],
            "intervaloS": ["uma vez ao dia", "uma vez ao dia", "uma vez ao dia", "uma vez ao dia"],
            "intervaloN": [1, 1, 1, 1],
            "doseMaxima": [15, 15, 30],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 2 anos de idade.", "Seu uso não deve ser superior a 1 semana."];
        
    }
    
    
    //  Processamento das Apresentações e Cálculo de Doses
    for (i = 0; i < Object.keys(apresentacoes["apresentacao"]).length; ++i) {
        var1 = apresentacoes["apresentacao"][i];
        
            if(indicacoes["dosagemMin"][codIndicacao] == indicacoes["dosagemMax"][codIndicacao]) {
            
                var2 = (((indicacoes["dosagemMin"][codIndicacao])*peso)/(apresentacoes["dosePorMl"][i]));
                if(var2 > (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])))) {
                    var2 = (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])));
                }
                
            } else {
                
                var2 = (((indicacoes["dosagemMin"][codIndicacao])*peso)/(apresentacoes["dosePorMl"][i]));
                if(var2 > (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])))) {
                    var2 = (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])));
                } else {
                    varX = (((indicacoes["dosagemMax"][codIndicacao])*peso)/(apresentacoes["dosePorMl"][i]));
                    if(varX > (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])))) {
                        varX = (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])));
                    }
                }
                
            }
        
        var3 = indicacoes["intervaloS"][codIndicacao];
        var4 = apresentacoes["viaAdministracao"][i];
        var5 = indicacoes["diasTratamento"][codIndicacao];
        cuidados = apresentacoes["cuidados"][i];
        und = apresentacoes["unidade"][i];
           
        switch(var4) {
            case "VO":
                var6 = "pills";
                if(var2 >= 0.95 && var2 <= 1.04) {
                    var2 = 1;
                    und = "comprimido";
                } else if(var2 >= 1.92 && var2 <= 2.08) {
                    var2 = 2;
                    und = "comprimidos";
                } else {
                    var2 = null;
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
            case "IMV":
                var6 = "syringe";
                var2 = Number((var2).toFixed(1));
                var4 = "via IM ou IV";
                break;
        }
                
        if (apresentacoes["diluicao"][i] == "") { adm = ""; } else { adm = apresentacoes["diluicao"][i] + " e administrar "; }
        
        if (indicacoes["diasTratamento"][codIndicacao] == "") { time = ""; } else { time = "durante " + indicacoes["diasTratamento"][codIndicacao] + ", "; }
        
        if(var2 == 0) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + LX + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + LX + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
        } else {
            if (var3 == "") {
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + LX + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em dose única, ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
            } else {
                
                if(LX == "Óleo Mineral" && codIndicacao == 0) { var2 = var2 + " a 15"; }
                if(LX == "Óleo Mineral" && codIndicacao == 1) { var2 = var2 + " a 45"; }
                
                if(LX == "Lactulose" && codIndicacao == 1) { var2 = var2 + " a 10"; }
                if(LX == "Lactulose" && codIndicacao == 2) { var2 = var2 + " a 15"; }
                if(LX == "Lactulose" && codIndicacao == 3) { var2 = var2 + " a 30"; }
                
                if(LX == "Hidróxido de Magnésio" && codIndicacao == 0) { var2 = var2 + " a 15"; }
                if(LX == "Hidróxido de Magnésio" && codIndicacao == 1) { var2 = var2 + " a 30"; }
                if(LX == "Hidróxido de Magnésio" && codIndicacao == 2) { var2 = var2 + " a 60"; }
                
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + LX + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
            }
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        
        /*if(indicacoes["dosagemMin"][i] == indicacoes["dosagemMax"][i]) {
            var6 = Math.round(indicacoes["dosagemMin"][i]*indicacoes["intervaloN"][i]) + " mg/kg/dia";    
        } else {
            var6 = (indicacoes["dosagemMin"][i]*indicacoes["intervaloN"][i]) + " a " + (indicacoes["dosagemMax"][i]*indicacoes["intervaloN"][i]) + " mg/kg/dia";
        }*/
        
        
        if(LX == "Óleo Mineral" || LX == "Lactulose" || LX == "Hidróxido de Magnésio") {
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + LX + "', " + peso + ", " + i + ");";
        
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '</a></li>';
        
        } else {
        
        returnIndicacoes = returnIndicacoes + '<li><a href="javascript:void(0);" style="cursor: default;">' + var1 + '</a></li>';
            
        }
        
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}