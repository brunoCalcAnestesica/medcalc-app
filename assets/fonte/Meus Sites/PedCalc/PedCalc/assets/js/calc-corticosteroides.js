function checarMedicacao(nome) {
    
    var CT = null;
    
    switch(nome) {
        case "hidro":
            CT = "Hidrocortisona";
            break;
        case "dexa":
            CT = "Dexametasona";
            break;
        case "pred":
            CT = "Prednisolona";
            break;
        case "metil":
            CT = "Metil-Prednisolona";
            break;
        case "beta":
            CT = "Betametasona";
            break;
    }
    
    return CT;
    
}




function calcularDroga(CT, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, und, intervalo, cuidados; 
    var varX = null;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    
    
    if(CT == "Hidrocortisona") {
        
        var apresentacoes = {
            "apresentacao": ["100mg", "500mg"],
            "dosePorMl": [50, 100],
            "diluicao": ["Diluir 1 FA em 2 mL de ABD", "Diluir 1 FA em 5 mL de ABD"],
            "viaAdministracao": ["IV", "IV"],
            "unidade": ["mL", "mL"],
            "tipo": ["URG", "URG"],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Anti-Inflamatório", "Asma Grave", "Hipoglicemia Neonatal"],
            "dosagemMin": [0.50, 2, 1],
            "dosagemMax": [2.00, 4, 2],
            "intervaloS": ["em intervalos de 6/6 horas", "podendo repetir em intervalos de 6/6 horas", "em intervalos de 6/6 horas"],
            "intervaloN": [4, 4, 4],
            "doseMaxima": [500, 500, 500],
            "tipo": ["URG", "URG", "URG"],
            "cuidados": ["", "", ""],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em infecções não-tratadas (exceto na tuberculose meníngea e choque séptico), principalmente as infecções fúngicas sistêmicas.", "Na Púrpura Trombocitopênica Idiopática, preferir por aqueles administrado via IM."];
    
    }
    
    
    if(CT == "Dexametasona") {
        
        var apresentacoes = {
            "apresentacao": ["0.5mg/5mL", "2mg/mL", "10mg/2.5mL"],
            "dosePorMl": [0.1, 2, 4],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-SO", "IMV", "IMV"],
            "unidade": ["mL", "mL", "mL"],
            "tipo": ["AMB", "URG", "URG"],
            "pesoUnico": [false, false, false]
        };
        var indicacoes = {
            "indicacao": ["Anti-Inflamatório", "Laringotrqueobronquite Aguda", "Edema Cerebral", "Meningite"],
            "dosagemMin": [0.01, 0.01, 1, 0.15],
            "dosagemMax": [0.15, 0.15, 2, 0.15],
            "intervaloS": ["em intervalos de 12/12 horas", "em intervalos de 12/12 horas", "em dose única", "em intervalos de 6/6 horas"],
            "intervaloN": [2, 2, 1, 4],
            "doseMaxima": [16, 16, 16, 16],
            "tipo": ["AMB/URG", "AMB/URG", "URG", "URG"],
            "cuidados": ["", "", "", "Iniciar 10 a 20 minutos antes da antibioticoterapia e manter por 2 a 5 dias."],
            "diasTratamento": ["", "", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em infecções não-tratadas (exceto na tuberculose meníngea e choque séptico), principalmente as infecções fúngicas sistêmicas."];
    
    }
    
    
    if(CT == "Prednisolona") {
        
        var apresentacoes = {
            "apresentacao": ["15mg/5mL", "20mg"],
            "dosePorMl": [3, 20],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "tipo": ["AMB", "AMB"],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Anti-Inflamatório", "Asma Grave"],
            "dosagemMin": [1, 1],
            "dosagemMax": [2, 2],
            "intervaloS": ["em intervalos de 24/24 horas, preferencialmente pela manhã", "em intervalos de 24/24 horas, preferencialmente pela manhã"],
            "intervaloN": [1, 1],
            "doseMaxima": [60, 40],
            "tipo": ["AMB", "AMB"],
            "cuidados": ["", ""],
            "diasTratamento": ["", "3 a 5 dias"]
        };
        var contraindicacoes = ["Contra-indicado em infecções não-tratadas (exceto na tuberculose meníngea e choque séptico), principalmente as infecções fúngicas sistêmicas."];
    
    }
    
    
    if(CT == "Metil-Prednisolona") {
        
        var apresentacoes = {
            "apresentacao": ["125mg", "500mg"],
            "dosePorMl": [62.5, 62.5],
            "diluicao": ["Diluir 1 FA em 2 mL de diluente próprio", "Diluir 1 FA em 8 mL de diluente próprio"],
            "viaAdministracao": ["IMV", "IMV"],
            "unidade": ["mL", "mL"],
            "tipo": ["URG", "URG"],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Anti-Inflamatório", "Asma Grave"],
            "dosagemMin": [0.25, 1],
            "dosagemMax": [0.85, 2.5],
            "intervaloS": ["em intervalos de 12/12 horas", "em intervalos de 6/6 horas"],
            "intervaloN": [2, 4],
            "doseMaxima": [500, 500],
            "tipo": ["URG", "URG"],
            "cuidados": ["", ""],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em infecções não-tratadas (exceto na tuberculose meníngea e choque séptico), principalmente as infecções fúngicas sistêmicas."];
    
    }
    
    
    if(CT == "Betametasona") {
        
        var apresentacoes = {
            "apresentacao": ["0.1mg/mL", "0.5mg/mL"],
            "dosePorMl": [0.1, 0.02],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO-GT"],
            "unidade": ["mL", "gotas"],
            "tipo": ["AMB", "AMB"],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Anti-Inflamatório"],
            "dosagemMin": [0.02],
            "dosagemMax": [0.25],
            "intervaloS": ["em intervalos de 24/24 horas, preferencialmente pela manhã"],
            "intervaloN": [1],
            "doseMaxima": [8],
            "tipo": ["AMB"],
            "cuidados": [""],
            "diasTratamento": [""]
        };
        var contraindicacoes = ["Contra-indicado em infecções não-tratadas (exceto na tuberculose meníngea e choque séptico), principalmente as infecções fúngicas sistêmicas."];
    
    }

    
    //  Processamento das Apresentações e Cálculo de Doses
    for (i = 0; i < Object.keys(apresentacoes["apresentacao"]).length; ++i) {
        
        if(indicacoes["tipo"][codIndicacao] == apresentacoes["tipo"][i] || indicacoes["tipo"][codIndicacao] == "AMB/URG") {
        
        var1 = apresentacoes["apresentacao"][i];
        
        if(apresentacoes["pesoUnico"][i] == true) {
            
            var2 = (indicacoes["dosagemMin"][codIndicacao]/apresentacoes["dosePorMl"][i]);
            
        } else {
            
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
            
        }
           
        var3 = indicacoes["intervaloS"][codIndicacao];
        var4 = apresentacoes["viaAdministracao"][i];
        var5 = indicacoes["diasTratamento"][codIndicacao];
        cuidados = indicacoes["cuidados"][codIndicacao];
        und = apresentacoes["unidade"][i];
        
        switch(var4) {
            case "VO":
                var6 = "pills";
                if ((var2 - (Math.floor(var2*2)/2)) >= 0.12) { 
                    var2 = null; 
                } else {
                    var2 = Math.floor(var2*2)/2;
                        if(var2 <= 1) { und = "comprimido"; }
                        if(var2 == 0.5) { var2 = "1/2"; } 
                        if(varX != null) { varX = Math.floor(varX*2)/2; }
                }
                var4 = "via oral";
                break;
            case "VO-SO":
                var6 = "prescription-bottle";
                var2 = Math.round(var2);
                if(var2 != null) { varX = Math.round(varX); }
                var4 = "via oral";
                break;
            case "VO-GT":
                var6 = "tint";
                var2 = Math.round(var2);
                if(var2 != null) { varX = Math.round(varX); }
                var4 = "via oral";
                break;
            case "IV":
                var6 = "syringe";
                var2 = Number((var2).toFixed(1));
                if(varX != null) { varX = Number((varX).toFixed(1)); }
                var4 = "via IV";
                break;
            case "IM":
                var6 = "syringe";
                var2 = Number((var2).toFixed(1));
                if(varX != null) { varX = Number((varX).toFixed(1)); }
                var4 = "via IM";
                break;
            case "IMV":
                var6 = "syringe";
                    var2 = Number((var2).toFixed(1));
                    if(varX != null) { varX = Number((varX).toFixed(1)); }
                var4 = "via IM ou IV";
                break;
        }
        
        if (indicacoes["diasTratamento"][codIndicacao] == "") { time = ""; } else { time = "durante " + indicacoes["diasTratamento"][codIndicacao] + ", "; }
            
            
        // PECULARIEDADES
        if(CT == "Dexametasona" && codIndicacao == 1) {
            
            var2 = var2 + " a " + varX;
            
            var DoseManutencao1 = Number(((0.25 * peso)/(apresentacoes["dosePorMl"][i]))).toFixed(1);
            var DoseManutencao2 = Number(((0.75 * peso)/(apresentacoes["dosePorMl"][i]))).toFixed(1);
            
            if(DoseManutencao1 > 16) {
                // Postar so um
                cuidados = "Seguir com dose de manutenção de " + DoseManutencao1 + " mL, de 6/6 horas.";
            } else {
                // Postar os dois
                if(0.75 * peso > 16) { DoseManutencao2 = (16 * apresentacoes["dosePorMl"][i]); }
                cuidados = "Seguir com dose de manutenção de " + DoseManutencao1 + " a " + DoseManutencao2 + " mL, de 6/6 horas."
            }
            
            varX = null;
            
        }
            
        
        if(var2 == 0) {
            if(varX != null && varX >= 0.1) {
                
                if (apresentacoes["diluicao"][i] == "") { 
                    adm = adm = "Fazer até ";
                } else { 
                    adm = apresentacoes["diluicao"][i] + " e fazer até "; 
                }
                
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + CT + ' ' + var1 + '</span> - ' + adm  + varX + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
            } else {
                returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + CT + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
            }
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + CT + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
        } else {
            
            if(varX == null) {
                
                if (apresentacoes["diluicao"][i] == "") { 
                    adm = ""; 
                } else { 
                    adm = apresentacoes["diluicao"][i] + " e administrar "; 
                }
                
                // Apresentacao Normal
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + CT + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
                
            } else {
                
                if (apresentacoes["diluicao"][i] == "") { 
                    adm = adm = "Iniciar com ";
                } else { 
                    adm = apresentacoes["diluicao"][i] + " e iniciar com "; 
                }
                
                // Apresentacao com duas doses
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + CT + ' ' + var1 + '</span> - ' + adm  + var2 + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. A dose pode ser aumentada até ' + varX + ' ' + und + ', a depender da gravidade e resposta do paciente. ' + cuidados + '</p></li>';
                
                
            }
        }
            
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        
        if(indicacoes["dosagemMin"][i] == indicacoes["dosagemMax"][i]) {
            var6 = (indicacoes["dosagemMin"][i]*indicacoes["intervaloN"][i]) + " mg/kg/dia";    
        } else {
            var6 = (indicacoes["dosagemMin"][i]*indicacoes["intervaloN"][i]) + " a " + (indicacoes["dosagemMax"][i]*indicacoes["intervaloN"][i]) + " mg/kg/dia";
        }
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + CT + "', " + peso + ", " + i + ");";
        
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '<span>' + var6 + '</span></a></li>';
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}