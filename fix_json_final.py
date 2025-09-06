#!/usr/bin/env python3
import json
import re
from pathlib import Path

def fix_json_final(file_path):
    """Corrige especificamente os problemas de vírgulas faltando entre objetos"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Corrigir vírgulas faltando entre objetos em arrays
        # Padrão: } { "nome": -> }, { "nome":
        content = re.sub(r'}\s*{\s*"nome":', '},\n        {\n          "nome":', content)
        
        # Corrigir vírgulas faltando em outros arrays
        content = re.sub(r'}\s*{\s*"', '},\n      {\n        "', content)
        
        # Corrigir vírgulas extras antes de chaves de fechamento
        content = re.sub(r',\s*}', '}', content)
        content = re.sub(r',\s*]', ']', content)
        
        # Garantir que termine com }}
        if not content.strip().endswith('}'):
            content = content.rstrip() + '\n}'
        
        # Se o conteúdo mudou, salvar
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        
        return False
        
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False

def main():
    condicoes_dir = Path("assets/data/condicoes")
    
    if not condicoes_dir.exists():
        print("Directory not found: assets/data/condicoes")
        return
    
    json_files = list(condicoes_dir.glob("*.json"))
    print(f"Found {len(json_files)} JSON files")
    
    fixed_count = 0
    valid_count = 0
    
    for json_file in json_files:
        print(f"Processing: {json_file.name}")
        
        # Tentar corrigir
        was_fixed = fix_json_final(json_file)
        if was_fixed:
            fixed_count += 1
            print(f"  Fixed: {json_file.name}")
        
        # Validar
        try:
            with open(json_file, 'r', encoding='utf-8') as f:
                json.load(f)
            valid_count += 1
            print(f"  ✓ {json_file.name} is valid")
        except json.JSONDecodeError:
            print(f"  ✗ {json_file.name} still has errors")
    
    print(f"\nSummary:")
    print(f"Files processed: {len(json_files)}")
    print(f"Files fixed: {fixed_count}")
    print(f"Files valid: {valid_count}")
    print(f"Files with errors: {len(json_files) - valid_count}")

if __name__ == "__main__":
    main() 