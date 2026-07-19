# Referências Oficiais — Cofrinhos

| Campo | Valor |
|---|---|
| Documento | Referências técnicas e normativas |
| Produto | Hub e detalhe de Cofrinhos |
| Versão | 1.0.0 |

## 1. Objetivo

Este documento centraliza as fontes utilizadas para orientar decisões, implementação e testes. A documentação oficial de cada tecnologia deve prevalecer sobre exemplos encontrados em artigos, vídeos ou respostas de terceiros.

As versões efetivamente instaladas serão registradas no `package.json` e no arquivo de lock do projeto.

## 2. Aplicação

### React

- [Documentação principal](https://react.dev/)
- [Hooks](https://react.dev/reference/react/hooks)
- [Reutilização de lógica com hooks próprios](https://react.dev/learn/reusing-logic-with-custom-hooks)
- [Context](https://react.dev/learn/passing-data-deeply-with-context)

Uso no projeto:

- componentes próprios;
- hooks de consulta e visibilidade;
- Context para compartilhar a preferência de privacidade;
- composição entre componentes-base e templates.

### Next.js

- [Documentação principal](https://nextjs.org/)
- [App Router](https://nextjs.org/docs/app)
- [Layouts e páginas](https://nextjs.org/docs/app/getting-started/layouts-and-pages)
- [Navegação](https://nextjs.org/docs/app/getting-started/linking-and-navigating)
- [Loading e streaming](https://nextjs.org/docs/app/api-reference/file-conventions/loading)
- [Error](https://nextjs.org/docs/app/api-reference/file-conventions/error)
- [Not Found](https://nextjs.org/docs/app/api-reference/file-conventions/not-found)
- [CSS](https://nextjs.org/docs/app/getting-started/css)

Uso no projeto:

- rotas `/cofrinhos` e `/cofrinhos/[id]`;
- layouts e providers da área de Cofrinhos;
- navegação por `Link`;
- estados de rota;
- CSS Modules.

### TypeScript

- [Documentação](https://www.typescriptlang.org/docs/)
- [Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [TSConfig](https://www.typescriptlang.org/tsconfig/)
- [Strict](https://www.typescriptlang.org/tsconfig/strict.html)

Uso no projeto:

- tipagem estrita;
- modelo `Cofrinho`;
- contratos de componentes;
- catálogo tipado de ícones;
- contratos da API simulada.

## 3. Estado remoto e API simulada

### TanStack Query

- [Visão geral para React](https://tanstack.com/query/latest/docs/framework/react/overview)
- [Queries](https://tanstack.com/query/latest/docs/framework/react/guides/queries)
- [Query Keys](https://tanstack.com/query/latest/docs/framework/react/guides/query-keys)
- [Estados de carregamento e erro](https://tanstack.com/query/latest/docs/framework/react/guides/queries#query-basics)

Uso no projeto:

- consultar lista e detalhe;
- controlar carregamento e erro;
- armazenar resultados em cache;
- executar nova tentativa.

### Mock Service Worker

- [Documentação](https://mswjs.io/docs/)
- [Interceptação de requisições](https://mswjs.io/docs/basics/intercepting-requests)
- [Mock de respostas](https://mswjs.io/docs/basics/mocking-responses)
- [Integração com Node.js](https://mswjs.io/docs/integrations/node)

Uso no projeto:

- `GET /api/cofrinhos`;
- `GET /api/cofrinhos/{id}`;
- fixtures de Reserva e Casa;
- cenários de sucesso, demora, erro e `404`;
- execução no navegador e no Vitest.

## 4. Testes

### Vitest

- [Getting Started](https://vitest.dev/guide/)
- [Configuração](https://vitest.dev/config/)
- [Ambiente de testes](https://vitest.dev/guide/environment.html)
- [Mocks](https://vitest.dev/guide/mocking.html)
- [Cobertura](https://vitest.dev/guide/coverage.html)

Uso no projeto:

- testes unitários;
- testes de componentes;
- testes de integração;
- ambiente `jsdom`;
- cobertura com `@vitest/coverage-v8`.

### React Testing Library

- [Introdução](https://testing-library.com/docs/react-testing-library/intro/)
- [Queries](https://testing-library.com/docs/queries/about/)
- [Prioridade das queries](https://testing-library.com/docs/queries/about/#priority)
- [User Event](https://testing-library.com/docs/user-event/intro/)

Uso no projeto:

- consultar elementos por papel, nome e texto;
- testar comportamentos observáveis;
- simular interações do usuário;
- evitar testes acoplados à implementação interna.

### vitest-axe e axe-core

- [vitest-axe](https://github.com/chaance/vitest-axe)
- [axe-core](https://github.com/dequelabs/axe-core)
- [Regras do axe-core](https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md)

Uso no projeto:

- auditoria automatizada dos componentes estruturais;
- Hub com saldo exibido e oculto;
- detalhe com saldo exibido e oculto.

### Playwright

- [Introdução](https://playwright.dev/docs/intro)
- [Locators](https://playwright.dev/docs/locators)
- [Assertions](https://playwright.dev/docs/test-assertions)
- [Emulação de dispositivos](https://playwright.dev/docs/emulation)
- [Acessibilidade em testes](https://playwright.dev/docs/accessibility-testing)

Uso no projeto:

- jornada Hub → detalhe → Hub;
- persistência após reload;
- teclado;
- viewports mobile e desktop;
- acesso direto ao detalhe;
- estado de cofrinho inexistente.

## 5. HTML semântico e acessibilidade

### HTML

- [MDN — HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)
- [Elementos HTML](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements)
- [Heading elements](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/Heading_Elements)
- [Main](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/main)
- [Nav](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/nav)
- [Section](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/section)
- [Button](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/button)
- [Link](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/a)
- [Time](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/time)

Uso no projeto:

- landmarks;
- hierarquia de títulos;
- listas de cofrinhos, atalhos e histórico;
- links para navegação;
- botões para ações;
- datas semânticas.

### WCAG 2.2

- [WCAG 2.2](https://www.w3.org/TR/WCAG22/)
- [WCAG 2.2 Quick Reference](https://www.w3.org/WAI/WCAG22/quickref/)
- [Understanding WCAG 2.2](https://www.w3.org/WAI/WCAG22/Understanding/)

Critério adotado: nível AA.

Aplicações principais:

- contraste;
- foco visível;
- operação por teclado;
- tamanho de alvo;
- nomes acessíveis;
- estrutura e relacionamentos;
- mensagens de status.

### WAI-ARIA Authoring Practices

- [ARIA Authoring Practices Guide](https://www.w3.org/WAI/ARIA/apg/)
- [Button Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/button/)
- [Tabs Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/tabs/)
- [Landmark Regions](https://www.w3.org/WAI/ARIA/apg/practices/landmark-regions/)
- [Accessible Names](https://www.w3.org/WAI/ARIA/apg/practices/names-and-descriptions/)

Princípio adotado: usar HTML nativo e acrescentar ARIA somente para comunicar estados ou padrões que o HTML não representa sozinho.

## 6. APIs do navegador

### Persistência

- [localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage)
- [Storage](https://developer.mozilla.org/en-US/docs/Web/API/Storage)

Uso: persistir `cofrinhos:visibilidade-saldo:v1`.

### Formatação monetária

- [Intl.NumberFormat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/NumberFormat)

Configuração:

```ts
new Intl.NumberFormat("pt-BR", {
  style: "currency",
  currency: "BRL",
});
```

### Responsividade e WebView

- [CSS env](https://developer.mozilla.org/en-US/docs/Web/CSS/env)
- [Viewport meta](https://developer.mozilla.org/en-US/docs/Web/HTML/Viewport_meta_tag)
- [prefers-reduced-motion](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion)
- [overflow-x](https://developer.mozilla.org/en-US/docs/Web/CSS/overflow-x)
- [scroll-snap-type](https://developer.mozilla.org/en-US/docs/Web/CSS/scroll-snap-type)

Uso no projeto:

- safe areas;
- layout mobile-first;
- redução de movimento;
- listas horizontais;
- scroll snap.

## 7. Estilos e organização visual

### CSS Modules

- [Next.js — CSS](https://nextjs.org/docs/app/getting-started/css)

Uso: isolamento dos estilos de cada componente.

### BEM

- [BEM — Naming](https://getbem.com/naming/)

Uso: nomear bloco, elemento e modificador dentro de cada CSS Module.

### Atomic Design

- [Atomic Design Methodology](https://atomicdesign.bradfrost.com/chapter-2/)

Uso: organizar átomos, moléculas, organismos e templates.

### Qualidade de código e CSS

- [ESLint](https://eslint.org/docs/latest/)
- [Stylelint](https://stylelint.io/user-guide/get-started/)
- [Prettier](https://prettier.io/docs/)

Uso:

- análise estática;
- padronização de CSS;
- formatação consistente.

## 8. Ícones e ilustrações

### Phosphor Icons

- [Site](https://phosphoricons.com/)
- [Pacote React](https://github.com/phosphor-icons/react)
- [Licença MIT](https://github.com/phosphor-icons/react/blob/master/LICENSE)

Uso no projeto:

- fonte única de SVGs;
- peso `regular` para ícones de interface;
- peso `duotone` para ilustrações;
- imports encapsulados pelo componente próprio `Icone`.

Crédito esperado no README:

```md
## Créditos

Os ícones deste projeto utilizam Phosphor Icons, distribuído sob licença MIT.
```

## 9. BDD

### Gherkin

- [Gherkin Reference](https://cucumber.io/docs/gherkin/reference/)

Uso: especificar comportamentos em português nos arquivos `.feature`. Os cenários são implementados com Vitest ou Playwright conforme seu nível.

## 10. Ordem de consulta recomendada

1. React.
2. Next.js App Router.
3. TypeScript.
4. HTML semântico e WCAG.
5. TanStack Query e MSW.
6. Vitest e React Testing Library.
7. Playwright.
8. CSS Modules, BEM e Atomic Design.
9. Phosphor Icons.
10. Gherkin.
