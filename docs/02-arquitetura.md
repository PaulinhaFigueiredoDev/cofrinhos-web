# Arquitetura — Cofrinhos

## 1. Objetivo

Este documento apresenta somente a arquitetura necessária para o fluxo de consulta do Hub e detalhe de Cofrinhos.

## 2. Visão de contexto

```mermaid
flowchart LR
    U[Usuário] -->|navegador ou WebView| APP[Aplicação Cofrinhos\nNext.js]
    APP -->|GET simulado| MSW[MSW]
    MSW --> FIX[Fixtures locais]
    APP <--> LS[(localStorage\nvisibilidade)]
```

O MSW intercepta os contratos de leitura e responde usando fixtures versionadas no projeto.

## 3. Tecnologias

| Responsabilidade | Tecnologia |
|---|---|
| Aplicação | Next.js com App Router |
| Interface | React |
| Tipagem | TypeScript estrito |
| Estado remoto | TanStack Query |
| API mockada | MSW |
| Estado de privacidade | Context + hook próprio |
| Persistência da preferência | `localStorage` |
| Estilos | CSS Modules + BEM |
| Organização visual | Atomic Design |
| SVGs e ilustrações | Phosphor Icons encapsulado por `Icone` |
| Testes | Vitest + React Testing Library |
| Acessibilidade automatizada | `vitest-axe` |
| Cobertura | `@vitest/coverage-v8` |
| E2E | Playwright |

## 4. Estrutura

```text
src/
├── app/
│   └── cofrinhos/
│       ├── layout.tsx
│       ├── page.tsx
│       ├── loading.tsx
│       ├── error.tsx
│       └── [id]/
│           ├── page.tsx
│           ├── loading.tsx
│           └── not-found.tsx
├── componentes/
│   ├── atomos/
│   ├── moleculas/
│   ├── organismos/
│   └── templates/
├── funcionalidades/
│   └── cofrinhos/
│       ├── dominio/
│       ├── aplicacao/
│       ├── infraestrutura/
│       └── apresentacao/
├── compartilhado/
│   ├── estilos/
│   ├── testes/
│   └── utilitarios/
└── simulacoes/
    ├── dados.ts
    ├── handlers.ts
    ├── navegador.ts
    └── servidor.ts
```

## 5. Camadas e dependências

```mermaid
flowchart LR
    P[Apresentação] --> A[Aplicação]
    I[Infraestrutura mockada] --> A
    A --> D[Domínio]
    P --> D
```

### Domínio

Contém `Cofrinho`, `IconeCofrinho`, `VisibilidadeSaldo` e regras puras de soma e formatação, mantendo independência das camadas externas.

### Aplicação

Define os contratos de leitura:

```ts
export interface RepositorioCofrinhos {
  listar(): Promise<Cofrinho[]>;
  obterPorId(id: string): Promise<Cofrinho | null>;
}
```

### Infraestrutura

Implementa o cliente HTTP que consome `/api/cofrinhos` e `/api/cofrinhos/{id}`. Em execução local e testes, o MSW responde a essas chamadas.

### Apresentação

Contém páginas, componentes, hooks de consulta e o provider de visibilidade.

## 6. Árvore de componentes

```mermaid
flowchart TB
    A[Átomos\nBotaoIcone, Icone, ValorMonetario, Skeleton]
    M[Moléculas\nHeaderNavegacao, CartaoCofrinho, Atalho]
    O[Organismos\nResumoCofrinhos, ListaCofrinhos, ListaAtalhos]
    T[Templates\nTemplateHubCofrinhos, TemplateDetalheCofrinho]
    R[Rotas Next.js]

    A --> M --> O --> T --> R
```

Os componentes são próprios. CSS Modules isola os estilos e BEM nomeia elementos internos.

Phosphor Icons é a fonte única dos SVGs. Páginas e componentes compostos consomem somente o componente próprio `Icone`; imports do pacote ficam concentrados no catálogo interno de ícones. Ícones de interface usam peso `regular` e representações ilustrativas usam `duotone`.

### Regra de reutilização

Hub e detalhe utilizam o mesmo conjunto de componentes de base. Uma variação visual deve ser expressa por propriedades como `tamanho`, `variante`, `visibilidade` e callbacks opcionais. Não serão criadas cópias específicas por tela quando anatomia e comportamento forem equivalentes.

```mermaid
flowchart TB
    B[Base\nIcone, BotaoIcone, ValorMonetario, Divisor]
    C[Compostos reutilizáveis\nHeaderNavegacao, Atalho, LinhaRendimento]
    H[TemplateHubCofrinhos]
    D[TemplateDetalheCofrinho]

    B --> C
    C --> H
    C --> D
```

Os templates organizam componentes e espaçamentos próprios de cada página. Eles não duplicam a implementação dos componentes compartilhados.

