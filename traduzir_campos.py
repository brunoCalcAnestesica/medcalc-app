#!/usr/bin/env python3
import json
import re
from pathlib import Path

# Mapeamento de traduções
traducoes = {
    # Campos estruturais
    "titulo": "titulo",
    "definicao": "definicao", 
    "epidemiologia": "epidemiologia",
    "fisiopatologia": "fisiopatologia",
    "sinais_e_sintomas": "sinais_e_sintomas",
    "diagnostico": "diagnostico",
    "avaliacao_clinica": "avaliacao_clinica",
    "exames_complementares": "exames_complementares",
    "tratamento": "tratamento",
    "abordagem_inicial": "abordagem_inicial",
    "medicamentos_uso_comum": "medicamentos_uso_comum",
    "nome": "nome",
    "uso": "uso",
    "prognostico": "prognostico",
    "comentario": "comentario",
    "fontes_bibliograficas": "fontes_bibliograficas",
    
    # Doses
    "dose_mg_kg": "dose_mg_kg",
    "dose_mcg_kg": "dose_mcg_kg", 
    "dose_mcg_kg_min": "dose_mcg_kg_min",
    "dose_g_6_6h": "dose_g_6_6h",
    "dose_mg_6_6h": "dose_mg_6_6h",
    "dose_mg_8_8h": "dose_mg_8_8h",
    "dose_mg_12_12h": "dose_mg_12_12h",
    "dose_mg_24_24h": "dose_mg_24_24h",
    "dose_mg_bolus": "dose_mg_bolus",
    "dose_mcg_bolus": "dose_mcg_bolus",
    "dose_mg_min": "dose_mg_min",
    "dose_mcg_min": "dose_mcg_min",
    "dose_ml_kg": "dose_ml_kg",
    "dose_ml_min": "dose_ml_min",
    "dose_ml_h": "dose_ml_h",
    "dose_ui_kg": "dose_ui_kg",
    "dose_ui_min": "dose_ui_min",
    "dose_ui_h": "dose_ui_h",
    "dose_mg_kg_min": "dose_mg_kg_min",
    "dose_mcg_kg_h": "dose_mcg_kg_h",
    "dose_mg_kg_h": "dose_mg_kg_h",
    "dose_ml_kg_h": "dose_ml_kg_h",
    "dose_ui_kg_h": "dose_ui_kg_h",
    "dose_mg_kg_bolus": "dose_mg_kg_bolus",
    "dose_mcg_kg_bolus": "dose_mcg_kg_bolus",
    "dose_ml_kg_bolus": "dose_ml_kg_bolus",
    "dose_ui_kg_bolus": "dose_ui_kg_bolus",
    "dose_mg_kg_min_manutencao": "dose_mg_kg_min_manutencao",
    "dose_mcg_kg_min_manutencao": "dose_mcg_kg_min_manutencao",
    "dose_ml_kg_min_manutencao": "dose_ml_kg_min_manutencao",
    "dose_ui_kg_min_manutencao": "dose_ui_kg_min_manutencao",
    "dose_mg_kg_h_manutencao": "dose_mg_kg_h_manutencao",
    "dose_mcg_kg_h_manutencao": "dose_mcg_kg_h_manutencao",
    "dose_ml_kg_h_manutencao": "dose_ml_kg_h_manutencao",
    "dose_ui_kg_h_manutencao": "dose_ui_kg_h_manutencao",
    "dose_mg_kg_bolus_manutencao": "dose_mg_kg_bolus_manutencao",
    "dose_mcg_kg_bolus_manutencao": "dose_mcg_kg_bolus_manutencao",
    "dose_ml_kg_bolus_manutencao": "dose_ml_kg_bolus_manutencao",
    "dose_ui_kg_bolus_manutencao": "dose_ui_kg_bolus_manutencao",
    "dose_mg_kg_min_manutencao_2": "dose_mg_kg_min_manutencao_2",
    "dose_mcg_kg_min_manutencao_2": "dose_mcg_kg_min_manutencao_2",
    "dose_ml_kg_min_manutencao_2": "dose_ml_kg_min_manutencao_2",
    "dose_ui_kg_min_manutencao_2": "dose_ui_kg_min_manutencao_2",
    "dose_mg_kg_h_manutencao_2": "dose_mg_kg_h_manutencao_2",
    "dose_mcg_kg_h_manutencao_2": "dose_mcg_kg_h_manutencao_2",
    "dose_ml_kg_h_manutencao_2": "dose_ml_kg_h_manutencao_2",
    "dose_ui_kg_h_manutencao_2": "dose_ui_kg_h_manutencao_2",
    "dose_mg_kg_bolus_manutencao_2": "dose_mg_kg_bolus_manutencao_2",
    "dose_mcg_kg_bolus_manutencao_2": "dose_mcg_kg_bolus_manutencao_2",
    "dose_ml_kg_bolus_manutencao_2": "dose_ml_kg_bolus_manutencao_2",
    "dose_ui_kg_bolus_manutencao_2": "dose_ui_kg_bolus_manutencao_2",
    "dose_mg_kg_min_manutencao_3": "dose_mg_kg_min_manutencao_3",
    "dose_mcg_kg_min_manutencao_3": "dose_mcg_kg_min_manutencao_3",
    "dose_ml_kg_min_manutencao_3": "dose_ml_kg_min_manutencao_3",
    "dose_ui_kg_min_manutencao_3": "dose_ui_kg_min_manutencao_3",
    "dose_mg_kg_h_manutencao_3": "dose_mg_kg_h_manutencao_3",
    "dose_mcg_kg_h_manutencao_3": "dose_mcg_kg_h_manutencao_3",
    "dose_ml_kg_h_manutencao_3": "dose_ml_kg_h_manutencao_3",
    "dose_ui_kg_h_manutencao_3": "dose_ui_kg_h_manutencao_3",
    "dose_mg_kg_bolus_manutencao_3": "dose_mg_kg_bolus_manutencao_3",
    "dose_mcg_kg_bolus_manutencao_3": "dose_mcg_kg_bolus_manutencao_3",
    "dose_ml_kg_bolus_manutencao_3": "dose_ml_kg_bolus_manutencao_3",
    "dose_ui_kg_bolus_manutencao_3": "dose_ui_kg_bolus_manutencao_3",
    "dose_mg_kg_min_manutencao_4": "dose_mg_kg_min_manutencao_4",
    "dose_mcg_kg_min_manutencao_4": "dose_mcg_kg_min_manutencao_4",
    "dose_ml_kg_min_manutencao_4": "dose_ml_kg_min_manutencao_4",
    "dose_ui_kg_min_manutencao_4": "dose_ui_kg_min_manutencao_4",
    "dose_mg_kg_h_manutencao_4": "dose_mg_kg_h_manutencao_4",
    "dose_mcg_kg_h_manutencao_4": "dose_mcg_kg_h_manutencao_4",
    "dose_ml_kg_h_manutencao_4": "dose_ml_kg_h_manutencao_4",
    "dose_ui_kg_h_manutencao_4": "dose_ui_kg_h_manutencao_4",
    "dose_mg_kg_bolus_manutencao_4": "dose_mg_kg_bolus_manutencao_4",
    "dose_mcg_kg_bolus_manutencao_4": "dose_mcg_kg_bolus_manutencao_4",
    "dose_ml_kg_bolus_manutencao_4": "dose_ml_kg_bolus_manutencao_4",
    "dose_ui_kg_bolus_manutencao_4": "dose_ui_kg_bolus_manutencao_4",
    "dose_mg_kg_min_manutencao_5": "dose_mg_kg_min_manutencao_5",
    "dose_mcg_kg_min_manutencao_5": "dose_mcg_kg_min_manutencao_5",
    "dose_ml_kg_min_manutencao_5": "dose_ml_kg_min_manutencao_5",
    "dose_ui_kg_min_manutencao_5": "dose_ui_kg_min_manutencao_5",
    "dose_mg_kg_h_manutencao_5": "dose_mg_kg_h_manutencao_5",
    "dose_mcg_kg_h_manutencao_5": "dose_mcg_kg_h_manutencao_5",
    "dose_ml_kg_h_manutencao_5": "dose_ml_kg_h_manutencao_5",
    "dose_ui_kg_h_manutencao_5": "dose_ui_kg_h_manutencao_5",
    "dose_mg_kg_bolus_manutencao_5": "dose_mg_kg_bolus_manutencao_5",
    "dose_mcg_kg_bolus_manutencao_5": "dose_mcg_kg_bolus_manutencao_5",
    "dose_ml_kg_bolus_manutencao_5": "dose_ml_kg_bolus_manutencao_5",
    "dose_ui_kg_bolus_manutencao_5": "dose_ui_kg_bolus_manutencao_5",
    "dose_mg_kg_min_manutencao_6": "dose_mg_kg_min_manutencao_6",
    "dose_mcg_kg_min_manutencao_6": "dose_mcg_kg_min_manutencao_6",
    "dose_ml_kg_min_manutencao_6": "dose_ml_kg_min_manutencao_6",
    "dose_ui_kg_min_manutencao_6": "dose_ui_kg_min_manutencao_6",
    "dose_mg_kg_h_manutencao_6": "dose_mg_kg_h_manutencao_6",
    "dose_mcg_kg_h_manutencao_6": "dose_mcg_kg_h_manutencao_6",
    "dose_ml_kg_h_manutencao_6": "dose_ml_kg_h_manutencao_6",
    "dose_ui_kg_h_manutencao_6": "dose_ui_kg_h_manutencao_6",
    "dose_mg_kg_bolus_manutencao_6": "dose_mg_kg_bolus_manutencao_6",
    "dose_mcg_kg_bolus_manutencao_6": "dose_mcg_kg_bolus_manutencao_6",
    "dose_ml_kg_bolus_manutencao_6": "dose_ml_kg_bolus_manutencao_6",
    "dose_ui_kg_bolus_manutencao_6": "dose_ui_kg_bolus_manutencao_6",
    "dose_mg_kg_min_manutencao_7": "dose_mg_kg_min_manutencao_7",
    "dose_mcg_kg_min_manutencao_7": "dose_mcg_kg_min_manutencao_7",
    "dose_ml_kg_min_manutencao_7": "dose_ml_kg_min_manutencao_7",
    "dose_ui_kg_min_manutencao_7": "dose_ui_kg_min_manutencao_7",
    "dose_mg_kg_h_manutencao_7": "dose_mg_kg_h_manutencao_7",
    "dose_mcg_kg_h_manutencao_7": "dose_mcg_kg_h_manutencao_7",
    "dose_ml_kg_h_manutencao_7": "dose_ml_kg_h_manutencao_7",
    "dose_ui_kg_h_manutencao_7": "dose_ui_kg_h_manutencao_7",
    "dose_mg_kg_bolus_manutencao_7": "dose_mg_kg_bolus_manutencao_7",
    "dose_mcg_kg_bolus_manutencao_7": "dose_mcg_kg_bolus_manutencao_7",
    "dose_ml_kg_bolus_manutencao_7": "dose_ml_kg_bolus_manutencao_7",
    "dose_ui_kg_bolus_manutencao_7": "dose_ui_kg_bolus_manutencao_7",
    "dose_mg_kg_min_manutencao_8": "dose_mg_kg_min_manutencao_8",
    "dose_mcg_kg_min_manutencao_8": "dose_mcg_kg_min_manutencao_8",
    "dose_ml_kg_min_manutencao_8": "dose_ml_kg_min_manutencao_8",
    "dose_ui_kg_min_manutencao_8": "dose_ui_kg_min_manutencao_8",
    "dose_mg_kg_h_manutencao_8": "dose_mg_kg_h_manutencao_8",
    "dose_mcg_kg_h_manutencao_8": "dose_mcg_kg_h_manutencao_8",
    "dose_ml_kg_h_manutencao_8": "dose_ml_kg_h_manutencao_8",
    "dose_ui_kg_h_manutencao_8": "dose_ui_kg_h_manutencao_8",
    "dose_mg_kg_bolus_manutencao_8": "dose_mg_kg_bolus_manutencao_8",
    "dose_mcg_kg_bolus_manutencao_8": "dose_mcg_kg_bolus_manutencao_8",
    "dose_ml_kg_bolus_manutencao_8": "dose_ml_kg_bolus_manutencao_8",
    "dose_ui_kg_bolus_manutencao_8": "dose_ui_kg_bolus_manutencao_8",
    "dose_mg_kg_min_manutencao_9": "dose_mg_kg_min_manutencao_9",
    "dose_mcg_kg_min_manutencao_9": "dose_mcg_kg_min_manutencao_9",
    "dose_ml_kg_min_manutencao_9": "dose_ml_kg_min_manutencao_9",
    "dose_ui_kg_min_manutencao_9": "dose_ui_kg_min_manutencao_9",
    "dose_mg_kg_h_manutencao_9": "dose_mg_kg_h_manutencao_9",
    "dose_mcg_kg_h_manutencao_9": "dose_mcg_kg_h_manutencao_9",
    "dose_ml_kg_h_manutencao_9": "dose_ml_kg_h_manutencao_9",
    "dose_ui_kg_h_manutencao_9": "dose_ui_kg_h_manutencao_9",
    "dose_mg_kg_bolus_manutencao_9": "dose_mg_kg_bolus_manutencao_9",
    "dose_mcg_kg_bolus_manutencao_9": "dose_mcg_kg_bolus_manutencao_9",
    "dose_ml_kg_bolus_manutencao_9": "dose_ml_kg_bolus_manutencao_9",
    "dose_ui_kg_bolus_manutencao_9": "dose_ui_kg_bolus_manutencao_9",
    "dose_mg_kg_min_manutencao_10": "dose_mg_kg_min_manutencao_10",
    "dose_mcg_kg_min_manutencao_10": "dose_mcg_kg_min_manutencao_10",
    "dose_ml_kg_min_manutencao_10": "dose_ml_kg_min_manutencao_10",
    "dose_ui_kg_min_manutencao_10": "dose_ui_kg_min_manutencao_10",
    "dose_mg_kg_h_manutencao_10": "dose_mg_kg_h_manutencao_10",
    "dose_mcg_kg_h_manutencao_10": "dose_mcg_kg_h_manutencao_10",
    "dose_ml_kg_h_manutencao_10": "dose_ml_kg_h_manutencao_10",
    "dose_ui_kg_h_manutencao_10": "dose_ui_kg_h_manutencao_10",
    "dose_mg_kg_bolus_manutencao_10": "dose_mg_kg_bolus_manutencao_10",
    "dose_mcg_kg_bolus_manutencao_10": "dose_mcg_kg_bolus_manutencao_10",
    "dose_ml_kg_bolus_manutencao_10": "dose_ml_kg_bolus_manutencao_10",
    "dose_ui_kg_bolus_manutencao_10": "dose_ui_kg_bolus_manutencao_10",
}

