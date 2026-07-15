# Backend opcional para leads

`cloudflare-worker.js` é um modelo sem dependências externas para receber o formulário. Antes de publicar:

1. crie uma base D1;
2. aplique `schema.sql`;
3. vincule a base como `DB`;
4. defina `ALLOWED_ORIGIN`;
5. publique o Worker;
6. coloque a URL em `site/assets/js/config.js`;
7. adicione proteção antispam e limitação adequada ao tráfego.

O Worker não envia e-mail. Integre um provedor separadamente.

