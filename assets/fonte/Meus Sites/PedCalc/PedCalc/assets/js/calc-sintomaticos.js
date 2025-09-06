function checarMedicacao(nome) {
    
    var ST = null;
    
    switch(nome) {
        case "para":
            ST = "Paracetamol";
            break;
        case "dipi":
            ST = "Dipirona";
            break;
        case "meto":
            ST = "Metoclopramida";
            break;
        case "onda":
            ST = "Ondansetrona";
            break;
        case "bromo":
            ST = "Bromoprida";
            break;
        case "busc":
            ST = "Escopolamina";
            break;
        case "simet":
            ST = "Simeticona";
            break;
        case "ranit":
            ST = "Ranitidina";
            break;
        case "hidro":
            ST = "Hidróxido de Alumínio";
            break;
        case "ambro":
            ST = "Ambroxol";
            break;
        case "levo":
            ST = "Levodropropizina";
            break;
        case "acetil":
            ST = "Acetilcisteína";
            break;
    }
    
    return ST;
    
}



function calcularDroga(ST, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, cuidados, time, und;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    var varX = 0;
    
    
    if(ST == "Acetilcisteína") {
    
        var apresentacoes = {
            "apresentacao": ["20mg/mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-SO"],
            "unidade": ["mL"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 2 a 4 anos", "Crianças acima de 4 anos"],
            "dosagemMin": [5, 5],
            "dosagemMax": [5, 5],
            "intervaloS": ["12/12 horas", "8/8 horas"],
            "intervaloN": [2, 3],
            "doseMaxima": [5, 5],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Mucolítico", "Contra-indicado em crianças menores de 2 anos de idade."];
        
    }
    
    if(ST == "Paracetamol") {
    
        var apresentacoes = {
            "apresentacao": ["200mg/mL", "100mg/mL"],
            "dosePorMl": [15, 100],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-GT", "VO-SO"],
            "unidade": ["gotas", "mL"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Antitérmico"],
            "dosagemMin": [15, 15],
            "dosagemMax": [15, 15],
            "intervaloS": ["6/6 horas ou até 4/4 horas", "6/6 horas ou até 4/4 horas"],
            "intervaloN": [4, 4],
            "doseMaxima": [500, 500],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Não exceder a dose máxima de 75 mg/kg/dia.", "No caso de intoxicação, medidas de suporte devem ser tomadas, como: lavagem gástrica e carvão ativado."];
        
    }
    
    if(ST == "Dipirona") {
    
        var apresentacoes = {
            "apresentacao": ["500mg/mL", "50mg/mL", "500mg/mL"],
            "dosePorMl": [25, 50, 800],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-GT", "VO-SO", "IMV"],
            "unidade": ["gotas", "mL", "mL"],
            "cuidados": ["", "", "Em crianças até 1 ano de idade, preferir a via IM."]
        };
        var indicacoes = {
            "indicacao": ["Analgésico", "Antitérmico"],
            "dosagemMin": [25, 25],
            "dosagemMax": [25, 25],
            "intervaloS": ["6/6 horas", "6/6 horas"],
            "intervaloN": [4, 4],
            "doseMaxima": [1000, 1000],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 3 meses de idade ou pesando menos de 5 kg.", "A dose máxima diária é de 4g."];
        
    }
    
    if(ST == "Metoclopramida") {
    
        var apresentacoes = {
            "apresentacao": ["4mg/mL", "10mg/2mL"],
            "dosePorMl": [0.2, 5],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-GT", "IMV"],
            "unidade": ["gotas", "mL"],
            "cuidados": ["", "", ""]
        };
        var indicacoes = {
            "indicacao": ["Antiemético"],
            "dosagemMin": [0.15],
            "dosagemMax": [0.15],
            "intervaloS": ["8/8 horas"],
            "intervaloN": [3, 3],
            "doseMaxima": [10, 10],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Contra-indicado em pacientes com história de sintomas extra-piramidais."];
        
    }
    
    if(ST == "Ondansetrona") {
    
        var apresentacoes = {
            "apresentacao": ["4mg", "2mg/mL"],
            "dosePorMl": [2, 2],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO", "IMV"],
            "unidade": ["comprimidos", "mL"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Antiemético"],
            "dosagemMin": [0.1],
            "dosagemMax": [0.1],
            "intervaloS": ["8/8 horas"],
            "intervaloN": [3],
            "doseMaxima": [4],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Indicado para crianças a partir de 1 mês de vida."];
        
    }
    
    if(ST == "Bromoprida") {
    
        var apresentacoes = {
            "apresentacao": ["4mg/mL", "5mg/mL"],
            "dosePorMl": [0.2, 5],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-GT", "IMV"],
            "unidade": ["gotas", "mL"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Antiemético"],
            "dosagemMin": [0.2],
            "dosagemMax": [0.3],
            "intervaloS": ["8/8 horas"],
            "intervaloN": [3],
            "doseMaxima": [20],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Contra-indicado em pacientes com história de sintomas extra-piramidais."];
        
    }
    
    if(ST == "Levodropropizina") {
    
        var apresentacoes = {
            "apresentacao": ["30mg/mL", "6mg/mL"],
            "dosePorMl": [3, 6],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-GT", "VO-SO"],
            "unidade": ["gotas", "mL"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 2 a 12 anos", "Crianças acima de 12 anos"],
            "dosagemMin": [1, 1],
            "dosagemMax": [1, 1],
            "intervaloS": ["8/8 horas", "8/8 horas"],
            "intervaloN": [3, 3],
            "doseMaxima": [60, 60],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Antitussígeno de ação periférica.", "Contra-indicado em crianças menores de 2 anos de idade.", "O tempo de tratamento não deve ser maior do que 7 dias."];
        
    }
    
    if(ST == "Escopolamina") {
    
        var apresentacoes = {
            "apresentacao": ["10mg/mL", "20mg/mL"],
            "dosePorMl": [0.5, 20],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-GT", "IMV"],
            "unidade": ["gotas", "mL"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Antiespasmódico"],
            "dosagemMin": [0.5],
            "dosagemMax": [0.5],
            "intervaloS": ["8/8 horas"],
            "intervaloN": [3],
            "doseMaxima": [20],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Crianças com diarreia aguda ou persistente não devem usar a medicação."];
        
    }
    
    if(ST == "Simeticona") {
    
        var apresentacoes = {
            "apresentacao": ["75mg/mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-GT"],
            "unidade": ["gotas"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Lactentes", "Crianças até 12 anos", "Crianças acima de 12 anos"],
            "dosagemMin": [6, 12, 16],
            "dosagemMax": [6, 12, 16],
            "intervaloS": ["8/8 horas", "8/8 horas", "8/8 horas"],
            "intervaloN": [3, 3, 3],
            "doseMaxima": [16, 16, 16],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Antiespasmódico.", "Não há contra-indicações formais pela baixa absorção sistêmica da medicação."];
        
    }
    
    if(ST == "Ambroxol") {
    
        var apresentacoes = {
            "apresentacao": ["15mg/5mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-SO"],
            "unidade": ["mL"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Crianças até 2 anos", "Crianças de 2 a 5 anos", "Crianças acima de 5 anos"],
            "dosagemMin": [2.5, 2.5, 5],
            "dosagemMax": [2.5, 2.5, 5],
            "intervaloS": ["12/12 horas", "8/8 horas", "8/8 horas"],
            "intervaloN": [2, 3, 3],
            "doseMaxima": [16, 16, 16],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Mucolítico.", "Diversos estudos apresentaram a medicação como efeito placebo."];
        
    }
    
    if(ST == "Ranitidina") {
    
        var apresentacoes = {
            "apresentacao": ["15mg/mL", "25mg/mL"],
            "dosePorMl": [15, 25],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "IMV"],
            "unidade": ["mL", "mL"],
            "cuidados": ["", "À depender da gravidade, a dose pode ser repetida de 8/8 horas."]
        };
        var indicacoes = {
            "indicacao": ["Esofagite de Refluxo", "Úlceras Gástricas", "Úlceras Duodenais", "Sangramento Digestivo"],
            "dosagemMin": [2, 2, 2, 2],
            "dosagemMax": [2, 2, 2, 2],
            "intervaloS": ["12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2, 2, 2],
            "doseMaxima": [300, 300, 300, 300],
            "diasTratamento": ["", "", "", ""]
        };
        var contraindicacoes = ["Devem ser evitados no uso concomitante com outros redutores da acidez gástrica."];
        
    }
    
    if(ST == "Hidróxido de Alumínio") {
    
        var apresentacoes = {
            "apresentacao": ["60mg/mL"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-SO"],
            "unidade": ["mL"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Azia", "Plenitude Pós-Prandial"],
            "dosagemMin": [10, 10],
            "dosagemMax": [10, 10],
            "intervaloS": ["de até 2/2 horas, cerca de uma hora após cada refeição", "de até 2/2 horas, cerca de uma hora após cada refeição"],
            "intervaloN": [10, 10],
            "doseMaxima": [10, 10],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 6 anos de vida.", "Seu uso não deve exceder o período de 4 semanas."];
        
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
        
        if(ST == "Ranitidina" && var1 == "25mg/mL" && var2 > 2) { var2 = 2; }
        
        if(var2 == 0) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + ST + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + ST + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
        } else {
            if (var3 == "") {
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + ST + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em dose única, ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
            } else {
                
                if(ST == "Levodropropizina" && codIndicacao == 1 && var6 == "tint") { var2 = 20; }
                if(ST == "Levodropropizina" && codIndicacao == 1 && var6 == "prescription-bottle") { var2 = 10; }
                
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + ST + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em intervalos de ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
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
        
        
        if(ST == "Simeticona" || ST == "Ambroxol" || ST == "Acetilcisteína" || ST == "Levodropropizina") {
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + ST + "', " + peso + ", " + i + ");";
        
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