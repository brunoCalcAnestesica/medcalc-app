#!/usr/bin/env python3
import json
import re
from pathlib import Path

def fix_json_complete(file_path):
    """Corrige todos os problemas JSON de forma completa"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # 1. Remover caracteres extras no início
        content = re.sub(r'^[^{]*', '', content)
        
        # 2. Corrigir vírgulas faltando entre objetos em arrays (padrão específico)
        # Padrão: } { "nome": -> }, { "nome":
        content = re.sub(r'}\s*{\s*"nome":', '},\n        {\n          "nome":', content)
        
        # 3. Corrigir vírgulas faltando em outros arrays
        content = re.sub(r'}\s*{\s*"', '},\n      {\n        "', content)
        
        # 4. Corrigir vírgulas extras antes de "US" e "ES"
        content = re.sub(r'},\s*"US":\s*{', '},\n  "US": {', content)
        content = re.sub(r'},\s*"ES":\s*{', '},\n  "ES": {', content)
        
        # 5. Corrigir vírgulas extras antes de chaves de fechamento
        content = re.sub(r',\s*}', '}', content)
        content = re.sub(r',\s*]', ']', content)
        
        # 6. Corrigir vírgulas duplas
        content = re.sub(r',\s*,', ',', content)
        
        # 7. Corrigir vírgulas antes de chaves de abertura
        content = re.sub(r',\s*{', ' {', content)
        
        # 8. Garantir que termine com }}
        if not content.strip().endswith('}'):
            content = content.rstrip() + '\n}'
        
        # 9. Adicionar chave de abertura se não existir
        if not content.strip().startswith('{'):
            content = '{\n' + content
        
        # 10. Corrigir problemas específicos de estrutura
        # Remover vírgulas extras no final de arrays
        content = re.sub(r',(\s*[}\]])', r'\1', content)
        
        # Se o conteúdo mudou, salvar
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        
        return False
        
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False

def validate_and_fix_json(file_path):
    """Valida e tenta corrigir JSON até que seja válido"""
    max_attempts = 3
    for attempt in range(max_attempts):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                json.load(f)
            return True  # JSON é válido
        except json.JSONDecodeError as e:
            if attempt < max_attempts - 1:
                fix_json_complete(file_path)
            else:
                return False
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
        
        # Tentar corrigir e validar
        if validate_and_fix_json(json_file):
            valid_count += 1
            print(f"  ✓ {json_file.name} is valid")
        else:
            print(f"  ✗ {json_file.name} still has errors")
            # Tentar uma correção adicional
            if fix_json_complete(json_file):
                fixed_count += 1
                print(f"    Fixed: {json_file.name}")
    
    print(f"\nSummary:")
    print(f"Files processed: {len(json_files)}")
    print(f"Files fixed: {fixed_count}")
    print(f"Files valid: {valid_count}")
    print(f"Files with errors: {len(json_files) - valid_count}")

if __name__ == "__main__":
    main() 