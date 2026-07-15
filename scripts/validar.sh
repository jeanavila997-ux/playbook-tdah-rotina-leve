#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"
python_cmd=''
if command -v python3 >/dev/null 2>&1; then
  python_cmd='python3'
elif command -v python >/dev/null 2>&1; then
  python_cmd='python'
else
  echo "Python não encontrado. Instale python3 ou python para validar JSON."
  exit 1
fi
required=(README.md site/index.html site/oferta.html site/obrigado.html site/politica-de-privacidade.html site/termos-de-uso.html site/downloads/mapa-da-rotina-leve.html playbook/markdown/PLAYBOOK_COMPLETO.md ebook/markdown/MAPA_DA_ROTINA_LEVE.md backend/cloudflare-worker.js)
for file in "${required[@]}";do test -s "$file"||{ echo "Arquivo ausente: $file";exit 1;};done
while IFS= read -r file;do "$python_cmd" -m json.tool "$file" >/dev/null;done < <(find . -name '*.json' -type f)
grep -q "Sua rotina não precisa ser perfeita" site/index.html
grep -q "Preço e checkout serão publicados" site/oferta.html
grep -q "Mapa da Rotina Leve" site/downloads/mapa-da-rotina-leve.html
if grep -RIlE 'AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|-----BEGIN (RSA |EC )?PRIVATE KEY-----' . --exclude-dir=.git | grep -q .;then echo "Possível segredo encontrado.";exit 1;fi
echo "Validação concluída."
