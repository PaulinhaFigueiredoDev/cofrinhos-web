# Como contribuir

## 1. Objetivo

Este documento define o fluxo de contribuição e versionamento do projeto Cofrinhos Web. O padrão deve manter a `main` estável, facilitar a revisão do histórico e demonstrar boas práticas de colaboração em um projeto de portfólio.

## 2. Estratégia de branches

O projeto utiliza **GitHub Flow**.

- `main` representa a versão estável do projeto.
- Toda alteração começa em uma branch criada a partir da `main` atualizada.
- Cada branch deve tratar de um único objetivo.
- Nenhuma implementação deve ser feita diretamente na `main`.
- Toda alteração deve chegar à `main` por Pull Request.
- A branch deve ser excluída após o merge.

Não há branches permanentes adicionais.

## 3. Nomenclatura de branches

Formato:

```text
tipo/descricao-curta-em-kebab-case
```

Tipos permitidos:

| Tipo | Uso | Exemplo |
| --- | --- | --- |
| `feat` | Nova funcionalidade ou novo componente | `feat/card-cofrinho` |
| `fix` | Correção de comportamento ou defeito visual | `fix/estado-saldo-oculto` |
| `refactor` | Melhoria interna sem alterar o comportamento | `refactor/contexto-visibilidade` |
| `test` | Criação ou manutenção de testes | `test/navegacao-detalhe` |
| `docs` | Alterações exclusivamente documentais | `docs/padroes-de-branches` |
| `style` | Ajustes visuais sem alteração de regra de negócio | `style/espacamento-shortcuts` |
| `chore` | Configuração e manutenção do projeto | `chore/configurar-eslint` |
| `ci` | Automação e integração contínua | `ci/verificacao-pull-request` |

Regras:

- usar letras minúsculas;
- separar palavras com hífen;
- não usar acentos, espaços, datas ou nomes pessoais;
- descrever o resultado da branch de forma curta e objetiva;
- incluir o número da issue no início da descrição quando houver uma issue associada, por exemplo: `feat/12-card-cofrinho`.

## 4. Commits

Os commits seguem **Conventional Commits**.

Formato:

```text
tipo(escopo): descricao objetiva
```

Exemplos:

```text
feat(hub): adiciona listagem de cofrinhos
feat(header): persiste visibilidade do saldo
test(card): cobre navegacao para o detalhe
docs(git): documenta fluxo de branches
```

Diretrizes:

- usar os mesmos tipos definidos para branches;
- escrever a descrição em português, no presente e sem ponto final;
- manter cada commit focado em uma alteração coerente;
- evitar mensagens genéricas como `ajustes`, `alteracoes` ou `correcoes`;
- nunca incluir segredos, credenciais ou arquivos de ambiente no commit.

O escopo é recomendado quando ajuda a identificar a área alterada, como `hub`, `detalhe`, `header`, `card`, `shortcuts`, `a11y`, `api` ou `config`.

## 5. Pull Requests

Cada Pull Request deve:

- ter título no formato de Conventional Commits;
- explicar o que foi entregue e por que a alteração é necessária;
- listar como o fluxo foi validado;
- incluir imagens ou vídeos quando houver alteração visual relevante;
- mencionar a issue relacionada quando existir;
- manter escopo pequeno o suficiente para ser revisado de forma objetiva;
- estar sem conflitos e atualizado com a `main` antes do merge.

Checklist mínimo:

```markdown
## O que foi entregue

## Como validar

## Evidências visuais

## Checklist

- [ ] A implementação atende aos critérios de aceite
- [ ] Os testes relevantes foram adicionados ou atualizados
- [ ] Acessibilidade e navegação por teclado foram verificadas
- [ ] Lint, testes e build passam localmente
- [ ] A documentação foi atualizada quando necessário
```

## 6. Revisão e merge

- O merge permitido é **Squash and merge**.
- O título final do squash deve seguir Conventional Commits.
- Todas as conversas do Pull Request devem estar resolvidas.
- Force push e exclusão da `main` permanecem bloqueados.
- O histórico da `main` deve permanecer linear.
- Enquanto o projeto tiver uma única pessoa desenvolvedora, não é exigida aprovação de outra pessoa.
- Quando o CI estiver configurado, lint, testes com Vitest e build deverão ser verificações obrigatórias.

## 7. Fluxo de trabalho

```text
main atualizada
    ↓
nova branch por objetivo
    ↓
commits pequenos e descritivos
    ↓
push da branch
    ↓
Pull Request
    ↓
validações e revisão
    ↓
squash and merge
    ↓
exclusão da branch
```

Exemplo:

```bash
git switch main
git pull --ff-only origin main
git switch -c feat/header-navigation

# implementação e validação

git add caminho/dos/arquivos
git commit -m "feat(header): adiciona navegacao e controle de saldo"
git push -u origin feat/header-navigation
```

## 8. Primeiras branches previstas

A ordem exata depende do plano de execução, mas a divisão inicial recomendada é:

1. `chore/estrutura-inicial-next`
2. `chore/configurar-qualidade`
3. `feat/design-tokens`
4. `feat/componentes-base`
5. `feat/hub-cofrinhos`
6. `feat/detalhe-cofrinho`
7. `feat/persistencia-visibilidade`
8. `ci/verificacao-pull-request`

Cada branch deve entregar um incremento validável e não precisa agrupar toda a etapa caso o Pull Request fique grande.
