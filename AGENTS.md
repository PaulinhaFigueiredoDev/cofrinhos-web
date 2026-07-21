# Contexto do projeto

Este repositório contém o projeto de portfólio `cofrinhos-web`, uma aplicação web/webview inspirada em uma experiência de cofrinhos financeiros.

## Objetivo atual

Implementar o fluxo essencial:

1. Exibir a tela Hub de cofrinhos.
2. Permitir alternar entre saldo visível e saldo oculto.
3. Persistir essa preferência durante a navegação.
4. Permitir clicar em um cofrinho e navegar para a tela de detalhe.
5. Manter o mesmo estado de visibilidade na tela de detalhe.
6. Permitir voltar pelo botão do header para o Hub.
7. Exibir shortcuts e componentes visuais interativos preparados para futuras funcionalidades, sem lógica de negócio adicional.

A criação de novos cofrinhos e outras operações financeiras estão fora do escopo atual. A tag `100% do CDI` é apenas texto visual.

## Stack

- Next.js com App Router
- React e TypeScript
- Vitest para testes unitários
- Testing Library, user-event e vitest-axe para testes de interface e acessibilidade
- MSW para mocks de API
- TanStack Query para gerenciamento de consultas quando a camada de dados for implementada
- ESLint, Stylelint e Prettier
- GitHub Actions para validação contínua
- Node definido pelo `.nvmrc` e npm conforme `packageManager` do `package.json`

## Arquitetura

Usar a estrutura:

```text
src/
├── app/                    # rotas e composição das páginas Next.js
├── components/             # componentes reutilizáveis por nível de Atomic Design
│   ├── atoms/
│   ├── molecules/
│   ├── organisms/
│   ├── templates/
│   └── states/
├── features/
│   └── cofrinhos/
│       ├── domain/         # entidades e regras do domínio
│       ├── application/    # casos de uso e orquestração
│       ├── infrastructure/ # API, adapters, fixtures e implementação externa
│       └── presentation/   # composição específica da feature
├── shared/
│   ├── styles/             # estilos globais
│   ├── testing/            # setup e utilitários de teste
│   └── utils/              # utilitários agnósticos de negócio
└── mocks/                  # dados e handlers de mock
```

Componentes devem ser reutilizáveis e receber dados/ações por props. Regras de negócio pertencem às features, não aos componentes visuais genéricos.

## Convenções

- Código, pastas técnicas e APIs usam inglês.
- Conceitos de negócio e componentes de domínio podem usar português, por exemplo `Cofrinho` e `HeaderNavegacao`.
- Priorizar HTML semântico, navegação por teclado, foco visível, nomes acessíveis e testes com acessibilidade.
- Um card que navega para detalhe deve ser um link; ações que alteram estado devem ser buttons.
- Usar CSS com convenção BEM quando houver classes de componente.
- Evitar estado global sem necessidade. A visibilidade do saldo deve ser centralizada quando compartilhada entre as telas.
- Não adicionar lógica para funcionalidades futuras apenas para simular comportamento.
- Usar componentes próprios e ícones/ilustrações compatíveis com a licença do projeto.

## Qualidade obrigatória

Antes de considerar uma entrega pronta, executar:

```bash
npm run format:check
npm run lint
npm run stylelint
npm run typecheck
npm run test:run
npm run build
```

O workflow `.github/workflows/ci.yml` executa esses checks em Pull Requests e pushes para `main`. Não incluir testes E2E no pipeline até a issue correspondente ser implementada.

## Git e Pull Requests

- `main` é protegida; trabalhar sempre em branch própria.
- Formato recomendado: `<tipo>/<numero>-<descricao-curta>`.
- Exemplos: `chore/3-organizar-arquitetura`, `ci/4-pipeline-qualidade`.
- Tipos comuns: `feat`, `fix`, `chore`, `ci`, `test`, `docs`, `refactor`.
- Commits devem ser pequenos e descrever uma mudança coesa.
- Pull Requests devem conter o que foi entregue, como validar, evidências quando aplicável, issue relacionada e checklist.

## Mentoria

A pessoa responsável pelo projeto está aprendendo e quer orientação como em uma mentoria de frontend React pleno.

Ao conduzir uma tarefa:

1. Explique o que será feito, por que é necessário e qual conceito está sendo aprendido.
2. Prefira orientar a implementação passo a passo antes de editar arquivos automaticamente.
3. Ao revisar código, organize o feedback em: bloqueadores, pontos importantes, sugestões e pontos positivos.
4. Peça confirmação/saída dos comandos quando isso fizer parte do aprendizado.
5. Não faça commit, push ou abertura de Pull Request sem solicitação explícita.

## Documentação

As decisões do produto e da arquitetura ficam em `docs/`. Os arquivos de mentoria em `docs/mentoria/` são contexto local e não devem ser commitados.

Antes de alterar arquitetura, componentes ou escopo, conferir os documentos existentes para manter consistência entre SDD, arquitetura, catálogo de componentes, BDD e plano do produto.
