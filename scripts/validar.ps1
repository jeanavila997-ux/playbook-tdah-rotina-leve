Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$root = Resolve-Path (Join-Path $PSScriptRoot '..')
Set-Location $root

$required = @(
  'README.md',
  'site/index.html',
  'site/oferta.html',
  'site/obrigado.html',
  'site/politica-de-privacidade.html',
  'site/termos-de-uso.html',
  'site/downloads/mapa-da-rotina-leve.html',
  'playbook/markdown/PLAYBOOK_COMPLETO.md',
  'ebook/markdown/MAPA_DA_ROTINA_LEVE.md',
  'backend/cloudflare-worker.js'
)

foreach ($file in $required) {
  if (-not (Test-Path -Path $file -PathType Leaf)) {
    throw "Arquivo ausente: $file"
  }
  if ((Get-Item $file).Length -le 0) {
    throw "Arquivo vazio: $file"
  }
}

$jsonFiles = Get-ChildItem -Path . -Recurse -Filter *.json -File
foreach ($file in $jsonFiles) {
  Get-Content -Path $file.FullName -Raw | ConvertFrom-Json | Out-Null
}

$index = Get-Content -Path 'site/index.html' -Raw
if ($index -notmatch 'Sua rotina não precisa ser perfeita') {
  throw 'Texto obrigatório ausente em site/index.html'
}

$oferta = Get-Content -Path 'site/oferta.html' -Raw
if ($oferta -notmatch 'Preço e checkout serão publicados') {
  throw 'Texto obrigatório ausente em site/oferta.html'
}

$download = Get-Content -Path 'site/downloads/mapa-da-rotina-leve.html' -Raw
if ($download -notmatch 'Mapa da Rotina Leve') {
  throw 'Texto obrigatório ausente em site/downloads/mapa-da-rotina-leve.html'
}

$secretPattern = 'AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|-----BEGIN (RSA |EC )?PRIVATE KEY-----'
$matches = Get-ChildItem -Path . -Recurse -File -ErrorAction Stop |
  Where-Object { $_.FullName -notmatch '\\.git\\' } |
  Select-String -Pattern $secretPattern -CaseSensitive
if ($matches) {
  throw 'Possível segredo encontrado.'
}

Write-Output 'Validação concluída.'
