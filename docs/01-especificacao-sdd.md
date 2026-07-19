# Especificação SDD — Cofrinhos

| Campo | Valor |
|---|---|
| Produto | Hub e detalhe de Cofrinhos |
| Versão | 1.0.0 |
| Status | Escopo definido para implementação |
| Plataforma | Web responsiva e WebView |
| Idioma do domínio | Português do Brasil |

## 1. Objetivo

Esta especificação é a fonte de verdade do projeto. Ela descreve somente o que será implementado.

O projeto demonstrará o fluxo de consulta de cofrinhos: visualizar o Hub, exibir ou ocultar valores, abrir o detalhe de um cofrinho e voltar ao Hub preservando a preferência de privacidade.

## 2. Escopo da entrega

Serão implementados:

- Hub com resumo e lista de cofrinhos.
- Alternância entre saldo exibido e oculto.
- Persistência da preferência de visibilidade no navegador.
- Navegação de um cartão do Hub para o detalhe correspondente.
- Retorno explícito do detalhe para o Hub.
- Detalhe com nome, ícone, saldo e rendimento do cofrinho.
- Tag estática com o texto “100% do CDI”.
- Atalhos visuais em uma lista com rolagem horizontal.
- Atalhos construídos como botões reutilizáveis, preparados para receber ações posteriormente.
- Cards complementares presentes nas referências, sem lógica de negócio.
- Dados de leitura simulados por uma API mockada.
- Estados de carregamento, erro e item não encontrado.
- Componentes visuais próprios.
- Layout responsivo para web e WebView.
- Acessibilidade.
- Testes com Vitest e fluxo ponta a ponta com Playwright.
- Documentação e deploy de portfólio.

## 3. Fluxo funcional demonstrado

```text
/cofrinhos
├── exibir ou ocultar valores
├── selecionar um cofrinho
│   └── /cofrinhos/{id}
│       ├── preservar a visibilidade dos valores
│       ├── permitir alterar a visibilidade
│       └── voltar para /cofrinhos
└── manter a preferência após recarregar a página
```

O README apresentará esse fluxo como o roteiro oficial da demonstração.

## 4. Vocabulário do domínio

Conceitos próprios do produto serão escritos em português:

| Conceito | Nome no código |
|---|---|
| Cofrinho | `Cofrinho` |
| Lista | `ListaCofrinhos` |
| Card | `CartaoCofrinho` |
| Valor monetário | `ValorMonetario` |
| Visibilidade | `VisibilidadeSaldo` |
| Atalho | `Atalho` |
| Hook da lista | `useCofrinhos` |
| Hook de visibilidade | `useVisibilidadeSaldo` |

APIs do React, Next.js e bibliotecas preservam seus nomes oficiais.

## 5. Rotas

| Rota | Responsabilidade |
|---|---|
| `/cofrinhos` | Hub com resumo e lista |
| `/cofrinhos/[id]` | Detalhe do cofrinho selecionado |

Um identificador inexistente deve exibir “Cofrinho não encontrado” e uma ação para retornar ao Hub.

## 6. Requisitos funcionais

### RF-001 — Exibir o Hub

- Consultar `GET /api/cofrinhos` ao abrir o Hub.
- Exibir total guardado e rendimento total.
- Exibir a lista dos cofrinhos retornados.
- Exibir os estados de carregamento e erro.

### RF-002 — Calcular o resumo

- Total guardado é a soma de `saldoEmCentavos`.
- Rendimento total é a soma de `rendimentoBrutoEmCentavos`.
- Operações monetárias usam números inteiros em centavos.
- A apresentação usa `Intl.NumberFormat` com `pt-BR` e `BRL`.

### RF-003 — Exibir e ocultar valores

- A visibilidade admite `exibido` e `oculto`.
- O estado é compartilhado entre Hub e detalhe.
- O estado inicial padrão é `exibido`.
- A preferência é salva na chave `cofrinhos:visibilidade-saldo:v1` do `localStorage`.
- Um valor salvo ausente ou inválido resulta em `exibido`.
- Valores ocultos aparecem como `R$ ••••`.
- O valor real não permanece em `aria-label`, `title`, `data-*` ou conteúdo visualmente oculto.
- O botão anuncia “Ocultar saldos” ou “Exibir saldos”, conforme a próxima ação.

### RF-004 — Abrir o detalhe

