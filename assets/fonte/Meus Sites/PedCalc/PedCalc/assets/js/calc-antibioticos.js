function checarMedicacao(nome) {
    
    var ATB = null;
    
    switch(nome) {
        case "cefa":
            ATB = "Cefalexina";
            break;
        case "amox":
            ATB = "Amoxicilina";
            break;
        case "amoxclav":
            ATB = "Amoxicilina + Clavulanato";
            break;
        case "azi":
            ATB = "Azitromicina";
            break;
        case "eritro":
            ATB = "Eritromicina";
            break;
        case "clari":
            ATB = "Claritromicina";
            break;
        case "peng":
            ATB = "Penicilina Benzatina";
            break;
        case "penp":
            ATB = "Penicilina Procaína";
            break;
        case "penc":
            ATB = "Penicilina Cristalina";
            break;
        case "sulfa":
            ATB = "Sulfametaxazol + Trimetoprima";
            break;
        case "nitro":
            ATB = "Nitrofurantoína";
            break;
        case "cef":
            ATB = "Ceftriaxona";
            break;
        case "cefac":
            ATB = "Cefaclor";
            break;
        case "ampi":
            ATB = "Ampicilina";
            break;
        case "genta":
            ATB = "Gentamicina";
            break;
        case "amica":
            ATB = "Amicacina";
            break;
    }
    
    return ATB;
    
}



function numAmpolas(valor1, valor2, tipo) {
    var res, amp;
    var divisao = Math.trunc(valor1 / valor2);
    
    if(tipo == 1) {
        amp = "ampolas";
    } else {
        amp = "FA"
    }
    
    if(divisao == 0) {
        res = "";
    } else {
        if(valor1 % valor2 == 0) {
            res = " (" + divisao + " " + amp + ")";
        } else {
            res = " (" + (divisao + 1) + " " + amp + ")";
        }
    }
    
    return res;
    
}




