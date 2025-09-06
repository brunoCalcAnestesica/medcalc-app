function checarMedicacao(nome) {
    
    var AH = null;
    
    switch(nome) {
        case "hidro":
            AH = "Hidroxizina";
            break;
        case "lora":
            AH = "Loratadina";
            break;
        case "deslo":
            AH = "Desloratadina";
            break;
        case "dexclo":
            AH = "Dexclorfeniramina";
            break;
        case "ceti":
            AH = "Cetirizina";
            break;
        case "fexo":
            AH = "Fexofenadina";
            break;
        case "prome":
            AH = "Prometazina";
            break;
    }
    
    return AH;
    
}




function calcularDroga(AH, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, und, intervalo, cuidados;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    
    
    if(AH == "Hidroxizina") {
        
        var apresentacoes = {
            "apresentacao": ["2mg/ml", "25mg"],
            "dosePorMl": [2, 25],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Prurido / Urticária"],
            "dosagem": [0.7],
            "intervaloS": ["8/8 horas"],
            "intervaloN": [3],
            "doseMaxima": [25],
            "diasTratamento": [""]
        };
        var contraindicacoes = ["Anti-histamínico de 1ª geração.", "Anti-histamínico mais seguro para crianças abaixo de 6 meses de vida.", "Principais efeitos adversos: Sedação, Hipotensão.", "Contra-Indicações: Hipersensibilidade e QT Prolongada."];
    
    }
    
    
    if(AH == "Loratadina") {
        
        var apresentacoes = {
            "apresentacao": ["1mg/ml", "10mg"],
            "dosePorMl": [1, 10],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 2 a 6 anos", "Crianças acima de 6 anos"],
            "dosagem": [5, 10],
            "intervaloS": ["24/24 horas", "24/24 horas"],
            "intervaloN": [1, 1],
            "doseMaxima": [5, 10],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Anti-histamínico de 2ª geração.", "Não indicado para crianças menores que 2 anos.", "Não causam sedação e apresentam melhor perfil de segurança.", "Contra-Indicações: Hipersensibilidade."];
    
    }
    
    
    if(AH == "Desloratadina") {
        
        var apresentacoes = {
            "apresentacao": ["0.5mg/ml", "5mg"],
            "dosePorMl": [1, 10],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 6 a 11 meses", "Crianças de 1 a 5 anos", "Crianças de 6 a 11 anos", "Crianças acima de 12 anos"],
            "dosagem": [2, 2.5, 5, 10],
            "intervaloS": ["24/24 horas", "24/24 horas", "24/24 horas", "24/24 horas"],
            "intervaloN": [1, 1, 1, 1],
            "doseMaxima": [2, 2.5, 5, 10],
            "diasTratamento": ["", "", "", ""]
        };
        var contraindicacoes = ["Anti-histamínico de 2ª geração.", "Não indicado para crianças menores que 6 meses.", "Não causam sedação e apresentam melhor perfil de segurança.", "Contra-Indicações: Hipersensibilidade."];
    
    }
    
    
    if(AH == "Cetirizina") {
        
        var apresentacoes = {
            "apresentacao": ["1mg/ml", "10mg"],
            "dosePorMl": [1, 10],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 2 a 5 anos", "Crianças de 6 a 9 anos", "Crianças acima de 10 anos"],
            "dosagem": [2.5, 5, 10],
            "intervaloS": ["12/12 horas", "12/12 horas", "24/24 horas"],
            "intervaloN": [2, 2, 1],
            "doseMaxima": [2.5, 5, 10],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Anti-histamínico de 2ª geração.", "Não indicado para crianças menores que 2 anos.", "Não causam sedação e apresentam melhor perfil de segurança.", "Contra-Indicações: Hipersensibilidade."];
    
    }
    
    
    if(AH == "Dexclorfeniramina") {
        
        var apresentacoes = {
            "apresentacao": ["2mg/5ml", "2mg"],
            "dosePorMl": [1, 5],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 2 a 5 anos", "Crianças de 6 a 11 anos", "Crianças acima de 12 anos"],
            "dosagem": [1.25, 2.5, 5],
            "intervaloS": ["8/8 horas", "8/8 horas", "6/6 ou 8/8 horas"],
            "intervaloN": [3, 3, 3],
            "doseMaxima": [1.25, 2.5, 5],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Anti-histamínico de 1ª geração.", "Não indicado para crianças menores que 2 anos.", "Equivale, também, a associação com Betametasona (Celestamine®).", "Principais efeitos adversos: Sedação, Hipotensão.", "Contra-Indicações: Hipersensibilidade e QT Prolongada."];
    
    }
    
    
    if(AH == "Fexofenadina") {
        
        var apresentacoes = {
            "apresentacao": ["6mg/ml", "120mg"],
            "dosePorMl": [6, 120],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 6 meses a 12 anos", "Crianças acima de 12 anos"],
            "dosagem": [30, 120],
            "intervaloS": ["12/12 horas", "24/24 horas"],
            "intervaloN": [2, 1],
            "doseMaxima": [60, 120],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Anti-histamínico de 2ª geração.", "Não indicado para crianças menores que 6 meses.", "Não causam sedação e apresentam melhor perfil de segurança.", "Contra-Indicações: Hipersensibilidade."];
    
    }
    
    
    if(AH == "Prometazina") {
        
        var apresentacoes = {
            "apresentacao": ["25mg/ml"],
            "dosePorMl": [25],
            "diluicao": [""],
            "viaAdministracao": ["IM"],
            "unidade": ["mL"],
            "cuidados": ["Essa medicação deve ser reservada aos casos de urgência."],
            "pesoUnico": [false]
        };
        var indicacoes = {
            "indicacao": ["Prurido/Urticária"],
            "dosagem": [0.5],
            "intervaloS": ["dose única"],
            "intervaloN": [1],
            "doseMaxima": [50],
            "diasTratamento": [""]
        };
        var contraindicacoes = ["Anti-histamínico de 1ª geração.", "Não indicado para crianças menores que 2 anos.", "Deve ser reservado aos casos de urgência.", "Principais efeitos adversos: Sedação, Hipotensão.", "Contra-Indicações: Hipersensibilidade e QT Prolongada."];
    
    }

    
    //  Processamento das Apresentações e Cálculo de Doses
    for (i = 0; i < Object.keys(apresentacoes["apresentacao"]).length; ++i) {
        
        var1 = apresentacoes["apresentacao"][i];
        
        if(apresentacoes["pesoUnico"][i] == true) {
            
            var2 = (indicacoes["dosagem"][codIndicacao]/apresentacoes["dosePorMl"][i]);
            
        } else {
            
            var2 = (((indicacoes["dosagem"][codIndicacao])*peso)/(apresentacoes["dosePorMl"][i]));
    
            if(var2 > (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])))) {
                var2 = (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])));
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
                if(var2 < 0.98) {
                    var2 = null;
                } else {
                    var2 = Math.round(var2*2)/2;
                    if(var2 <= 1) { und = "comprimido"; }
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
        
        if (indicacoes["diasTratamento"][codIndicacao] == "") { time = ""; } else { time = "durante " + indicacoes["diasTratamento"][codIndicacao] + ", "; }
        
        if(var2 == 0) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AH + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AH + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
        } else {
            returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AH + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em intervalos de ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        /*var2 = (indicacoes["dosagem"][i] * indicacoes["intervaloN"][i]);*/
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + AH + "', " + peso + ", " + i + ");";
        
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '</a></li>';
        /*returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '<span>' + var2 + 'mg/kg/dia</span></a></li>';*/
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}