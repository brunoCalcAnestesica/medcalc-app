//Proibir entrada de números no Input
            function isNumberKey(evt, obj) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                var value = obj.value;
                var dotcontains = value.indexOf(".") != -1;
                if (dotcontains)
                if (charCode == 46) return false;
                if (charCode == 46) return true;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }

//VERIFICAR DATA
function qtdeDias(dataInput) {
    var data = dataInput.split("/");
    data = new Date(data[2], data[1] - 1, data[0]);
     
    var start = data;
    var end = new Date();
    
    var qtde = new Date(end - start);
        qtde = Math.floor(qtde / 86400000);
    
    return qtde;
}

function suplementacao(idade, peso, maturidade, pesoAoNascer, pesoAoNascer2) {
    
    //Arrays com Vitaminas
    
    var vitaminaA = {
        "idadeInicio": [183, 366],
        "idadeFim": [365, 2190],
        "pesoMinimo": [null, null],
        "dosePreconizada": ["100.000 UI", "200.000 UI"],
        "doseUnica": [true, true],
        "dosePorKg": [1, 1]
    };
    
    var vitaminaD = {
        "idadeInicio": [7, 366],
        "idadeFim": [365, 730],
        "pesoMinimo": [1.5, null],
        "dosePreconizada": ["200 UI/gota", "200 UI/gota"],
        "doseUnica": [true, true],
        "dosePorKg": [2, 3]
    };
    
    var ferro = {
        "idadeInicio": [90],
        "idadeFim": [730],
        "pesoMinimo": [0.5, null],
        "dosePreconizada": ["400 UI/dia", "600 UI/dia"],
        "doseUnica": [true, true],
        "dosePorKg": [3, 4]
    };
    
    var zinco = {
        "idadeInicio": [7],
        "idadeFim": [180],
        "pesoMinimo": [null],
        "dosePreconizada": ["2 mL/dia"],
        "doseUnica": [true],
        "dosePorKg": [1]
    };
    
    peso = peso / 1000;
    
    //Analise do Ferro
    var resFerro = null;
    var resZinco = null;
    if(maturidade == "RNPT") {
        
        if(pesoAoNascer > 2500) {
            if(idade >= 90 && idade <= 730) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até completar 2 anos de idade. A dose deve ser reajustada de acordo com o peso.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até completar 2 anos de idade. A dose deve ser reajustada de acordo com o peso.</li>";
            } else {
                resFerro = null;
            }
        } else if(pesoAoNascer >= 1500 && pesoAoNascer <= 2500) {
            
            if(idade >= 30 && idade <= 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 2) + " gotas (2 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 2) + " gotas (2 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
            } else if(idade > 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade.</li>";
            } else {
                resFerro = null;
            }
            
            
        } else if(pesoAoNascer >= 1000 && pesoAoNascer < 1500) {
            
            if(idade >= 30 && idade <= 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 3) + " gotas (3 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 3) + " gotas (3 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
            } else if(idade > 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade.</li>";
            } else {
                resFerro = null;
            }
            
        } else if(pesoAoNascer < 1000) {
            
            if(idade >= 30 && idade <= 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 4) + " gotas (4 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 4) + " gotas (4 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
            } else if(idade > 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade.</li>";
            } else {
                resFerro = null;
            }
            
        }
        
        //ZINCO
        if(idade >= 7 && idade <= 180 && pesoAoNascer <= 1500) {
            resZinco = "<li><b>Sulfato de Zinco 4mg/mL -</b> Dar 1.25 mL (5 mg/dia), próximo ao almoço, até 6 meses de vida.</li>";
        } else {
            resZinco = null;
        }
        
        //VITAMINA A+D
        if(idade >= 7 && idade <= 730) {
            var resVitaminaA = "<li><b>Vitamina A + D </b>- Dar 2 gotas, próximo ao almoço, até completar 2 anos de idade. Depois, manter suplementação apenas da Vitamina A com superdoses (esquema do RNT).";
        } else if (idade > 730 && idade <= 2190) {
            var resVitaminaA = "<li><b>Vitamina A 200.000 UI (megadose) </b>- Dar o conteúdo de 1 cápsula, disponibilizada na APS, em intervalos de 6/6 meses até completar 5 anos de idade (59 meses).</li><li>Não há mais necessidade de suplementação da Vitamina D.</li>";
        } else {
            var resVitaminaA = null;
        }
        
        //VITAMINA C
        if(idade >= 7 && idade <= 40) {
            var resVitaminaD = "<li><b>Vitamina C 200mg/mL</b>- Dar 5 gotas, próximo ao almoço, até completar 40 dias de vida. Após este período, a necessidade diária é atingida pelo aleitamento materno ou uso de fórmulas infantis.";
        } else {
            var resVitaminaD = null;
        }
        
    } else {
        
        if(pesoAoNascer2 != null) {
            if(idade >= 30 && idade < 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 2) + " gotas (2 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 2) + " gotas (2 mg/kg/dia), próximo ao almoço, até 1 ano de idade. A dose deve ser reajustada de acordo com o peso. Após este período, manter com 1 mg/kg/dia por até 2 anos de idade.</li>";
            } else if (idade >= 365) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade. A dose deve ser reajustada de acordo com o peso.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até 2 anos de idade. A dose deve ser reajustada de acordo com o peso.</li>";
            } else {
                resFerro = null;
            }
        } else {
            if(idade >= 90 && idade <= 730) {
                resFerro = "<li><b>Sulfato Ferroso 125mg/mL -</b> Dar " + Math.round((peso * 0.8) * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até completar 2 anos de idade. A dose deve ser reajustada de acordo com o peso.</li>";
                resFerro = resFerro + "<li><b>Ferripolimaltose 50mg/mL -</b> Dar " + Math.round(peso * 1) + " gotas (1 mg/kg/dia), próximo ao almoço, até completar 2 anos de idade. A dose deve ser reajustada de acordo com o peso.</li>";
            } else {
                resFerro = null;
            }
        }
        
        for (var i = 0; i < Object.keys(vitaminaA["idadeInicio"]).length; ++i) {
    
        if(idade >= vitaminaA["idadeInicio"][i] && idade <= vitaminaA["idadeFim"][i]) {
            
            if(idade <= 365) { 
                var resVitaminaA = "<li><b>Vitamina A " + vitaminaA["dosePreconizada"][i] + " (megadose) </b>- Dar o conteúdo de 1 cápsula, disponibilizada na APS, em dose única até a idade máxima de 1 ano. Após 1 ano de idade, aumentar para 200.000 UI, a cada 6 meses, até 4 anos e 11 meses (59 meses).</li>";
            } else {
                var resVitaminaA = "<li><b>Vitamina A " + vitaminaA["dosePreconizada"][i] + " (megadose) </b>- Dar o conteúdo de 1 cápsula, disponibilizada na APS, em intervalos de 6/6 meses até completar 5 anos de idade (59 meses).</li>";
            }
            
            i = (Object.keys(vitaminaA["idadeInicio"]).length) + 1000;
            
        } else {
            
            var resVitaminaA = null;
            
        }
        
    }
    
    for (i = 0; i < Object.keys(vitaminaD["idadeInicio"]).length; ++i) {
    
        if(idade >= vitaminaD["idadeInicio"][i] && idade <= vitaminaD["idadeFim"][i]) {
            
            if(vitaminaD["pesoMinimo"][i] != null) {
                
                if(peso < vitaminaD["pesoMinimo"][i]) {
                    
                    var resVitaminaD = null;
   
                } else {
                
                    if(vitaminaD["doseUnica"][i] == true) {
                        if(idade <= 365) { 
                            var msgFinal1 = "(400 UI), todos os dias, até os 12 meses de vida."; 
                            var msgFinal2 = "<br/><span style='font-style: italic; font-size: 12px;'>A partir de 1 ano de idade, aumentar para 3 gotas/dia (600 UI).</span>"; 
                        } else {
                            var msgFinal1 = "(600 UI), todos os dias, até os 2 anos de idade."; 
                            var msgFinal2 = ""; 
                        }
                        var resVitaminaD = "<li><b>Vitamina D " + vitaminaD["dosePreconizada"][i] + "</b> - Dar " + vitaminaD["dosePorKg"][i] + " gotas " + msgFinal1 + msgFinal2 + "</li>";
                    } 
                
                }
            
            } else {
                
                if(vitaminaD["doseUnica"][i] == true) {
                    if(idade <= 365) { 
                        var msgFinal1 = "(400 UI), todos os dias, até os 12 meses de vida."; 
                        var msgFinal2 = "<br/><span style='font-style: italic; font-size: 12px;'>A partir de 1 ano de idade, aumentar para 3 gotas/dia (600 UI).</span>"; 
                    } else {
                        var msgFinal1 = "(600 UI), todos os dias, até os 2 anos de idade."; 
                        var msgFinal2 = ""; 
                    }
                    var resVitaminaD = "<li><b>Vitamina D " + vitaminaD["dosePreconizada"][i] + "</b> - Dar " + vitaminaD["dosePorKg"][i] + " gotas " + msgFinal1 + msgFinal2 + "</li>";
                } 
                
            }
            
            i = (Object.keys(vitaminaD["idadeInicio"]).length) + 1000;
            
        } else {
            
            var resVitaminaD = null;
            
        }
        
    }
        
    }
    
    
    //For com pesquisa
    
    
    //Retorno Final
    return [resVitaminaA, resVitaminaD, resFerro, resZinco];
    
}