## 7. Fluxo do Hub

```mermaid
sequenceDiagram
    actor U as Usuário
    participant H as Hub
    participant Q as useCofrinhos
    participant HTTP as Cliente HTTP
    participant M as MSW
    participant F as Fixtures

    U->>H: acessa /cofrinhos
    H->>Q: solicita lista
    Q->>HTTP: GET /api/cofrinhos
    HTTP->>M: requisição interceptada
    M->>F: lê dados simulados
    F-->>M: Cofrinho[]
    M-->>HTTP: 200 { dados }
    HTTP-->>Q: lista
    Q-->>H: estado de sucesso
    H-->>U: resumo e cartões
```

## 8. Fluxo do detalhe

```mermaid
sequenceDiagram
    actor U as Usuário
    participant C as CartaoCofrinho
    participant D as Detalhe
    participant Q as useCofrinho
    participant M as MSW

    U->>C: ativa Reserva
    C->>D: navega /cofrinhos/reserva
    D->>Q: solicita reserva
    Q->>M: GET /api/cofrinhos/reserva
    M-->>Q: 200 { dados }
    Q-->>D: Cofrinho
    D-->>U: exibe detalhe
    U->>D: ativa voltar
    D-->>U: navega /cofrinhos
```

Se o identificador não existir, o MSW responde `404` e a rota apresenta o estado de não encontrado.

## 9. Estado de visibilidade

```mermaid
stateDiagram-v2
    [*] --> Exibido: preferência ausente ou inválida
    [*] --> Oculto: preferência salva como oculto
    Exibido --> Oculto: ocultar saldos
    Oculto --> Exibido: exibir saldos
```

`ProvedorVisibilidadeSaldo` envolve as duas rotas no layout de `/cofrinhos`. O provider:

- lê `localStorage` após a montagem no cliente;
- disponibiliza estado e função de alternância;
- persiste mudanças;
- usa `exibido` como fallback seguro.

`ValorMonetario` decide entre moeda formatada e máscara. Quando oculto, não renderiza o valor real na árvore acessível.

## 10. Atalhos horizontais

```mermaid
flowchart LR
    L[ListaAtalhos] --> G[Atalho Guardar]
    L --> R[Atalho Resgatar]
    L --> P[Atalho Programar]
    L --> X[Atalho Pix]
```

`ListaAtalhos` controla layout e scroll horizontal. `Atalho` renderiza um botão reutilizado nas duas telas e recebe callback opcional:

```ts
type PropriedadesAtalho = {
  titulo: string;
  ilustracao: React.ReactNode;
  tamanho: "pequeno" | "medio";
  variante?: "neutra" | "destaque";
  aoAtivar?: () => void;
};
```

O Hub usa `tamanho="medio"`; o detalhe usa `tamanho="pequeno"`. Guardar usa `variante="destaque"`. As instâncias atuais usam `aria-disabled="true"`, permanecem focáveis e impedem a ativação.

## 11. Tag CDI

“100% do CDI” é texto estático da apresentação.

## 12. Estratégia de renderização

- Server Components por padrão.
- Client Components somente para TanStack Query, visibilidade, interação e scroll quando necessário.
- `layout.tsx` da área instala os providers.
- `loading.tsx`, `error.tsx` e `not-found.tsx` representam os estados de rota.
- A leitura de `localStorage` acontece apenas no cliente, evitando acesso durante SSR.

## 13. Acessibilidade estrutural

- `BotaoIcone` exige nome acessível.
- `CartaoCofrinho` possui um único link e não aninha controles.
- `ValorMonetario` centraliza a proteção do valor oculto.
- `Atalho` anuncia indisponibilidade com `aria-disabled`.
- `ListaAtalhos` permite rolagem sem prender o teclado.
- O foco é visível e segue a ordem visual.
- Títulos e landmarks identificam as páginas.

## 14. Testes por camada

| Camada | Ferramentas e cobertura |
|---|---|
| Domínio | Vitest para soma, moeda e máscara |
| Estado | Vitest para Context e `localStorage` |
| Componentes | Vitest, Testing Library e `vitest-axe` |
| HTTP | Vitest e MSW para sucesso, erro e `404` |
| Rotas | Vitest para integração dos estados |
| Jornada | Playwright para Hub → detalhe → Hub |

## 15. Pipeline

```mermaid
flowchart LR
    PR[Pull request] --> L[Lint]
    PR --> T[Typecheck]
    PR --> V[Vitest]
    PR --> B[Build]
    L --> P[Preview]
    T --> P
    V --> P
    B --> P
    P --> E[Playwright]
```

O deploy publica somente frontend e fixtures demonstrativas. Nenhum segredo ou serviço externo é necessário.
