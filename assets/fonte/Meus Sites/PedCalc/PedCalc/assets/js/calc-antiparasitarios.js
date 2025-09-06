function checarMedicacao(nome) {
    
    var AP = null;
    
    switch(nome) {
        case "meben":
            AP = "Mebendazol";
            break;
        case "alben":
            AP = "Albendazol";
            break;
        case "metro":
            AP = "Metronidazol";
            break;
        case "iver":
            AP = "Ivermectina";
            break;
        case "anita":
            AP = "Nitazoxanida";
            break;
        case "secni":
            AP = "Secnidazol";
            break;
        case "pirv":
            AP = "Pamoato de Pirvínio";
            break;
    }
    
    return AP;
    
}




function calcularDroga(AP, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, und, intervalo, cuidados;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    
    
    if(AP == "Mebendazol") {
        
        var apresentacoes = {
            "apresentacao": ["100mg/5ml", "100mg"],
            "dosePorMl": [20, 100],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true],
            "exclusao": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Ascaridíase", "Ancilostomíase", "Larva Migrans", "Teníase", "Oxiuríase"],
            "dosagem": [100, 100, 100, 200, 100],
            "intervaloS": ["12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2, 2, 2, 2],
            "doseMaxima": [100, 100, 100, 200, 100],
            "diasTratamento": ["durante 3 dias. Repetir o esquema após 3 semanas", "durante 3 dias", "durante 5 dias", "durante 5 dias", "durante 3 dias. Repetir o esquema após 2 semanas"]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Efeitos colaterais: tontura, cefaleia, dor abdominal, diarréia, náusea e vômitos."];
    
    }
    
    
    if(AP == "Albendazol") {
        
        var apresentacoes = {
            "apresentacao": ["400mg/10ml", "400mg"],
            "dosePorMl": [40, 400],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [true, true],
            "exclusao": [true, true]
        };
        var indicacoes = {
            "indicacao": ["Ascaridíase", "Ancilostomíase", "Estrongiloidíase", "Giardíase", "Larva Migrans", "Neurocisticercose", "Teníase", "Oxiuríase"],
            "dosagem": [400, 400, 400, 400, 400, 400, 400, 400],
            "intervaloS": ["uma vez ao dia", "uma vez ao dia", "uma vez ao dia", "uma vez ao dia", "uma vez ao dia", "12/12 horas", "uma vez ao dia", "uma vez ao dia"],
            "intervaloN": [1, 1, 1, 1, 1, 2, 1, 1],
            "doseMaxima": [400, 400, 400, 400, 400, 400, 400, 400],
            "diasTratamento": ["em dose única", "em dose única", "durante 3 dias", "durante 5 dias", "durante 3 dias", "durante 30 dias", "durante 3 dias", "em dose única"]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 2 anos de idade.", "Efeitos colaterais: tontura, cefaleia, dor abdominal, diarréia, náusea e vômitos.", "A medicação pode induzir a migração de áscaris para a boca e nariz, ou causa ainda obstrução intestinal."];
    
    }
    
    
    if(AP == "Metronidazol") {
        
        var apresentacoes = {
            "apresentacao": ["40mg/ml", "250mg", "400mg"],
            "dosePorMl": [40, 250, 400],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-SO", "VO", "VO"],
            "unidade": ["mL", "comprimidos", "comprimidos"],
            "cuidados": ["", "", ""],
            "pesoUnico": [false, false, false],
            "exclusao": [true, true, true]
        };
        var indicacoes = {
            "indicacao": ["Amebíase", "Giardíase"],
            "dosagem": [10, 10],
            "intervaloS": ["8/8 horas", "12/12 horas"],
            "intervaloN": [3, 2],
            "doseMaxima": [500, 500],
            "diasTratamento": ["durante 7 dias", "durante 7 dias"]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Efeitos colaterais: náusea, vômitos, diarréia e gosto metálico.", "Efeito Dissulfiram (não associar com bebida alcóolica)."];
    
    }
    
    
    if(AP == "Ivermectina") {
        
        var apresentacoes = {
            "apresentacao": ["6mg"],
            "dosePorMl": [6],
            "diluicao": [""],
            "viaAdministracao": ["VO"],
            "unidade": ["comprimidos"],
            "cuidados": [""],
            "pesoUnico": [false],
            "exclusao": [false]
        };
        var indicacoes = {
            "indicacao": ["Escabiose", "Larva Migrans", "Pediculose", "Tungíase"],
            "dosagem": [0.2, 0.2, 0.2, 0.2],
            "intervaloS": ["uma vez ao dia", "uma vez ao dia", "uma vez ao dia", "uma vez ao dia"],
            "intervaloN": [1, 1, 1, 1],
            "doseMaxima": [18, 18, 18, 10],
            "diasTratamento": ["em dose única, repetindo uma outra dose com 14 dias", "em dose única, repetindo uma outra dose com 14 dias", "em dose única, repetindo uma outra dose com 7 dias", "em dose única"]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 15kg.", "Na pediculose, a retirada manual das lêndeas é fundamental para evitar recorrência.", "Efeitos colaterais: tontura, cefaleia, dor abdominal, diarréia, náusea e vômitos."];
    
    }
    
    
    if(AP == "Nitazoxanida") {
        
        var apresentacoes = {
            "apresentacao": ["20mg/ml", "500mg"],
            "dosePorMl": [20, 500],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [false, false],
            "exclusao": [false, true]
        };
        var indicacoes = {
            "indicacao": ["Largo Espectro"],
            "dosagem": [7.5],
            "intervaloS": ["12/12 horas"],
            "intervaloN": [2],
            "doseMaxima": [500],
            "diasTratamento": ["durante 3 dias"]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Indicado para o tratamento de: Amebíase, Ascaridíase, Ancilostomíase, Giardíase, Teníase e Oxiuríase.", "Sua administração deve ser feita junto com alimentos.", "Efeitos colaterais: tontura, cefaleia, dor abdominal, diarréia, náusea e vômitos."];
    
    }
    
    
    if(AP == "Secnidazol") {
        
        var apresentacoes = {
            "apresentacao": ["30mg/ml", "1.000mg"],
            "dosePorMl": [30, 1000],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""],
            "pesoUnico": [false, false],
            "exclusao": [false, true]
        };
        var indicacoes = {
            "indicacao": ["Amebíase", "Giardíase"],
            "dosagem": [30, 30],
            "intervaloS": ["uma vez ao dia", "uma vez ao dia"],
            "intervaloN": [1, 1],
            "doseMaxima": [2000, 2000],
            "diasTratamento": ["em dose única", "em dose única"]
        };
        var contraindicacoes = ["Não há contra-indicação para faixa etária.", "Efeitos colaterais: náusea, vômitos, diarréia e gosto metálico.", "Efeito Dissulfiram (não associar com bebida alcóolica)."];
    
    }
    
    
    if(AP == "Pamoato de Pirvínio") {
        
        var apresentacoes = {
            "apresentacao": ["10mg/ml", "100mg"],
            "dosePorMl": [10, 100],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["Repetir o esquema com 14 dias.", "Repetir o esquema com 14 dias."],
            "pesoUnico": [false, false],
            "exclusao": [false, true]
        };
        var indicacoes = {
            "indicacao": ["Oxiuríase"],
            "dosagem": [10],
            "intervaloS": ["uma vez ao dia"],
            "intervaloN": [1],
            "doseMaxima": [1000],
            "diasTratamento": ["em dose única"]
        };
        var contraindicacoes = ["Contra-indicado em crianças menores de 1 ano de idade.", "Efeitos colaterais: tontura, cefaleia, dor abdominal, diarréia, náusea e vômitos."];
    
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
                if(apresentacoes["exclusao"][i] == true) {
                    if(var2 < 0.98) {
                        var2 = null;
                    } else {
                        var2 = Math.round(var2);
                        und = "comprimido";
                    }
                } else {
                    if(AP == "Ivermectina") {
                            if(peso < 15) {
                                var2 = 0;
                            } else if(peso >= 15 && peso < 25) {
                                var2 = "1/2";
                                und = "comprimido";
                            } else if(peso >= 25 && peso < 35) {
                                var2 = "1";
                                und = "comprimido";
                            } else if(peso >= 35 && peso < 50) {
                                var2 = "1 e 1/2";
                                und = "comprimido";
                            } else if(peso >= 50 && peso < 65) {
                                var2 = "2";
                                und = "comprimidos";
                            } else if(peso >= 65 && peso < 80) {
                                var2 = "2 e 1/2";
                                und = "comprimidos";
                            }else if(peso >= 80) {
                                var2 = Math.floor(var2*2)/2;
                                if(var2 == 3.5) { var2 = "3 e 1/2"; }
                                if(var2 == 4.5) { var2 = "4 e 1/2"; }
                                und = "comprimidos";
                            }
                        } else {
                            var2 = Math.floor(var2*2)/2;
                            if(var2 <= 1) { und = "comprimido"; }
                            if(var2 == 0.5) { var2 = "1/2"; } 
                            if(var2 == 1.5) { var2 = "1 e 1/2"; } 
                            if(var2 == 2.5) { var2 = "2 e 1/2"; } 
                            if(var2 == 3.5) { var2 = "3 e 1/2"; } 
                } }
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
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AP + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + AP + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pela sub-dose ou super-dose.</p></li>';
        } else {
            returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + AP + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em intervalos de ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        var2 = (indicacoes["dosagem"][i] * indicacoes["intervaloN"][i]);
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + AP + "', " + peso + ", " + i + ");";
        
        /*returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '</a></li>';*/
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '<span>' + var2 + ' mg/kg/dia</span></a></li>';
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}