function calcularDroga(atb, peso, codIndicacao) {
    
    
    var i, var1, var2, var3, var4, var5, var6, active, link, adm, cuidados, time, und;
    var returnValidacao = 0;
    var returnApresentacoes = "";
    var returnIndicacoes = "";
    var returnContraIndicacoes = "";
    var varX = 0;
    
    
    if(atb == "Cefalexina") {
    
        var apresentacoes = {
            "apresentacao": ["250mg/5mL", "500mg"],
            "dosePorMl": [50, 500],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Piodermite", "Faringoamigdalite", "Otite Média Aguda", "Pneumonia (PAC)", "ITU", "ITU (Profilaxia)"],
            "dosagemMin": [12.5, 12.5, 25, 25, 12.5, 12.5],
            "dosagemMax": [12.5, 12.5, 25, 25, 12.5, 12.5],
            "intervaloS": ["6/6 horas", "6/6 horas", "6/6 horas", "6/6 horas", "6/6 horas", "24/24 horas"],
            "intervaloN": [4, 4, 4, 4, 4, 1],
            "doseMaxima": [500, 500, 500, 500, 500, 500],
            "diasTratamento": ["7 dias", "10 dias", "10 dias", "10 dias", "7 dias", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Na ITU, a dose pode ser dobrada em casos mais graves. <small><i>(The Sanford Guide to Antimicrobial Therapy, 2018)</i></small>"];
        
    }

    
    if(atb == "Amoxicilina") {
    
        var apresentacoes = {
            "apresentacao": ["250mg/5mL", "400mg/5mL", "500mg"],
            "dosePorMl": [50, 80, 500],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-SO", "VO-SO", "VO"],
            "unidade": ["mL", "mL", "comprimidos"],
            "cuidados": ["", "", ""]
        };
        var indicacoes = {
            "indicacao": ["Faringoamigdalite", "Otite Média Aguda", "Rinossinusite", "Pneumonia (PAC)"],
            "dosagemMin": [16.6, 30, 30, 30],
            "dosagemMax": [16.6, 30, 30, 30],
            "intervaloS": ["8/8 horas", "8/8 horas", "8/8 horas", "8/8 horas"],
            "intervaloN": [3, 3, 3, 3],
            "doseMaxima": [500, 500, 500, 500],
            "diasTratamento": ["10 dias", "10 dias", "10 dias", "10 dias"]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Em infecções graves, a dose deve ser aumentada para 90 mg/kg/dia. <small><i>(The Sanford Guide to Antimicrobial Therapy, 2018)</i></small>", "Não deve ser utilizado como primeira escolha para tratamento de piodermites (resistência ao <i>S. aureus</i>).", "Em caso de rash, avaliar a possibilidade de mononucleose infecciosa, principal diagnóstico diferencial com a alergia medicamentosa."];
        
    }
    
    
    if(atb == "Amoxicilina + Clavulanato") {
    
        var apresentacoes = {
            "apresentacao": ["400mg + 57mg/5mL", "875mg + 125mg"],
            "dosePorMl": [80, 875],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Faringoamigdalite", "Otite Média Aguda", "Rinossinusite", "Pneumonia (PAC)", "Piodermite", "ITU"],
            "dosagemMin": [25, 45, 45, 45, 25, 25],
            "dosagemMax": [25, 45, 45, 45, 25, 25],
            "intervaloS": ["12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2, 2, 2, 2, 2],
            "doseMaxima": [875, 875, 875, 875, 875, 875],
            "diasTratamento": ["10 dias", "10 dias", "10 dias", "10 dias", "7 dias", "7 dias"]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Em infecções graves, a dose deve ser aumentada para 90 mg/kg/dia. <small><i>(The Sanford Guide to Antimicrobial Therapy, 2018)</i></small>", "Pode ser utilizado no tratamento de piodermites (<i>S. aureus</i>).", "Em caso de rash, avaliar a possibilidade de mononucleose infecciosa, principal diagnóstico diferencial com a alergia medicamentosa."];
        
    }
    
    
    if(atb == "Azitromicina") {
    
        var apresentacoes = {
            "apresentacao": ["200mg/5mL","500mg"],
            "dosePorMl": [40, 500],
            "diluicao": ["",  ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Faringoamigdalite", "Piodermite", "Otite Média Aguda", "Rinossinusite", "Pneumonia (Atípica)"],
            "dosagemMin": [10, 10, 10, 10, 10],
            "dosagemMax": [10, 10, 10, 10, 10],
            "intervaloS": ["24/24 horas", "24/24 horas", "24/24 horas", "24/24 horas", "24/24 horas"],
            "intervaloN": [1, 1, 1, 1, 1],
            "doseMaxima": [500, 500, 500, 500, 500],
            "diasTratamento": ["5 dias", "5 dias", "5 dias", "5 dias", "5 dias"]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Os macrolídeos são segunda-escolha para os tratamentos indicados acima, com exceção da pneumonia atípica."];
        
    }
    
    
    if(atb == "Eritromicina") {
    
        var apresentacoes = {
            "apresentacao": ["250mg/5mL", "250mg", "500mg"],
            "dosePorMl": [50, 250, 500],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-SO", "VO", "VO"],
            "unidade": ["mL", "comprimidos", "comprimidos"],
            "cuidados": ["", "", ""]
        };
        var indicacoes = {
            "indicacao": ["Faringoamigdalite", "Piodermite", "Otite Média Aguda", "Rinossinusite", "Pneumonia (Atípica)"],
            "dosagemMin": [10, 10, 10, 10, 10],
            "dosagemMax": [10, 10, 10, 10, 10],
            "intervaloS": ["6/6 horas", "6/6 horas", "6/6 horas", "6/6 horas", "6/6 horas"],
            "intervaloN": [4, 4, 4, 4, 4],
            "doseMaxima": [500, 500, 500, 500, 500],
            "diasTratamento": ["10 dias", "7 dias", "10 dias", "10 dias", "14 dias"]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Os macrolídeos são segunda-escolha para os tratamentos indicados acima, com exceção da pneumonia atípica."];
        
    }
    
    
    if(atb == "Claritromicina") {
    
        var apresentacoes = {
            "apresentacao": ["125mg/5mL", "250mg/5mL", "250mg", "500mg"],
            "dosePorMl": [25, 50, 250, 500],
            "diluicao": ["", "", "", ""],
            "viaAdministracao": ["VO-SO", "VO-SO", "VO", "VO"],
            "unidade": ["mL", "mL", "comprimidos", "comprimidos"],
        "cuidados": ["", "", "", ""]
        };
        var indicacoes = {
            "indicacao": ["Faringoamigdalite", "Piodermite", "Otite Média Aguda", "Rinossinusite", "Pneumonia (Atípica)"],
            "dosagemMin": [7.5, 7.5, 7.5, 7.5, 7.5],
            "dosagemMax": [7.5, 7.5, 7.5, 7.5, 7.5],
            "intervaloS": ["12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2, 2, 2, 2],
            "doseMaxima": [500, 500, 500, 500, 500],
            "diasTratamento": ["10 dias", "7 dias", "10 dias", "10 dias", "10 dias"]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade ou crianças com menos de 6 meses de vida.", "Os macrolídeos são segunda-escolha para os tratamentos indicados acima, com exceção da pneumonia atípica."];
        
    }
    
    
    if(atb == "Penicilina Benzatina") {
    
        var apresentacoes = {
            "apresentacao": ["600.000 UI", "1.200.000 UI"],
            "dosePorMl": [200000, 50],
            "diluicao": ["Diluir 1 FA em 2 mL de ABD", "Diluir 1 FA em 2 mL de ABD"],
            "viaAdministracao": ["IM", "IM"],
            "unidade": ["mL", "mL"],
            "cuidados": ["", "", "", ""]
        };
        var indicacoes = {
            "indicacao": ["Faringoamigdalite", "Sífilis Congênita"],
            "dosagemMin": [1, 50000],
            "dosagemMax": [1, 50000],
            "intervaloS": ["", ""],
            "intervaloN": [1, 1],
            "doseMaxima": [1200000, 600000],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Deve ser realizado em ambiente hospitalar pelo risco de anafilaxia.", "Não deve ser utilizado como primeira escolha para tratamento de piodermites (resistência ao <i>S. aureus</i>)."];
        
    }
    
    
    if(atb == "Penicilina Procaína") {
    
        var apresentacoes = {
            "apresentacao": ["300.000 UI"],
            "dosePorMl": [150000],
            "diluicao": ["Diluir 1 FA em 2 mL de ABD"],
            "viaAdministracao": ["IM"],
            "unidade": ["mL"],
            "cuidados": [""]
        };
        var indicacoes = {
            "indicacao": ["Sífilis Congênita", "Infecção por <i>Streptococcus</i> (Grupo A)"],
            "dosagemMin": [50000, 50000],
            "dosagemMax": [50000, 50000],
            "intervaloS": ["24/24 horas", "24/24 horas"],
            "intervaloN": [1, 1],
            "doseMaxima": [600000, 600000],
            "diasTratamento": ["10 dias", "10 a 14 dias"]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Deve ser realizado em ambiente hospitalar pelo risco de anafilaxia.", "Não deve ser utilizado como primeira escolha para tratamento de piodermites (resistência ao <i>S. aureus</i>)."];
        
    }
    
    
    if(atb == "Penicilina Cristalina") {
    
        var apresentacoes = {
            "apresentacao": ["1.000.000 UI", "5.000.000 UI"],
            "dosePorMl": [500000, 1000000],
            "diluicao": ["Diluir 1 FA em 2 mL de ABD", "Diluir 1 FA em 5 mL de ABD"],
            "viaAdministracao": ["IMV", "IMV"],
            "unidade": ["mL", "mL"],
            "cuidados": ["<br/><br/>Administração IV: Rediluir em 100 mL de SF ou SG e infundir por 30 minutos.", "<br/><br/>Administração IV: Rediluir em 100 mL de SF ou SG e infundir por 30 minutos."]
        };
        var indicacoes = {
            "indicacao": ["Pneumonia (PAC)", "Endocardite", "Meningite", "Piodermite", "Sífilis Congênita"],
            "dosagemMin": [50000, 50000, 50000, 50000, 50000],
            "dosagemMax": [100000, 50000, 100000, 100000, 50000],
            "intervaloS": ["6/6 horas", "4/4 horas", "6/6 horas", "6/6 horas", "12/12 horas (até 7 dias de vida) ou 8/8 horas (mais de 7 dias de vida)"],
            "intervaloN": [4, 6, 4, 4, 3],
            "doseMaxima": [6000000, 6000000, 6000000, 6000000, 6000000],
            "diasTratamento": ["", "", "", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Necessita de ajuste renal e hepático", "Deve ser realizado em ambiente hospitalar pelo risco de anafilaxia.", "Não deve ser utilizado como primeira escolha para tratamento de piodermites (resistência ao <i>S. aureus</i>)."];
        
    }
    
    
    if(atb == "Sulfametaxazol + Trimetoprima") {
    
        var apresentacoes = {
            "apresentacao": ["200mg + 40mg/5mL", "400mg + 80mg/5mL", "800mg + 160mg"],
            "dosePorMl": [40, 80, 800],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-SO", "VO-SO", "VO"],
            "unidade": ["mL", "mL", "comprimidos"],
            "cuidados": ["", "", ""]
        };
        var indicacoes = {
            "indicacao": ["ITU", "ITU (Profilaxia)"],
            "dosagemMin": [20, 10],
            "dosagemMax": [20, 10],
            "intervaloS": ["12/12 horas", "24/24 horas"],
            "intervaloN": [2, 1],
            "doseMaxima": [800, 800],
            "diasTratamento": ["7 dias", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade."];
        
    }
    
    
    if(atb == "Cefaclor") {
    
        var apresentacoes = {
            "apresentacao": ["250mg/5mL", "500mg"],
            "dosePorMl": [50, 500],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["Infecção Leve a Moderada", "Infecção Grave"],
            "dosagemMin": [10, 20],
            "dosagemMax": [10, 20],
            "intervaloS": ["12/12 horas", "12/12 horas"],
            "intervaloN": [2, 2],
            "doseMaxima": [500, 500],
            "diasTratamento": ["", ""]
        };
        var contraindicacoes = ["Contra-indicado em crianças com menos de 1 mês de vida."];
        
    }
    
    
    if(atb == "Nitrofurantoína") {
    
        var apresentacoes = {
            "apresentacao": ["5mg/ml", "100mg"],
            "dosePorMl": [5, 100],
            "diluicao": ["", ""],
            "viaAdministracao": ["VO-SO", "VO"],
            "unidade": ["mL", "comprimidos"],
            "cuidados": ["", ""]
        };
        var indicacoes = {
            "indicacao": ["ITU", "ITU (Profilaxia)"],
            "dosagemMin": [1.5, 2],
            "dosagemMax": [1.5, 2],
            "intervaloS": ["6/6 horas", "24/24 horas"],
            "intervaloN": [4, 1],
            "doseMaxima": [100, 100],
            "diasTratamento": ["7 dias", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Há grande dificuldade em encontrar a apresentação em solução oral no mercado, fazendo-se necessário sua manipulação."];
        
    }
    
    
    if(atb == "Ceftriaxona") {
    
        var apresentacoes = {
            "apresentacao": ["250mg", "1.000mg"],
            "dosePorMl": [125, 285],
            "diluicao": ["Diluir 1 FA em 2 mL de lidocaína", "Diluir 1 FA em 3.5 mL de ABD"],
            "viaAdministracao": ["IM", "IMV"],
            "unidade": ["mL", "mL"],
            "cuidados": ["", "<br/><br/>Administração IV: Rediluir em 100 mL de SF ou SG e infundir por 30 minutos."]
        };
        var indicacoes = {
            "indicacao": ["Infecções Respiratórias", "Infecções do TGI", "ITU", "Meningite", "Piodermite"],
            "dosagemMin": [50, 50, 50, 100, 50],
            "dosagemMax": [50, 50, 50, 100, 50],
            "intervaloS": ["24/24 horas", "24/24 horas", "24/24 horas", "24/24 horas", "24/24 horas"],
            "intervaloN": [1, 1, 1, 1, 1],
            "doseMaxima": [4000, 4000, 4000, 4000, 4000],
            "diasTratamento": ["7 a 14 dias", "7 a 14 dias", "7 a 14 dias", "7 a 14 dias", "7 a 14 dias"]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade e recém-nascido com hiperbilirrubinemia ou em uso de soluções com cálcio (ex. Ringer Lactato).", "A dose pode ser fracionada e administrada de 12/12 horas.", "Quando administrado por via IM, utilizar a lidocaína como diluente."];
        
    }
    
    
    if(atb == "Ampicilina") {
    
        var apresentacoes = {
            "apresentacao": ["500mg", "1.000mg"],
            "dosePorMl": [250, 333],
            "diluicao": ["Diluir 1 FA em 2 mL de ABD", "Diluir 1 FA em 3 mL de ABD"],
            "viaAdministracao": ["IMV", "IMV"],
            "unidade": ["mL", "mL"],
            "cuidados": ["<br/><br/>Administração IV: Rediluir em 50 mL de SF, SG ou RL e infundir por 15 minutos.", "<br/><br/>Administração IV: Rediluir em 100 mL de SF ou SG e infundir por 30 minutos."]
        };
        var indicacoes = {
            "indicacao": ["Infecções Respiratórias", "Infecções do TGI", "Meningite", "ITU", "Sepse Neonatal"],
            "dosagemMin": [25, 25, 75, 25, 25],
            "dosagemMax": [50, 50, 75, 50, 50],
            "intervaloS": ["6/6 horas", "6/6 horas", "6/6 horas", "6/6 horas", "6/6 horas (RN com > 35 semanas) ou 8/8 horas (RN com < 35 semanas)"],
            "intervaloN": [4, 4, 4, 4, 4],
            "doseMaxima": [3000, 3000, 3000, 3000, 3000],
            "diasTratamento": ["7 a 10 dias", "", "", "7 a 14 dias", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Quando utilizado na sepse neonatal, associar com outro antibiótico (ex. Gentamicina).", "Não deve ser utilizado como primeira escolha para tratamento de piodermites (resistência ao <i>S. aureus</i>)."];
        
    }
    
    
    if(atb == "Gentamicina") {
    
        var apresentacoes = {
            "apresentacao": ["10mg/mL", "20mg/mL", "40mg/mL"],
            "dosePorMl": [10, 20, 40],
            "diluicao": ["", "", ""],
            "viaAdministracao": ["IMV", "IMV", "IMV"],
            "unidade": ["mL", "mL", "mL"],
            "cuidados": ["<br/><br/>Administração IV: Diluir em 100 mL de SF ou SG e infundir por 60 minutos.", "<br/><br/>Administração IV: Diluir em 100 mL de SF ou SG e infundir por 60 minutos.", "<br/><br/>Administração IV: Diluir em 100 mL de SF ou SG e infundir por 60 minutos."]
        };
        var indicacoes = {
            "indicacao": ["Crianças", "Neonatos (< 26 sem.)", "Neonatos (27 a 34 sem.)", "Neonatos (35 a 42 sem.)", "Neonatos (> 43 sem.)"],
            "dosagemMin": [7.5, 2.5, 2.5, 2.5, 2.5],
            "dosagemMax": [7.5, 2.5, 2.5, 2.5, 2.5],
            "intervaloS": ["24/24 horas", "24/24 horas", "18/18 horas", "12/12 horas", "8/8 horas"],
            "intervaloN": [1, 1, 1, 1, 1],
            "doseMaxima": [800, 800, 800, 800, 800],
            "diasTratamento": ["", "", "", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Atentar para o risco de nefrotoxicidade e ototoxicidade, principalmente em neonatos.", "Os níveis séricos desejados são de 5 a 10 mg/mL, devendo ser dosados a partir do 9º dia de tratamento."];
        
    }
    
    
    if(atb == "Amicacina") {
    
        var apresentacoes = {
            "apresentacao": ["100mg/2mL", "500mg/2mL"],
            "dosePorMl": [50, 250],
            "diluicao": ["", ""],
            "viaAdministracao": ["IMV", "IMV"],
            "unidade": ["mL", "mL"],
            "cuidados": ["<br/><br/>Administração IV: Rediluir em 100 mL de SF ou SG e infundir por 60 minutos.", "<br/><br/>Administração IV: Rediluir em 100 mL de SF ou SG e infundir por 60 minutos."]
        };
        var indicacoes = {
            "indicacao": ["Crianças", "Neonatos (< 26 sem.)", "Neonatos (27 a 34 sem.)", "Neonatos (35 a 42 sem.)", "Neonatos (> 43 sem.)"],
            "dosagemMin": [15, 7.5, 7.5, 10, 10],
            "dosagemMax": [15, 7.5, 7.5, 10, 10],
            "intervaloS": ["24/24 horas", "24/24 horas", "18/18 horas", "12/12 horas", "8/8 horas"],
            "intervaloN": [1, 1, 1, 2, 3],
            "doseMaxima": [1000, 1000, 1000, 1000, 1000],
            "diasTratamento": ["", "", "", "", ""]
        };
        var contraindicacoes = ["Contra-indicado em pacientes com hipersensibilidade.", "Atentar para o risco de nefrotoxicidade e ototoxicidade, principalmente em neonatos.", "Os níveis séricos desejados são de 20 a 30 mg/mL, devendo ser dosados a partir do 9º dia de tratamento."];
        
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
        
        
        // ######
        // Preculariedades (INÍCIO)
        // ######
        
        if(atb == "Amoxicilina" && i == 1) {
            if(codIndicacao == 0) {
                var2 = ((peso * 25)/80);   
            } else {
                var2 = ((peso * 45)/80);
            }
            var2 = Math.round(var2*2)/2;
                if(var2 > 11) { var2 = 11; }
            var3 = "12/12 horas";
        }
        
        if(atb == "Penicilina Benzatina" && codIndicacao == 0 && peso < 25) {
            var2 = 2;
            if(i == 1) { continue; }
        }
        if(atb == "Penicilina Benzatina" && codIndicacao == 0 && peso >= 25) {
            var2 = 2;
            if(i == 0) { continue; }
        }
        if(atb == "Penicilina Benzatina" && codIndicacao == 1 && peso <= 12) {
            adm = "Diluir em 3 mL de ABD e administrar ";
            cuidados = "Deve ser realizado no período neonatal e o acompanhamento é obrigatório!"
            if(i == 1) { continue; }
        }
        if(atb == "Penicilina Benzatina" && codIndicacao == 1 && peso > 12) {
            var2 = 0;
            if(i == 1) { continue; }
        }
        
        if(atb == "Penicilina Procaína" && peso > 6) {
            adm = "Diluir 2 FA em 3 mL de ABD e administrar ";
            var2 = ((peso * 50000)/200000);
            var2 = Number((var2).toFixed(1));
                if(var2 > 3) { var2 = 3; }
        }
        
        if(atb == "Ampicilina" && varX > 0) {
            varX = Number((varX).toFixed(1));
            var2 = var2 + " mL a " + varX;
        }
        
        if(atb == "Penicilina Cristalina" && varX > 0) {
            varX = Number((varX).toFixed(1));
            var2 = var2 + " mL a " + varX;
        }
        
        if(atb == "Amicacina" && peso < 3 && i == 1 && (codIndicacao == 1 || codIndicacao == 2)) { var2 = 0; }
        if(atb == "Amicacina" && peso < 2 && i == 1 && (codIndicacao == 3 || codIndicacao == 4)) { var2 = 0; }
        
        if(atb == "Amicacina") {
            if(i == 0 && var2 > 2) { 
                und = und + numAmpolas(var2, 2, 1); 
            }
            if(i == 1 && var2 > 2) { und = und + numAmpolas(var2, 2, 1); }
        }
        
        //if(atb == "Ceftriaxona" && i == 0 && var2 > 2) { und = und + numAmpolas(var2, 2, 2); }
        //if(atb == "Ceftriaxona" && i == 1 && var2 > 3.5) { und = und + numAmpolas(var2, 3.5, 2); }
        
        if(atb == "Gentamicina") { und = und + numAmpolas(var2, 1, 1); } 
        
        // ######
        // Preculariedades (FIM)
        // ######
        
        
        if(var2 == 0) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + atb + ' ' + var1 + '</span> - Apresentação não indicada para a dose/peso.</p></li>';
        } else if(var2 == null) {
            returnApresentacoes = returnApresentacoes + '<li class="inutil"><i class="fas fa-' + var6 + '"></i><p><span>' + atb + ' ' + var1 + '</span> - Esta apresentação não é uma boa indicação pelo sub-dose ou super-dose.</p></li>';
        } else {
            if (var3 == "") {
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + atb + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em dose única, ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
            } else {
                returnApresentacoes = returnApresentacoes + '<li><i class="fas fa-' + var6 + '"></i><p><span>' + atb + ' ' + var1 + '</span> - ' + adm + var2 + ' ' + und + ', em intervalos de ' + var3 + ', ' + time + 'por ' + var4 + '. ' + cuidados + '</p></li>';
            }
        }
        
    }
        
    
    //  Processamento das Indicações
    for (i = 0; i < Object.keys(indicacoes["indicacao"]).length; ++i) {
        var1 = indicacoes["indicacao"][i];
        if(indicacoes["dosagemMin"][i] == indicacoes["dosagemMax"][i]) {
            var6 = Math.round(indicacoes["dosagemMin"][i]*indicacoes["intervaloN"][i]) + " mg/kg/dia";    
        } else {
            var6 = (indicacoes["dosagemMin"][i]*indicacoes["intervaloN"][i]) + " a " + (indicacoes["dosagemMax"][i]*indicacoes["intervaloN"][i]) + " mg/kg/dia";
        }
        
        if(i == codIndicacao) { active = " class='active'"; } else { active = ""; }
        
        link = "javascript:alterarDose('" + atb + "', " + peso + ", " + i + ");";
        
        
        // ######
        // Preculariedades
        // ######
        if(atb == "Penicilina Cristalina" || atb == "Penicilina Procaína") { var5 = "UI"; } else { var5 = "mg"; }
        if(atb == "Penicilina Cristalina" && i == 5) { var6 = "50.000 UI/kg/dose"; }
        if(atb == "Penicilina Benzatina" && i == 0 && peso < 25) { var6 = "600.000 UI"; }
        if(atb == "Penicilina Benzatina" && i == 0 && peso >= 25) { var6 = "1.200.000 UI"; }
        if(atb == "Penicilina Benzatina" && i == 1) { var6 = "50.000 UI"; }
        if(atb == "Gentamicina" && i == 0) { var6 = "7.5 mg/kg/dia"; }
        if(atb == "Gentamicina" && (i == 1 || i == 2 || i == 3 || i == 4)) { var6 = "2.5 mg/kg/dose"; }
        if(atb == "Amicacina" && i == 0) { var6 = "15 mg/kg/dia"; }
        if(atb == "Amicacina" && (i == 1 || i == 2)) { var6 = "7.5 mg/kg/dose"; }
        if(atb == "Amicacina" && (i == 3 || i == 4)) { var6 = "10 mg/kg/dose"; }
        
        returnIndicacoes = returnIndicacoes + '<li' + active + '><a href="' + link + '">' + var1 + '<span>' + var6 + '</span></a></li>';
    }    
        
    
    //  Processamento das Contra-Indicações
    for (i = 0; i < Object.keys(contraindicacoes).length; ++i) {
        returnContraIndicacoes = returnContraIndicacoes + '<li><span>' + contraindicacoes[i] + '</span></li>';
    }
    
    
    //  Finalização!
    return [returnApresentacoes, returnIndicacoes, returnContraIndicacoes];
    
    
}