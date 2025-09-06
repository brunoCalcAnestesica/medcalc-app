function checarMedicacao(nome) {
    
    var BD = null;
    
    switch(nome) {
        case "ipra":
            BD = "Ipratrópio (Atrovent®)";
            break;
        case "feno":
            BD = "Fenoterol (Berotec®)";
            break;
        case "salb":
            BD = "Salbutamol (Aerolin®)";
            break;
        case "mag":
            BD = "Sulfato de Magnésio";
            break;
        case "ace":
            BD = "Acebrofilina";
            break;
        case "monte":
            BD = "Montelucaste";
            break;
        case "terb":
            BD = "Terbutalina";
            break;
    }
    
    return BD;
    
}




function calcularDroga(BD, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, und, intervalo, cuidados;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    
    
    if(BD == "Ipratrópio (Atrovent®)") {
        
        var apresentacoes = {
            "apresentacao": ["Solução para Inalação"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-GT"],
            "unidade": ["gotas"],
            "cuidados": [""],
            "pesoUnico": [true]
        };
        var indicacoes = {
            "indicacao": ["Crianças menores de 5 anos", "Crianças maiores de 5 anos"],
            "dosagem": [10, 20],
            "intervaloS": ["apenas na primeira nebulização de ataque", "apenas na primeira nebulização de ataque"],
            "intervaloN": [1, 1],
            "doseMaxima": [10, 20],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Anticolinérgico inalatório.", "Estudos demonstram que apresenta eficácia apenas na 1ª nebulização da emergência, não sendo necessário realizar após alta hospitalar."];
    
    }
    
    
    if(BD == "Fenoterol (Berotec®)") {
        
        var apresentacoes = {
            "apresentacao": ["Solução para Inalação"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO-GT"],
            "unidade": ["gotas"],
            "cuidados": [""],
            "pesoUnico": [false]
        };
        var indicacoes = {
            "indicacao": ["Asma Brônquica"],
            "dosagem": [0.333333],
            "intervaloS": ["em intervalos de 20/20 minutos até 6/6 horas (a depender da gravidade)"],
            "intervaloN": [1],
            "doseMaxima": [12],
            "diasTratamento": [""]
        };
        var contraindicacoes = ["B2-agonista inalatório.", "Orientar aos pais e ao paciente sobre a ocorrência de taquicardia e tremores, seu curso benigno e transitório, sem risco nenhum.", "Pela grande perda da medicação pela nebulização, sua dose mínima deve ser de 3 gotas.", "Diante da necessidade do uso contínuo, deve ser monitorizado os níveis de potássio pelo risco de hipocalemia."];
    
    }
    
    
    if(BD == "Salbutamol (Aerolin®)") {
        
        var apresentacoes = {
            "apresentacao": ["Solução para Inalação", "Aerossol"],
            "dosePorMl": [1, 1],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "JATO"],
            "unidade": ["mL", "jatos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Asma (Crise)", "Asma (Manutenção)"],
            "dosagem": [1, 1],
            "intervaloS": ["em intervalos de 20/20 minutos", "em intervalos de 4/4 hora até 6/6 horas (a depender da gravidade)"],
            "intervaloN": [1, 1],
            "doseMaxima": [20, 20],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["B2-agonista inalatório.", "Orientar aos pais e ao paciente sobre a ocorrência de taquicardia e tremores, seu curso benigno e transitório, sem risco nenhum.", "Diante da necessidade do uso contínuo, deve ser monitorizado os níveis de potássio pelo risco de hipocalemia.", "O uso de espaçadores é fundamental e deve ser prescrito, pelo maior aproveitamento da medicação. <small><a href='assets/materiais/espacador-caseiro.pdf' target='_blank' style='color: #1ABC9C;'>(Veja como montar um espaçador 'caseiro')</a></small>"];
    
    }
    
    
    if(BD == "Sulfato de Magnésio") {
        
        var apresentacoes = {
            "apresentacao": ["500mg/mL"],
            "dosePorMl": [500],
            "diluicao": [""],
            "viaAdministracao": ["IV"],
            "unidade": ["mL"],
            "cuidados": ["Diluir em 100 mL de SF e administrar lentamente (20 minutos), enquanto monitorizado."],
            "pesoUnico": [false]
        };
        var indicacoes = {
            "indicacao": ["Asma Brônquica Grave"],
            "dosagem": [50],
            "intervaloS": ["em dose única"],
            "intervaloN": [1],
            "doseMaxima": [2000],
            "diasTratamento": [""]
        };
        var contraindicacoes = ["Indicado nos casos de asma grave que não respondem ao tratamento inicial da crise aguda (primeira hora) ou quando há risco de vida.", "O paciente deve ser monitorizado pelo risco de hipotensão e arritmias."];
    
    }
    
    
    if(BD == "Acebrofilina") {
        
        var apresentacoes = {
            "apresentacao": ["Infantil (5mg/mL)", "Adulto (10mg/mL)"],
            "dosePorMl": [5, 10],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SOV", "VO-SOV"],
            "unidade": ["mL", "mL"],
            "cuidados": ["", ""],
            "pesoUnico": [false, false]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 1 a 3 anos", "Crianças de 4 a 6 anos", "Crianças de 7 a 11 anos", "Crianças maiores de 12 anos"],
            "dosagem": [1, 1, 1, 1],
            "intervaloS": ["em intervalos de 12/12 horas", "em intervalos de 12/12 horas", "em intervalos de 12/12 horas", "em intervalos de 12/12 horas"],
            "intervaloN": [2, 2, 2, 2],
            "doseMaxima": [50, 50 , 50, 100],
            "diasTratamento": ["", "", "", ""]
        };
        var contraindicacoes = ["?"];
    
    }
    
    
    if(BD == "Montelucaste") {
        
        var apresentacoes = {
            "apresentacao": ["4mg"],
            "dosePorMl": [1],
            "diluicao": [""],
            "viaAdministracao": ["VO"],
            "unidade": ["comprimido"],
            "cuidados": [""],
            "pesoUnico": [true]
        };
        var indicacoes = {
            "indicacao": ["Crianças de 2 a 5 anos", "Crianças de 6 a 14 anos", "Crianças maiores de 15 anos"],
            "dosagem": [1, 1, 1],
            "intervaloS": ["em intervalos de 24/24 horas", "em intervalos de 24/24 horas", "em intervalos de 24/24 horas"],
            "intervaloN": [1, 1, 1],
            "doseMaxima": [1, 1, 1],
            "diasTratamento": ["", "", ""]
        };
        var contraindicacoes = ["Antileucotrieno utilizado no tratamento de manutenção da asma e rinite alérgica.", "Os comprimidos são mastigáveis e devem ser ingeridos preferencialmente à noite."];
    
    }
    
    
    if(BD == "Terbutalina") {
        
        var apresentacoes = {
            "apresentacao": ["0.3mg/mL", "0.5mg/mL"],
            "dosePorMl": [1, 1],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SOV", "SC"],
            "unidade": ["mL", "mL"],
            "cuidados": ["", "A dose pode ser aumentada até 0.5mL/dose."],
            "pesoUnico": [false, true]
        };
        var indicacoes = {
            "indicacao": ["Asma (Manutenção)", "Asma (Crise)"],
            "dosagem": [0.25, 0.2],
            "intervaloS": ["em intervalos de 8/8 horas", "até o máximo de 4 vezes ao dia"],
            "intervaloN": [3, 4],
            "doseMaxima": [10, 0.2],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["?"];
    
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
            case "VO-SOV":
                var6 = "prescription-bottle";
                var2 = Math.round(var2*2)/2;
                var4 = "via oral";
                break;
            case "VO-SO":
                var6 = "prescription-bottle";
                var2 = Math.round(var2*2)/2;
                var4 = "via inalatória";
                break;
            case "VO-GT":
                var6 = "tint";
                var2 = Math.round(var2);
                var4 = "via inalatória";
                break;
            case "JATO":
                var6 = "spray-can";
                var2 = Math.round(var2);
                var4 = "nebulização";
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
            case "SC":
                var6 = "syringe";
                var2 = Number((var2).toFixed(1));
                var4 = "via SC";
                break;
        }
        
        if (apresentacoes["diluicao"][i] == "") { adm = ""; } else { adm = apresentacoes["diluicao"][i] + " e administrar "; }
        
        if (indicacoes["diasTratamento"][codIndicacao] == "") { time = ""; } else { time = "durante " + indicacoes["diasTratamento"][codIndicacao] + ", "; }
        
        if(BD == "Fenoterol (Berotec®)" && var2 < 3) { var2 = 3; }
        if(BD == "Acebrofilina" && codIndicacao == 1 && i == 0) { var2 = 5; }
        if(BD == "Acebrofilina" && codIndicacao == 1 && i == 1) { var2 = 2.5; }
        if(BD == "Acebrofilina" && codIndicacao == 2 && i == 0) { var2 = 10; }
        if(BD == "Acebrofilina" && codIndicacao == 2 && i == 1) { var2 = 5; }
        if(BD == "Acebrofilina" && codIndicacao == 3 && i == 0) { var2 = null; }
        if(BD == "Acebrofilina" && codIndicacao == 3 && i == 1) { var2 = 10; }
        if(BD == "Acebrofilina" && codIndicacao == 0 && i == 1) { var2 = null; }
        if(BD == "Acebrofilina" && codIndicacao == 1 && i == 1) { var2 = null; }
        if(BD == "Acebrofilina" && codIndicacao == 2 && i == 1) { var2 = null; }
        if(BD == "Montelucaste" && codIndicacao == 0) { var1 = "4mg"; }
        if(BD == "Montelucaste" && codIndicacao == 1) { var1 = "5mg"; }
        if(BD == "Montelucaste" && codIndicacao == 2) { var1 = "10mg"; }
        if(BD == "Terbutalina" && codIndicacao == 0 && i == 1) { var2 = null; }
        if(BD == "Terbutalina" && codIndicacao == 1 && i == 0) { var2 = null; }
        if(BD == "Salbutamol (Aerolin®)" && codIndicacao == 0 && i == 0) { var2 = "0.5"; }
        if(BD == "Salbutamol (Aerolin®)" && codIndicacao == 0 && i == 1) { var2 = "4 a 10"; }
        if(BD == "Salbutamol (Aerolin®)" && codIndicacao == 1 && i == 0) { var2 = "0.5"; }
        if(BD == "Salbutamol (Aerolin®)" && codIndicacao == 1 && i == 1) { var2 = "1 a 2"; }
        
        if(var2 == 0) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + BD + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + BD + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
        } else {
            returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + BD + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        /*var2 = (indicacoes["dosagem"][i] * indicacoes["intervaloN"][i]);*/
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + BD + "', " + peso + ", " + i + ");";
        
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