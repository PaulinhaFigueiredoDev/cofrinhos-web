# Especificações BDD — Cofrinhos

| Campo | Valor |
|---|---|
| Formato | Gherkin em português |
| Escopo | Hub, detalhe e comportamentos compartilhados |
| Testes de unidade, componentes e integração | Vitest |
| Jornadas no navegador | Playwright |

## 1. Objetivo

As especificações BDD descrevem o comportamento observável da aplicação a partir da perspectiva do usuário. Elas complementam a especificação SDD e servem como fonte para os testes automatizados.

Os cenários estão armazenados em arquivos `.feature`:

| Arquivo | Comportamento |
|---|---|
| `bdd/01-hub-cofrinhos.feature` | carregamento, resumo e lista do Hub |
| `bdd/02-visibilidade-saldos.feature` | exibição, ocultação e persistência |
| `bdd/03-navegacao-detalhe.feature` | abertura do detalhe e retorno ao Hub |
| `bdd/04-detalhe-cofrinho.feature` | conteúdo, loading, erro e item inexistente |
| `bdd/05-componentes-visuais.feature` | CDI, atalhos, header e cards complementares |
| `bdd/06-acessibilidade-responsividade.feature` | teclado, semântica e WebView |

## 2. Estratégia de automação

Os arquivos Gherkin não exigem uma dependência de Cucumber. Cada cenário recebe uma identificação estável, usada no nome do teste correspondente.

Exemplo com Vitest:

```ts
describe("VIS-001 — ocultar saldos no Hub", () => {
  it("mascara todos os valores monetários", async () => {
    // Arrange, Act, Assert derivados do cenário Gherkin.
  });
});
```

Exemplo com Playwright:

```ts
test("NAV-001 — abrir o detalhe de Reserva", async ({ page }) => {
  await page.goto("/cofrinhos");
  await page.getByRole("link", { name: /abrir cofrinho reserva/i }).click();
  await expect(page).toHaveURL(/\/cofrinhos\/reserva$/);
});
```

## 3. Distribuição dos testes

| Grupo | Vitest | Playwright |
|---|:---:|:---:|
| HUB | ✓ | cenário principal |
| VIS | ✓ | persistência entre rotas e reload |
| NAV | integração pontual | ✓ |
| DET | ✓ | cenário principal e `404` |
| CMP | ✓ |  |
| A11Y | `vitest-axe` | teclado e viewport |

## 4. Regras de escrita

- Cada cenário testa um resultado observável.
- Cenários usam nomes do domínio em português.
- Valores monetários são informados em centavos nos dados técnicos e em reais no resultado visual.
- Cenários não descrevem detalhes internos de React.
- A API simulada é controlada pelo MSW nos cenários de sucesso, demora, erro e `404`.
- Um cenário só é considerado atendido quando seu teste automatizado correspondente passa.

## 5. Critério de conclusão

- Todos os cenários de prioridade principal estão automatizados.
- Os testes Vitest passam em ambiente local e CI.
- As jornadas Playwright passam no build publicado.
- Cenários de acessibilidade automatizada passam no `vitest-axe`.
- O README referencia este documento e o fluxo principal.
