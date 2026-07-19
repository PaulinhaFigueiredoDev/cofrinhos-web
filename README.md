# Cofrinhos Web

Interface mobile-first para visualização de cofrinhos, desenvolvida para navegadores e preparada para incorporação em WebViews.

## Sobre o projeto

O projeto apresenta um Hub de cofrinhos e a tela de detalhe de cada cofrinho.

O fluxo principal permite:

- Visualizar os cofrinhos disponíveis.
- Exibir ou ocultar valores financeiros.
- Preservar a preferência de privacidade entre as telas.
- Acessar o detalhe de um cofrinho.
- Retornar do detalhe para o Hub.

## Tecnologias

- React
- Next.js
- TypeScript
- TanStack Query
- Mock Service Worker
- CSS Modules
- Vitest
- React Testing Library
- Playwright

## Pré-requisitos

- Node.js 24 ou superior
- npm 11 ou superior

## Instalação

```bash
npm install
npm run dev
```

A aplicação estará disponível em [http://localhost:3000](http://localhost:3000).

## Comandos

| Comando                 | Finalidade                                   |
| ----------------------- | -------------------------------------------- |
| `npm run dev`           | Inicia o ambiente local                      |
| `npm run build`         | Gera o build de produção                     |
| `npm run lint`          | Executa o ESLint                             |
| `npm run stylelint`     | Valida os arquivos CSS                       |
| `npm run typecheck`     | Valida o TypeScript                          |
| `npm run format:check`  | Confere a formatação                         |
| `npm run test:run`      | Executa os testes com Vitest                 |
| `npm run test:coverage` | Executa os testes com cobertura              |
| `npm run test:e2e`      | Executa os testes no Chromium com Playwright |

## Qualidade

O projeto será desenvolvido considerando:

- HTML semântico.
- Acessibilidade baseada na WCAG 2.2 AA.
- Componentes próprios e reutilizáveis.
- Atomic Design.
- CSS com nomenclatura BEM.
- Testes unitários, de componentes, integração e E2E.
- Layout responsivo para web e WebView.

## Status

🚧 Projeto em fase de especificação e configuração inicial.

## Contribuição

Consulte o [guia de contribuição](CONTRIBUTING.md) para conhecer os padrões de branches, commits, Pull Requests e merge adotados no projeto.

## Autora

Desenvolvido por [Paulinha Figueiredo](https://github.com/PaulinhaFigueiredoDev).