- O cartão inteiro é um único alvo de navegação.
- Ao ativá-lo, a aplicação navega para `/cofrinhos/{id}`.
- O detalhe consulta `GET /api/cofrinhos/{id}`.
- O detalhe exibe o cofrinho correspondente.
- A visibilidade escolhida no Hub é preservada.

### RF-005 — Voltar ao Hub

- O botão do header do detalhe navega explicitamente para `/cofrinhos`.
- O retorno funciona mesmo quando o detalhe foi aberto por URL direta.

### RF-006 — Exibir a tag CDI

- Exibir o texto literal “100% do CDI”.
- A tag é conteúdo estático de apresentação.

### RF-007 — Exibir atalhos horizontais

- Exibir Viagem, Casamento e Celular no Hub.
- Exibir Guardar, Resgatar, Programar pra guardar e Receber Pix no detalhe.
- A lista permite rolagem horizontal por toque, trackpad e teclado.
- Cada atalho é renderizado pelo componente próprio `Atalho`.
- Os atalhos do Hub usam `tamanho="medio"`.
- Os atalhos do detalhe usam `tamanho="pequeno"`.
- O componente aceita uma propriedade opcional `aoAtivar` para evolução posterior.
- Nesta entrega, nenhuma instância recebe uma ação.
- Instâncias sem ação usam `aria-disabled="true"`, permanecem focáveis e não navegam.

### RF-008 — Exibir conteúdo complementar

- Os banners, recomendações, tabs e registros visíveis nas referências podem ser renderizados com conteúdo mockado.
- Esses elementos não executam lógica de negócio.
- Elementos sem ação não devem usar semântica de link.

## 7. Modelo de domínio

```ts
export type IconeCofrinho = "reserva" | "casa";

export type Cofrinho = {
  id: string;
  nome: string;
  icone: IconeCofrinho;
  saldoEmCentavos: number;
  rendimentoBrutoEmCentavos: number;
};

export type VisibilidadeSaldo = "exibido" | "oculto";
```

Dados iniciais esperados:

```ts
const cofrinhos: Cofrinho[] = [
  {
    id: "reserva",
    nome: "Reserva",
    icone: "reserva",
    saldoEmCentavos: 100,
    rendimentoBrutoEmCentavos: 0,
  },
  {
    id: "casa",
    nome: "Casa",
    icone: "casa",
    saldoEmCentavos: 0,
    rendimentoBrutoEmCentavos: 0,
  },
];
```

## 8. API simulada

O MSW simulará os contratos HTTP consumidos pela interface.

### GET `/api/cofrinhos`

Resposta `200`:

```json
{
  "dados": [
    {
      "id": "reserva",
      "nome": "Reserva",
      "icone": "reserva",
      "saldoEmCentavos": 100,
      "rendimentoBrutoEmCentavos": 0
    }
  ]
}
```

### GET `/api/cofrinhos/{id}`

- `200`: `{ "dados": Cofrinho }`.
- `404`: erro com código `COFRINHO_NAO_ENCONTRADO`.

### Formato de erro

```json
{
  "erro": {
    "codigo": "ERRO_AO_CARREGAR",
    "mensagem": "Não foi possível carregar os cofrinhos."
  }
}
```

## 9. Estados da interface

| Estado | Resultado esperado |
|---|---|
| Carregando Hub | Skeleton com dimensões estáveis |
| Erro no Hub | Mensagem e botão “Tentar novamente” |
| Carregando detalhe | Skeleton do conteúdo principal |
| Erro no detalhe | Mensagem e botão “Tentar novamente” |
| ID inexistente | “Cofrinho não encontrado” e retorno ao Hub |
| Saldo oculto | Máscara sem exposição do valor real |

## 10. Requisitos de acessibilidade

- Referência WCAG 2.2 nível AA.
- Uso de HTML semântico antes de ARIA.
- Cada página possui um único `<main>` e um único `<h1>`.
- O header usa `<header>` e `<nav aria-label="Navegação da página">`.
- Coleções usam `<ul>` e `<li>`.
- Navegação usa `<a>`; ações usam `<button>`.
- Seções possuem heading e nome acessível.
- ARIA complementa o HTML nativo somente quando necessário.
- Operação integral do fluxo por teclado.
- Foco visível.
- Área mínima de toque de 44 × 44 CSS pixels.
- Contraste suficiente para texto, ícones e foco.
- Títulos hierárquicos e landmarks apropriados.
- Mudança de rota com foco direcionado para o título principal quando necessário.
- Respeito a `prefers-reduced-motion`.
- Atalhos sem ação anunciados com `aria-disabled="true"`.
- Testes automatizados complementados por revisão manual.

