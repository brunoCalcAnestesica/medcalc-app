function checarMedicacao(nome) {
    
    var AC = null;
    
    switch(nome) {
        case "carba":
            AC = "Carbamazepina";
            break;
        case "diaz":
            AC = "Diazepam";
            break;
        case "fenito":
            AC = "Fenitoína";
            break;
        case "fenobar":
            AC = "Fenobarbital";
            break;
        case "valp":
            AC = "Valproato de Sódio";
            break;
    }
    
    return AC;
    
}




function calcularDroga(AC, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, und, intervalo, cuidados;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    
    
    if(AC == "Carbamazepina") {
        
        var apresentacoes = {
            "apresentacao": ["20mg/mL", "200mg"],
            "dosePorMl": [20, 200],
            "intervalo": ["6/6 horas", "6/6 horas"],
            "unidade": ["mL", "comprimidos"],
            "viaAdministracao": ["VO-SO", "VO"],
            "diluicao": ["", ""],
            "tipo": ["AMB", "AMB"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Manutenção (Dose Usual)", "Manutenção (Dose Máxima)"],
            "dosagem": [2.5, 5],
            "tipo": ["AMB", "AMB"],
            "intervalo": [4, 4],
            "doseMaxima": [1000, 1000]
        };
        var contraindicacoes = ["A dose pode ser aumentada a cada 5 dias.", "Monitorização dos níveis séricos (8 a 12 mg/dL).", "Efeitos colaterais relacionados à dose: Leucopenia, Rash maculopapular, Náuseas e Sedação.", "Pode aumentar a frequência de crises de ausência."];
    
    }
    
    
    if(AC == "Diazepam") {
        
        var apresentacoes = {
            "apresentacao": ["5mg/mL", "5mg", "10mg"],
            "dosePorMl": [5, 10, 5],
            "intervalo": ["5 minutos, até duas repetições, se persistir as crises", "6/6 horas", "6/6 horas"],
            "unidade": ["mL", "comprimidos", "comprimidos"],
            "viaAdministracao": ["IV", "VO", "VO"],
            "diluicao": ["", "", ""],
            "tipo": ["URG", "AMB", "AMB"],
            "cuidados": ["Não é recomendado a diluição da medicação.", "", ""]
        };
        var indicacoes = {
            "indicacao": [ "Crise Convulsiva Febril", "Sedativo (Dose Usual)", "Sedativo (Dose Máxima)"],
            "dosagem": [0.3, 0.025, 0.2],
            "tipo": ["URG", "AMB", "AMB"],
            "intervalo": [1, 4, 4],
            "doseMaxima": [10, 10, 10]
        };
        var contraindicacoes = ["É a droga de 1ª escolha para abortar a crise convulsiva.", "Na vigência da crise convulsiva, deve ser realizada em bolus, por via EV, sem diluição."];
    
    }
    
    
    if(AC == "Fenitoína") {
        
        var apresentacoes = {
            "apresentacao": ["100mg/5mL", "100mg", "50mg/mL"],
            "dosePorMl": [20, 100, 50],
            "intervalo": ["12/12 horas", "12/12 horas", ""],
            "unidade": ["mL", "comprimidos", "mL"],
            "viaAdministracao": ["VO-SO", "VO", "IV"],
            "diluicao": ["", "", ""],
            "tipo": ["AMB", "AMB", "URG"],
            "cuidados": ["", "", "Diluir em SF e correr em 20 minutos."]
        };
        var indicacoes = {
            "indicacao": ["Manutenção (Dose Usual)", "Manutenção (Dose Máxima)", "Crise Convulsiva"],
            "dosagem": [2, 4, 20],
            "tipo": ["AMB", "AMB", "URG"],
            "intervalo": [2, 2, 1],
            "doseMaxima": [150, 150, 1000]
        };
        var contraindicacoes = ["Após uma crise convulsiva, a terapia de manutenção deve ser iniciada 12 horas após a dose de ataque."];
    
    }
    
    
    if(AC == "Fenobarbital") {
        
        var apresentacoes = {
            "apresentacao": ["40mg/mL", "100mg", "100mg/mL"],
            "dosePorMl": [1, 100, 100],
            "intervalo": ["24/24 horas", "24/24 horas", ""],
            "unidade": ["gotas", "comprimidos", "mL"],
            "viaAdministracao": ["VO-GT", "VO", "IV"],
            "diluicao": ["", "", ""],
            "tipo": ["AMB", "AMB", "URG"],
            "cuidados": ["A dose pode, ainda, ser dividida em duas tomadas ao dia.", "A dose pode, ainda, ser dividida em duas tomadas ao dia.", "Diluir em SF e correr em 20 minutos."]
        };
        var indicacoes = {
            "indicacao": ["Manutenção (Dose Usual)", "Manutenção (Dose Máxima)", "Crise Convulsiva"],
            "dosagem": [3, 5, 20],
            "tipo": ["AMB", "AMB", "URG"],
            "intervalo": [1, 1, 1],
            "doseMaxima": [1000, 1000, 1000]
        };
        var contraindicacoes = ["Primeira escolha em crises neonatais.", "Após uma crise convulsiva, a terapia de manutenção deve ser iniciada 24 horas após a dose de ataque.", "O extravasamento da solução injetável pode causar necrose tecidual. Nestes casos, aplicar compressa morna e anestesia local."];
    
    }
    
    
    if(AC == "Valproato de Sódio") {
        
        var apresentacoes = {
            "apresentacao": ["250mg/5mL"],
            "dosePorMl": [50],
            "intervalo": ["12/12 horas"],
            "unidade": ["mL"],
            "viaAdministracao": ["VO-SO"],
            "diluicao": [""],
            "tipo": ["AMB"],
            "cuidados": ["A dose pode, ainda, ser dividida em três tomadas ao dia."]
        };
        var indicacoes = {
            "indicacao": ["Manutenção (Dose Usual)", "Manutenção (Dose Máxima)"],
            "dosagem": [5, 7.5],
            "tipo": ["AMB", "AMB"],
            "intervalo": [2, 2],
            "doseMaxima": [1000, 1000]
        };
        var contraindicacoes = ["Não indicado para crianças com menos de 6 anos.", "Primeira ou segunda escolha em praticamente todos os tipos de crises.", "Em casos refratários, a dose pode ser aumentada semanalmente até 60 mg/kg/dia."];
    
    }

    
    //  Processamento das Apresentações e Cálculo de Doses
    for (i = 0; i < Object.keys(apresentacoes["apresentacao"]).length; ++i) {
        
        if(indicacoes["tipo"][codIndicacao] == apresentacoes["tipo"][i]) {
        
        var1 = apresentacoes["apresentacao"][i];
        var2 = (((indicacoes["dosagem"][codIndicacao])*peso)/(apresentacoes["dosePorMl"][i]));
    
        if(var2 > (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])))) {
            var2 = (((indicacoes["doseMaxima"][codIndicacao])/(apresentacoes["dosePorMl"][i])));
        }
           
        var3 = apresentacoes["intervalo"][i];
        var4 = apresentacoes["viaAdministracao"][i];
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
                        if(var2 == 1.5) { var2 = "1 e 1/2"; } 
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
            
        cuidados = apresentacoes["cuidados"][i];
            
        if(apresentacoes["tipo"][i] == "URG" && apresentacoes["intervalo"][i] == "") {
            returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AC + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em dose única, por ' + var4 + '. ' + cuidados + '</p></li>';
        } else {
            if(var2 == 0) {
                returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AC + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
            } else if(var2 == null) {
                returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AC + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
            } else {
                if(var3 == "") { var3 = "em dose única"; } else { var3 = "em intervalos de " + var3; }
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AC + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', ' + var3 + ', por ' + var4 + '. ' + cuidados + '</p></li>';
            }
        }
        
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        var2 = (indicacoes["dosagem"][i]*indicacoes["intervalo"][i]);
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + AC + "', " + peso + ", " + i + ");";
        
        if(indicacoes["tipo"][i] == "URG") { var3 = "dose"; } else { var3 = "dia"; }
        
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '<span>' + var2 + 'mg/kg/' + var3 + '</span></a></li>';
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}