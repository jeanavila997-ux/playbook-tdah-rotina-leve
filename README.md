# Playbook TDAH — Rotina Leve

Repositório independente do **Rotina Leve**, um método educacional de 7 dias para adultos reduzirem a sobrecarga, iniciarem tarefas e construírem uma rotina possível.

> Conteúdo educacional. Não realiza diagnóstico, não prescreve tratamento e não substitui profissionais qualificados.

## Incluído

- site estático responsivo e instalável;
- landing page de captura;
- página de agradecimento e entrega imediata;
- página de oferta em pré-lançamento;
- política de privacidade e termos iniciais;
- lead magnet “Mapa da Rotina Leve”;
- playbook integral de 7 dias;
- funil, e-mails, WhatsApp e eventos;
- avatares, criativos e prompts;
- templates de eBook, imagens, sites e workflows;
- backend opcional para captura de leads;
- arquivos de segurança e preparação para GitHub.

## Visualizar localmente

Abra `site/index.html` ou execute:

```bash
python -m http.server 8080 --directory site
```

Depois acesse `http://localhost:8080`.

## Validar

```bash
bash scripts/validar.sh
```

No Windows (PowerShell):

```powershell
pwsh -File scripts/validar.ps1
```

## Estrutura

Consulte [MAPA_DO_REPOSITORIO.md](./MAPA_DO_REPOSITORIO.md).

## Antes de publicar

1. Substitua o avatar temporário pela imagem final escolhida.
2. Configure o endpoint de leads em `site/assets/js/config.js`.
3. Defina domínio, e-mails reais, checkout e política de reembolso.
4. Faça revisão jurídica e editorial.
5. Teste cadastro, entrega, compra, acesso e exclusão de dados.