def traduzir_campos_json(data):
    """Traduz campos de um objeto JSON"""
    if isinstance(data, dict):
        novo_data = {}
        for key, value in data.items():
            # Traduzir a chave se necessário
            nova_key = traducoes.get(key, key)
            novo_data[nova_key] = traduzir_campos_json(value)
        return novo_data
    elif isinstance(data, list):
        return [traduzir_campos_json(item) for item in data]
    else:
        return data

def processar_arquivo(file_path):
    """Processa um arquivo JSON específico"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        # Traduzir apenas a seção PT
        if 'PT' in data:
            data['PT'] = traduzir_campos_json(data['PT'])
        
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        return True
    except Exception as e:
        print(f"Erro ao processar {file_path}: {e}")
        return False

def main():
    condicoes_dir = Path("assets/data/condicoes")
    
    if not condicoes_dir.exists():
        print("Diretório não encontrado: assets/data/condicoes")
        return
    
    json_files = list(condicoes_dir.glob("*.json"))
    print(f"Encontrados {len(json_files)} arquivos JSON")
    
    processados = 0
    
    for json_file in json_files:
        print(f"Processando: {json_file.name}")
        if processar_arquivo(json_file):
            processados += 1
            print(f"  ✓ {json_file.name} processado")
        else:
            print(f"  ✗ Erro ao processar {json_file.name}")
    
    print(f"\nResumo:")
    print(f"Arquivos processados: {processados}")
    print(f"Arquivos com erro: {len(json_files) - processados}")

if __name__ == "__main__":
    main() 