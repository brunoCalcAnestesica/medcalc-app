function checarMedicacao(nome) {
    
    var AF = null;
    
    switch(nome) {
        case "ceto":
            AF = "Cetoconazol";
            break;
        case "gri":
            AF = "Griseofulvina";
            break;
        case "nist":
            AF = "Nistatina";
            break;
        case "terb":
            AF = "Terbinafina";
            break;
        case "fluc":
            AF = "Fluconazol";
            break;
        case "anf":
            AF = "Anfotericina B";
            break;
    }
    
    return AF;
    
}




function calcularDroga(AF, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, und, intervalo, cuidados; 
    var varX = null;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    
    
    if(AF == "Cetoconazol") {
        
        var apresentacoes = {
            "apresentacao": ["200mg"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO"],
            "unidade": ["comprimido"],
            "tipo": ["AMB"],
            "pesoUnico": [true]
        };
        var indicacoes = {
            "indicacao": ["Peso até 20 kg", "Peso entre 20 e 40 kg", "Peso acima de 40 kg"],
            "dosagemMin": [0.25, 0.5, 1],
            "dosagemMax": [0.25, 0.5, 1],
            "intervaloS": ["em intervalos de 24/24 horas", "em intervalos de 24/24 horas", "em intervalos de 24/24 horas"],
            "intervaloN": [1, 1, 1],
            "doseMaxima": [200, 200, 200],
            "tipo": ["AMB", "AMB", "AMB"],
            "cuidados": ["", "", ""],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 2 anos de idade e com peso inferior a 15 kg.", "O tratamento deve ser imediatamente suspenso no aparecimento de qualquer sinal sugestivo de hepatite."];
    
    }
    
    if(AF == "Griseofulvina") {
        
        var apresentacoes = {
            "apresentacao": ["200mg/5mL (MANIPULAÇÃO)", "500mg"],
            "dosePorMl": [40, 500],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimido"],
            "tipo": ["AMB", "AMB"],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Tinea Capitis"],
            "dosagemMin": [15],
            "dosagemMax": [15],
            "intervaloS": ["de 24/24 horas"],
            "intervaloN": [1],
            "doseMaxima": [500],
            "tipo": ["AMB"],
            "cuidados": ["Administrar após as refeições."],
            "diasTratamento": [""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 2 anos de idade.", "Realizar controle de TGO/TGP, se possível."];
    
    }
    
    if(AF == "Nistatina") {
        
        var apresentacoes = {
            "apresentacao": ["100.000 UI"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-SO"],
            "unidade": ["mL"],
            "tipo": ["AMB"],
            "pesoUnico": [true]
        };
        var indicacoes = {
            "indicacao": ["Prematuros", "Lactentes", "Crianças"],
            "dosagemMin": [1, 2, 2, 6],
            "dosagemMax": [1, 2, 6, 6],
            "intervaloS": ["em intervalos de 6/6 horas", "em intervalos de 6/6 horas", "em intervalos de 6/6 horas", "em intervalos de 6/6 horas"],
            "intervaloN": [4, 4, 4, 4],
            "doseMaxima": [5000, 5000, 5000, 5000],
            "tipo": ["AMB", "AMB", "AMB", "AMB"],
            "cuidados": ["", "", "", ""],
            "diasTratamento": ["até melhora da sintomatologia", "até melhora da sintomatologia", "até melhora da sintomatologia", "até melhora da sintomatologia"]
        };
        var contraindicacoes = ["Apresentando alta segurança em seu uso, para qualquer idade, pela sua baixa toxicidade.", "A medicação deve ser fracionada e colocada metade em cada canto da boca.", "A depender da idade da criança, deve ser orientada a bochechar e reter pelo máximo de tempo possível antes da deglutição."];
    
    }
    
    if(AF == "Terbinafina") {
        
        var apresentacoes = {
            "apresentacao": ["125mg", "250mg"],
            "dosePorMl": [1, 0.5],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO", "VO"],
            "unidade": ["comprimidos", "comprimidos"],
            "tipo": ["AMB", "URG"],
            "pesoUnico": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Peso menor que 20 kg", "Peso entre 20 e 40 kg", "Peso maior que 40 kg"],
            "dosagemMin": [0.5, 1, 2],
            "dosagemMax": [0.5, 1, 2],
            "intervaloS": ["em intervalos de 24/24 horas", "em intervalos de 24/24 horas", "em intervalos de 24/24 horas"],
            "intervaloN": [1, 1, 1],
            "doseMaxima": [1, 1, 2],
            "tipo": ["AMB", "AMB", "AMB/URG"],
            "cuidados": ["", "", ""],
            "diasTratamento": ["durante 2 a 6 semanas", "durante 2 a 6 semanas", "durante 2 a 6 semanas"]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 2 anos de idade."];
    
    }
    
    if(AF == "Fluconazol") {
        
        var apresentacoes = {
            "apresentacao": ["150mg", "200mg/100mL"],
            "dosePorMl": [150, 2],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO", "IV"],
            "unidade": ["comprimidos", "mL"],
            "tipo": ["AMB", "URG"],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Candidíase", "Sepse Neonatal"],
            "dosagemMin": [6, 12],
            "dosagemMax": [6, 12],
            "intervaloS": ["em dose única", "em intervalos de 24/24 horas"],
            "intervaloN": [1, 1],
            "doseMaxima": [150, 10000],
            "tipo": ["AMB", "URG"],
            "cuidados": ["", "Quando necessário, deve ser feita o regime de manutenção com metade da dose de ataque e mesma posologia."],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 6 meses de vida.", "A terapia oral e intravenosa são equivalentes na dosagem, não necessitando reajustar a dose quando houver necessidade de troca."];
    
    }
    
    if(AF == "Anfotericina B") {
        
        var apresentacoes = {
            "apresentacao": ["Desoxicolato 50mg", "Lipossomal 50mg"],
            "dosePorMl": [5, 4],
            "diluicao": ["Diluir 1 FA em 10 mL de ABD (concentração de 5mg/mL)", "Diluir 1 FA em 12 mL de ABD (concentração de 4mg/mL)"],
            "viaAdministracao": ["IV", "IV"],
            "unidade": ["mL", "mL"],
            "tipo": ["AMB", "URG"],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Anfotericina B Desoxicolato", "Anfotericina B Lipossomal"],
            "dosagemMin": [0.3, 3],
            "dosagemMax": [1.5, 5],
            "intervaloS": ["em intervalos de 24/24 horas", "em intervalos de 24/24 horas"],
            "intervaloN": [1, 1],
            "doseMaxima": [200, 10000],
            "tipo": ["AMB", "URG"],
            "cuidados": ["O volume deve ser restituido em 500mL de SG 5% e infudido por 2 a 6 horas.", "O volume deve ser restituido em 100mL de SG 5% e infundido por 30 a 60 minutos."],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["A Anfotericina B Lipossomal apresenta melhor perfil de segurança."];
    
    }

    
    //  Processamento das Apresentações e Cálculo de Doses
    for (i = 0; i < Object.keys(apresentacoes["apresentacao"]).length; ++i) {
        
        if(indicacoes["tipo"][codIndicacao] == apresentacoes["tipo"][i] || indicacoes["tipo"][codIndicacao] == "AMB/URG") {
        
        var1 = apresentacoes["apresentacao"][i];
        
        if(apresentacoes["pesoUnico"][i] == true) {
            
            var2 = (indicacoes["dosagemMin"][codIndicacao] * apresentacoes["dosePorMl"][i]);
            
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
                    if(AF == "Cetoconazol" && codIndicacao == 0) { var2 = "1/4"; } 
                } else {
                    var2 = Math.floor(var2*2)/2;
                        if(var2 <= 1) { und = "comprimido"; }
                        if(var2 == 0.5) { var2 = "1/2"; } 
                        if(varX != null) { varX = Math.floor(varX*2)/2; }
                        if(AF == "Fluconazol" && var2 == "1/2") { var2 = null; }
                }
                var4 = "via oral";
                break;
            case "VO-SO":
                var6 = "prescription-bottle";
                var2 = Math.round(var2);
                //if(var2 != null) { varX = Math.round(varX); }
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
            
        if(AF == "Griseofulvina") { if(peso >= 20 && peso < 45) { var2 = "1/2"; } }
        
        if (indicacoes["diasTratamento"][codIndicacao] == "") { time = ""; } else { time = "" + indicacoes["diasTratamento"][codIndicacao] + ", "; }
            
        
        if(var2 == 0) {
            if(varX != null && varX >= 0.1) {
                
                if (apresentacoes["diluicao"][i] == "") { 
                    adm = adm = "Fazer até ";
                } else { 
                    adm = apresentacoes["diluicao"][i] + " e fazer até "; 
                }
                
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AF + ' ' + var1 + '</span> - ' + adm  + varX + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
            } else {
                returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AF + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
            }
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AF + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
        } else {
            
            if(varX == null) {
                
                if (apresentacoes["diluicao"][i] == "") { 
                    adm = ""; 
                } else { 
                    adm = apresentacoes["diluicao"][i] + " e administrar "; 
                }
                
                if((indicacoes["dosagemMin"][codIndicacao]) == (indicacoes["dosagemMax"][codIndicacao])) {
                // Apresentacao Normal
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AF + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
                } else {
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AF + ' ' + var1 + '</span> - ' + adm + var2 + ' a ' + indicacoes["dosagemMax"][codIndicacao] + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
                }
            } else {
                
                if (apresentacoes["diluicao"][i] == "") { 
                    adm = adm = "Iniciar com ";
                } else { 
                    adm = apresentacoes["diluicao"][i] + " e iniciar com "; 
                }
                
                // Apresentacao com duas doses
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AF + ' ' + var1 + '</span> - ' + adm  + var2 + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. A dose pode ser aumentada até ' + varX + ' ' + und + ', a depender da gravidade e resposta do paciente. ' + cuidados + '</p></li>';
                
                
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
        
        if(AF == "Cetoconazol" && i == 0) { var6 = "50mg/dia"; } if(AF == "Cetoconazol" && i == 1) { var6 = "100mg/dia"; } if(AF == "Cetoconazol" && i == 2) { var6 = "200mg/dia"; }
        if(AF == "Terbinafina" && i == 0) { var6 = "62.5mg/dia"; } if(AF == "Terbinafina" && i == 1) { var6 = "125mg/dia"; } if(AF == "Terbinafina" && i == 2) { var6 = "250mg/dia"; }
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + AF + "', " + peso + ", " + i + ");";
        
        if(AF == "Nistatina") {
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '</a></li>';
        } else {
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '<span>' + var6 + '</span></a></li>';
        }
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}