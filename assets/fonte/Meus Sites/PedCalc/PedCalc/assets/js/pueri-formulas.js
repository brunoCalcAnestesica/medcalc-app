function lerFormula (tipo, i) {
    
    var formulasPartida = {
        "nomeComercial": ["Nan Supreme 1", "Nan Comfor 1", "Nestogeno 1", "Aptamil Premium 1", "Milupa 1"],
        "precoMedio": [53, 41, 34, 38, 29],
        "marca": ["NESTLÉ", "NESTLÉ", "NESTLÉ", "DANONE", "DANONE"],
        "imagem": ["nan1-supreme", "nan1-comfor", "nestogeno1", "aptamil1", "milupa1"],
    }
    
    var NanSupreme1 = ["Proteína: 1.3g/100mL", "Carboidrato: 7.9g/100mL", "100% Lactose", "Lipídio: 3.4g/100mL", "DHA/ARA", "Nucleotídeos", "Proteína Nestlé® (parcialmente hidrolisada)"];
    var NanComfor1 = ["Proteína: 1.2g/100mL", "Carboidrato: 7.2g/100mL", "100% Lactose", "Lipídio: 3.7g/100mL", "DHA/ARA", "Nucleotídeos", "Prebióticos"];
    var Nestogeno1 = ["Proteína: 1.4g/100mL", "Carboidrato: 7.6g/100mL", "70% Lactose", "Lipídio: 3.4g/100mL"];
    var Aptamil1 = ["Proteína: 1.3g/100mL", "Carboidrato: 7.3g/100mL", "100% Lactose", "Lipídio: 3.5g/100mL", "DHA/ARA", "Nucleotídeos", "Prebióticos"];
    var Milupa1 = ["Proteína: 1.4g/100mL", "Carboidrato: 7.5g/100mL", "100% Lactose", "Lipídio: 3.5g/100mL", "Ômega 3/6"];
    
    
    
    var formulasPrematuro = {
        "nomeComercial": ["Pre NAN", "Aptamil Pre"],
        "precoMedio": [110, 70],
        "marca": ["NESTLÉ", "DANONE"],
        "imagem": ["nan-pre", "aptamil-pre"],
    }
    
    var PreNan = ["Proteína: 2.3g/100mL", "Carboidrato: 8.6g/100mL", "50% Lactose", "Lipídio: 4.2g/100mL", "DHA/ARA", "Nucleotídeos", "Baixa Osmolaridade"];
    var AptamilPre = ["Proteína: 2.2g/100mL", "Carboidrato: 7.6g/100mL", "82% Lactose", "Lipídio: 4.4g/100mL", "DHA/ARA", "Nucleotídeos", "Prébióticos"];
    
    
    
    var formulasAR = {
        "nomeComercial": ["NAN AR", "Aptamil AR"],
        "precoMedio": [42, 44],
        "marca": ["NESTLÉ", "DANONE"],
        "imagem": ["nan-ar", "aptamil-ar"],
    }
    
    var NanAR = ["Proteína: 1.2g/100mL", "Carboidrato: 7.6g/100mL", "Amido pré-gelatinizado", "Lipídio: 3.5g/100mL", "DHA/ARA", "Baixa Osmolaridade"];
    var AptamilAR = ["Proteína: 1.7g/100mL", "Carboidrato: 8.1g/100mL", "Goma Jantaí", "Lipídio: 3.1g/100mL", "Ômega 3/6"];
    
    
    
    var formulasHA = {
        "nomeComercial": ["NAN H.A.", "Aptamil H.A."],
        "precoMedio": [38, 35],
        "marca": ["NESTLÉ", "DANONE"],
        "imagem": ["nan-ha", "aptamil-ha"],
    }
    
    var NanHA = ["Proteína: 1.3g/100mL", "Carboidrato: 7.8g/100mL", "100% Lactose", "Lipídio: 3.4g/100mL", "DHA/ARA", "Nucleotídeos", "Proteína Nestlé® (parcialmente hidrolisada)"];
    var AptamilHA = ["Proteína: 1.5g/100mL", "Carboidrato: 7.2g/100mL", "100% Lactose", "Lipídio: 3.4g/100mL", "DHA/ARA", "Nucleotídeos", "Prebióticos", "Proteína Parcialmente Hidrolisada"];
    
    
    
    var formulasSoja = {
        "nomeComercial": ["NAN Soy", "Aptamil Soja 2"],
        "precoMedio": [70, 62],
        "marca": ["NESTLÉ", "DANONE"],
        "imagem": ["nan-soy", "aptamil-soja"],
    }
    
    var NanSoy = ["Proteína: 1.8g/100mL", "Carboidrato: 7.3g/100mL", "100% Maltodextrina", "Lipídio: 3.4g/100mL", "DHA/ARA"];
    var AptamilSoja = ["Proteína: 1.7g/100mL", "Carboidrato: 8.1g/100mL", "100% Maltodextrina", "Lipídio: 3.2g/100mL", "Ômega 3/6"];
    
    
    
    var formulasSeguimento = {
        "nomeComercial": ["Nan Supreme 2", "Nan Comfor 2", "Nestogeno 2", "Aptamil Premium 2", "Milupa 2"],
        "precoMedio": [50, 37, 31, 36, 28],
        "marca": ["NESTLÉ", "NESTLÉ", "NESTLÉ", "DANONE", "DANONE"],
        "imagem": ["nan2-supreme", "nan2-comfor", "nestogeno2", "aptamil2", "milupa2"],
    }
    
    var NanSupreme2 = ["Proteína: 1.5g/100mL", "Carboidrato: 8.3g/100mL", "100% Lactose", "Lipídio: 3.1g/100mL", "DHA/ARA", "Nucleotídeos", "Proteína Nestlé® (parcialmente hidrolisada)"];
    var NanComfor2 = ["Proteína: 1.3g/100mL", "Carboidrato: 8.4g/100mL", "83% Lactose", "Lipídio: 3.0g/100mL", "DHA/ARA", "Nucleotídeos", "Prebióticos"];
    var Nestogeno2 = ["Proteína: 2.1g/100mL", "Carboidrato: 7.9g/100mL", "70% Lactose", "Lipídio: 3.1g/100mL"];
    var Aptamil2 = ["Proteína: 2.0g/100mL", "Carboidrato: 7.9g/100mL", "100% Lactose", "Lipídio: 3.1g/100mL", "DHA/ARA", "Nucleotídeos", "Prebióticos"];
    var Milupa2 = ["Proteína: 2.0g/100mL", "Carboidrato: 7.9g/100mL", "84% Lactose", "Lipídio: 3.1g/100mL"];
    
    
    
    var nomeComercial, idade, precoMedio, marca, imagem, numFormulas, info;
    
    
    
    if(tipo == "partida") {
        nomeComercial = formulasPartida["nomeComercial"][i];
        idade =  "0 - 6<br/><span>MESES</span>";
        precoMedio = "R$ " + formulasPartida["precoMedio"][i] + "<br/><span>PREÇO MÉDIO</span>";
        marca = formulasPartida["marca"][i] + "<br/><span>MARCA</span>";
        imagem = "<img src='assets/imagens/formulas/" + formulasPartida["imagem"][i] + ".jpg' />";
        numFormulas = formulasPartida["nomeComercial"].length;
        
        switch(nomeComercial) {
            case "Nan Supreme 1":
                info = NanSupreme1; break;
            case "Nan Pro 1":
                info = NanPro1; break;
            case "Nan Comfor 1":
                info = NanComfor1; break;
            case "Nestogeno 1":
                info = Nestogeno1; break;
            case "Aptamil Premium 1":
                info = Aptamil1; break;
            case "Milupa 1":
                info = Milupa1; break;
        }
    }
    
    if(tipo == "seguimento") {
        nomeComercial = formulasSeguimento["nomeComercial"][i];
        idade =  "ACIMA DE 6<br/><span>MESES</span>";
        precoMedio = "R$ " + formulasSeguimento["precoMedio"][i] + "<br/><span>PREÇO MÉDIO</span>";
        marca = formulasSeguimento["marca"][i] + "<br/><span>MARCA</span>";
        imagem = "<img src='assets/imagens/formulas/" + formulasSeguimento["imagem"][i] + ".jpg' />";
        numFormulas = formulasSeguimento["nomeComercial"].length;
        
        switch(nomeComercial) {
            case "Nan Supreme 2":
                info = NanSupreme2; break;
            case "Nan Pro 2":
                info = NanPro2; break;
            case "Nan Comfor 2":
                info = NanComfor2; break;
            case "Nestogeno 2":
                info = Nestogeno2; break;
            case "Aptamil Premium 2":
                info = Aptamil2; break;
            case "Milupa 2":
                info = Milupa2; break;
        }
    }
    
    if(tipo == "prematuro") {
        nomeComercial = formulasPrematuro["nomeComercial"][i];
        idade =  "PREMATUROS<br/><span>BAIXO PESO</span>";
        precoMedio = "R$ " + formulasPrematuro["precoMedio"][i] + "<br/><span>PREÇO MÉDIO</span>";
        marca = formulasPrematuro["marca"][i] + "<br/><span>MARCA</span>";
        imagem = "<img src='assets/imagens/formulas/" + formulasPrematuro["imagem"][i] + ".jpg' />";
        numFormulas = formulasPrematuro["nomeComercial"].length;
        
        switch(nomeComercial) {
            case "Pre NAN":
                info = PreNan; break;
            case "Aptamil Pre":
                info = AptamilPre; break;
        }
    }
    
    if(tipo == "ar") {
        nomeComercial = formulasAR["nomeComercial"][i];
        idade =  "0 - 24<br/><span>MESES</span>";
        precoMedio = "R$ " + formulasAR["precoMedio"][i] + "<br/><span>PREÇO MÉDIO</span>";
        marca = formulasAR["marca"][i] + "<br/><span>MARCA</span>";
        imagem = "<img src='assets/imagens/formulas/" + formulasAR["imagem"][i] + ".jpg' />";
        numFormulas = formulasAR["nomeComercial"].length;
        
        switch(nomeComercial) {
            case "NAN AR":
                info = NanAR; break;
            case "Aptamil AR":
                info = AptamilAR; break;
        }
    }
    
    if(tipo == "soja") {
        nomeComercial = formulasSoja["nomeComercial"][i];
        idade =  "ACIMA DE 6<br/><span>MESES</span>";
        precoMedio = "R$ " + formulasSoja["precoMedio"][i] + "<br/><span>PREÇO MÉDIO</span>";
        marca = formulasSoja["marca"][i] + "<br/><span>MARCA</span>";
        imagem = "<img src='assets/imagens/formulas/" + formulasSoja["imagem"][i] + ".jpg' />";
        numFormulas = formulasSoja["nomeComercial"].length;
        
        switch(nomeComercial) {
            case "NAN Soy":
                info = NanSoy; break;
            case "Aptamil Soja 2":
                info = AptamilSoja; break;
        }
    }
    
    if(tipo == "ha") {
        nomeComercial = formulasHA["nomeComercial"][i];
        idade =  "0 - 24<br/><span>MESES</span>";
        precoMedio = "R$ " + formulasHA["precoMedio"][i] + "<br/><span>PREÇO MÉDIO</span>";
        marca = formulasHA["marca"][i] + "<br/><span>MARCA</span>";
        imagem = "<img src='assets/imagens/formulas/" + formulasHA["imagem"][i] + ".jpg' />";
        numFormulas = formulasHA["nomeComercial"].length;
        
        switch(nomeComercial) {
            case "NAN H.A.":
                info = NanHA; break;
            case "Aptamil H.A.":
                info = AptamilHA; break;
        }
    }
    
    
    
    return [nomeComercial, idade, precoMedio, marca, imagem, info, numFormulas];
    
    
    
}