## 11. Responsividade e WebView

- Abordagem mobile-first a partir de 320 CSS pixels.
- Conteúdo centralizado em telas largas, com largura máxima entre 480 e 560 pixels.
- Uso de `env(safe-area-inset-top)` e `env(safe-area-inset-bottom)`.
- Nenhuma ação essencial depende de hover.
- O scroll horizontal preserva o scroll vertical da página.

## 12. Componentes e estilos

Todos os componentes visuais são próprios.

```text
componentes/
├── atomos/
│   ├── BotaoIcone
│   ├── BotaoVisibilidadeSaldo
│   ├── Divisor
│   ├── Icone
│   ├── ValorMonetario
│   └── Skeleton
├── moleculas/
│   ├── HeaderNavegacao
│   ├── CartaoCofrinho
│   └── Atalho
├── organismos/
│   ├── ResumoCofrinhos
│   ├── ListaCofrinhos
│   └── ListaAtalhos
└── templates/
    ├── TemplateHubCofrinhos
    └── TemplateDetalheCofrinho
```

CSS Modules fornece isolamento. BEM descreve a anatomia interna:

```css
.cartao-cofrinho {}
.cartao-cofrinho__titulo {}
.cartao-cofrinho__saldo {}
```

Serão definidos tokens de cor, tipografia, espaço, borda, raio, foco, movimento e largura de conteúdo.

## 13. Decisões técnicas

| ID | Decisão |
|---|---|
| DT-001 | Next.js com App Router para páginas e rotas dinâmicas |
| DT-002 | React e TypeScript com `strict: true` |
| DT-003 | Domínio próprio escrito em português |
| DT-004 | MSW para API simulada somente de leitura |
| DT-005 | TanStack Query para carregamento, cache, erro e nova tentativa |
| DT-006 | Context e hook próprios para visibilidade do saldo |
| DT-007 | `localStorage` para persistência da preferência |
| DT-008 | CSS Modules, BEM e Atomic Design |
| DT-009 | Vitest para testes unitários, de componentes e de integração |
| DT-010 | Playwright exclusivamente para E2E |
| DT-011 | Valores monetários representados em centavos inteiros |
| DT-012 | Tag “100% do CDI” estática |
| DT-013 | Voltar navega explicitamente para `/cofrinhos` |
| DT-014 | Phosphor Icons como fonte única de SVGs, encapsulada pelo componente próprio `Icone` |

Os ícones de interface usam peso `regular`. As representações de cofrinhos e objetivos usam peso `duotone`. A licença MIT do Phosphor Icons será registrada no README.

## 14. Estratégia de testes

### Vitest

- Regras de formatação e soma de valores.
- Persistência e recuperação da visibilidade.
- `ValorMonetario` sem exposição do valor oculto.
- `BotaoVisibilidadeSaldo` com nome acessível correto.
- `CartaoCofrinho` navegável por teclado.
- `Atalho` nos tamanhos médio e pequeno, com `aria-disabled` e sem navegação.
- Loading, erro e `404` simulados com MSW.
- Verificações com React Testing Library e `vitest-axe`.
- Cobertura com `@vitest/coverage-v8`.

### Playwright

1. Abrir o Hub.
2. Ocultar saldos.
3. Abrir o detalhe de Reserva.
4. Confirmar que os valores permanecem ocultos.
5. Voltar ao Hub.
6. Recarregar e confirmar a preferência.
7. Repetir a jornada por teclado.

Scripts esperados:

```json
{
  "scripts": {
    "test": "vitest",
    "test:run": "vitest run",
    "test:coverage": "vitest run --coverage",
    "test:e2e": "playwright test"
  }
}
```

## 15. Critérios de pronto

- Hub e detalhe correspondem às referências dentro do layout responsivo.
- O fluxo documentado funciona por mouse, toque e teclado.
- A preferência de visibilidade é preservada entre telas e recarregamento.
- O botão voltar funciona após acesso direto ao detalhe.
- A tag CDI é estática e não dispara requisição.
- Atalhos horizontais são roláveis e não executam ação.
- Loading, erro e `404` estão implementados.
- Lint, TypeScript, Vitest, Playwright e build passam no CI.
- Não existem violações críticas conhecidas de acessibilidade.
- README contém instalação, comandos, fluxo da demonstração e escopo.
