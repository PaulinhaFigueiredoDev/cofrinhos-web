# Plano de Produto e Entregas — Cofrinhos

## 1. Resultado da entrega

O projeto entregará uma demonstração navegável do fluxo:

```text
Hub → exibir/ocultar saldos → detalhe → voltar ao Hub
```

A preferência de visibilidade será preservada entre telas e após recarregar. Os atalhos serão botões preparados para ações futuras, mas não executarão operações nesta entrega.

## 2. Escopo funcional

- Hub com resumo e dois cofrinhos mockados.
- Estado exibido ou oculto.
- Persistência da preferência.
- Detalhe do cofrinho selecionado.
- Retorno ao Hub.
- Tag estática “100% do CDI”.
- Lista horizontal de atalhos.
- Componentes complementares das referências sem lógica de negócio.
- Loading, erro e cofrinho não encontrado.
- Responsividade, WebView e acessibilidade.
- Testes, documentação e deploy.

## 3. Prazo

Prazo planejado: **10 dias úteis**, divididos em duas etapas de cinco dias.

Margem recomendada: até **2 dias úteis** para ajustes visuais ou correções encontradas no deploy.

| Etapa | Duração | Resultado |
|---|---:|---|
| Etapa 1 | 5 dias | Fundação e Hub funcional |
| Etapa 2 | 5 dias | Detalhe, testes e publicação |
| Margem | até 2 dias | Refinamento, se necessário |

## 4. Métricas de sucesso

- Fluxo principal concluído sem bloqueio.
- Preferência de privacidade preservada entre rotas e recarregamento.
- Fluxo integral operável por mouse, toque e teclado.
- Zero violações críticas conhecidas de acessibilidade.
- Pipeline com lint, tipos, Vitest e build aprovado.
- Playwright aprovado no ambiente publicado.
- README suficiente para instalar, executar e demonstrar o projeto.

## 5. Etapa 1 — Fundação e Hub

### Dia 1 — Base do projeto

Tarefas:

- Criar Next.js com App Router e TypeScript estrito.
- Organizar diretórios por Atomic Design e funcionalidade.
- Configurar ESLint, Stylelint e formatter.
- Configurar scripts de desenvolvimento e build.
- Criar README inicial.

Entregável:

- Projeto executável com pipeline básico.

### Dia 2 — Design system próprio

Tarefas:

- Definir tokens de cores, tipografia, espaços, bordas, raios e foco.
- Criar `Icone`, `BotaoIcone`, `ValorMonetario` e `Skeleton`.
- Configurar o catálogo Phosphor Icons encapsulado por `Icone`.
- Configurar CSS Modules e convenção BEM.
- Validar foco, contraste e áreas de toque.

Entregável:

- Componentes básicos próprios e reutilizáveis.

### Dia 3 — API mockada e Hub

Tarefas:

- Configurar MSW para navegador e Vitest.
- Criar fixtures de Reserva e Casa.
- Implementar `GET /api/cofrinhos`.
- Configurar TanStack Query.
- Construir header, resumo, cartões e lista.
- Calcular total e rendimento em centavos.

Entregável:

- Hub alimentado pela API mockada.

### Dia 4 — Privacidade

Tarefas:

- Criar `ProvedorVisibilidadeSaldo`.
- Criar `useVisibilidadeSaldo`.
- Persistir preferência no `localStorage`.
- Aplicar máscara a todos os valores sensíveis.
- Garantir que o valor oculto não seja exposto a leitores de tela.
- Implementar botão com nome acessível dinâmico.

Entregável:

- Alternância e persistência de saldo exibido ou oculto.

### Dia 5 — Conteúdo visual e estados

Tarefas:

- Exibir tag estática “100% do CDI”.
- Criar `Atalho` reutilizável com tamanhos médio e pequeno e callback opcional.
- Aplicar `aria-disabled` aos atalhos sem ação.
- Criar lista horizontal rolável.
- Adicionar os componentes complementares das referências.
- Implementar loading e erro do Hub.
- Revisar mobile e desktop.

Entregável:

- Hub visualmente completo dentro do escopo.

### Critério de saída da Etapa 1

- Hub carrega dados mockados.
- Valores podem ser ocultados e exibidos.
- A preferência sobrevive ao recarregamento.
- Atalhos possuem scroll horizontal e não executam ação.
- Tag CDI não dispara requisição.

## 6. Etapa 2 — Detalhe, qualidade e publicação

### Dia 6 — Detalhe

Tarefas:

- Criar `/cofrinhos/[id]`.
- Implementar `GET /api/cofrinhos/{id}` no MSW.
- Construir header e conteúdo do detalhe.
- Reaproveitar `ValorMonetario` e o estado de visibilidade.
- Adicionar conteúdo complementar visível nas referências.

Entregável:

- Detalhe correspondente ao cartão selecionado.

### Dia 7 — Navegação e estados

Tarefas:

- Implementar retorno explícito para `/cofrinhos`.
- Validar entrada direta pela URL do detalhe.
- Implementar loading e erro.
- Implementar estado “Cofrinho não encontrado”.
- Ajustar foco após mudança de rota.

Entregável:

- Jornada Hub → detalhe → Hub completa e resiliente.

### Dia 8 — Vitest

Tarefas:

- Configurar Vitest com `jsdom`.
- Configurar React Testing Library.
- Configurar `vitest-axe`.
- Configurar `@vitest/coverage-v8`.
- Testar soma e formatação de valores.
- Testar persistência da visibilidade.
- Testar componentes principais.
- Testar sucesso, erro e `404` com MSW.

Entregável:

- Suíte de testes unitários, de componentes e de integração executada pelo Vitest.

### Dia 9 — Acessibilidade e E2E

Tarefas:

- Criar o fluxo Playwright.
- Testar mouse, toque e teclado.
- Revisar contraste e foco.
- Testar zoom e viewport a partir de 320 px.
- Verificar safe areas de WebView.
- Executar revisão com leitor de tela quando disponível.

Entregável:

- Fluxo automatizado e auditoria de acessibilidade registrada.

### Dia 10 — Portfólio e deploy

Tarefas:

- Finalizar README com escopo e roteiro da demonstração.
- Registrar os créditos e a licença MIT do Phosphor Icons.
- Linkar SDD e arquitetura.
- Documentar comandos e decisões principais.
- Executar lint, typecheck, Vitest, build e Playwright.
- Publicar a demonstração.
- Registrar capturas e métricas Lighthouse.

Entregável:

- Projeto publicado e pronto para portfólio.

### Critério de saída da Etapa 2

- O roteiro do README funciona no deploy.
- Hub e detalhe preservam a visibilidade.
- Retorno funciona após acesso direto ao detalhe.
- Loading, erro e `404` estão demonstráveis.
- Testes e build passam no CI.
- Não existem erros críticos conhecidos de acessibilidade.

## 7. Backlog de tarefas

### Fundação

- [ ] Inicializar Next.js e TypeScript.
- [ ] Configurar lint, estilos e CI.
- [ ] Criar tokens e componentes básicos.

### Hub

- [ ] Configurar MSW e fixtures.
- [ ] Implementar resumo.
- [ ] Implementar lista de cofrinhos.
- [ ] Implementar privacidade persistida.
- [ ] Implementar tag CDI estática.
- [ ] Implementar atalhos horizontais.
- [ ] Implementar loading e erro.

### Detalhe

- [ ] Criar rota dinâmica.
- [ ] Consultar cofrinho por ID.
- [ ] Preservar privacidade.
- [ ] Implementar retorno ao Hub.
- [ ] Implementar loading, erro e `404`.

### Qualidade

- [ ] Configurar Vitest, Testing Library e `vitest-axe`.
- [ ] Criar testes de domínio, estado, componentes e HTTP.
- [ ] Configurar Playwright.
- [ ] Validar teclado, responsividade e WebView.
- [ ] Publicar e revisar o deploy.

### Documentação

- [ ] Finalizar README.
- [ ] Documentar roteiro da demonstração.
- [ ] Adicionar capturas e métricas.

## 8. Definição de pronto

Uma tarefa está pronta quando:

- atende ao comportamento especificado;
- funciona em viewport mobile;
- possui semântica e foco adequados;
- possui teste proporcional ao risco;
- não introduz erro de lint ou TypeScript;
- não adiciona lógica fora do escopo;
- está refletida na documentação quando altera uma decisão.

## 9. Checklist de lançamento

### Fluxo

- [ ] Hub carrega Reserva e Casa.
- [ ] Botão oculta e exibe todos os valores.
- [ ] Preferência persiste após recarregar.
- [ ] Cartões abrem o detalhe correto.
- [ ] Detalhe preserva a preferência.
- [ ] Voltar navega para o Hub.

### Elementos visuais

- [ ] Tag exibe somente “100% do CDI”.
- [ ] Atalhos rolam horizontalmente.
- [ ] Atalhos não executam ação.
- [ ] Conteúdo complementar não cria navegação inexistente.

### Qualidade

- [ ] Vitest aprovado.
- [ ] Playwright aprovado.
- [ ] Build aprovado.
- [ ] Teste de teclado concluído.
- [ ] Revisão de acessibilidade concluída.
- [ ] Viewports mobile e desktop verificadas.

### Portfólio

- [ ] README contém o fluxo oficial.
- [ ] Documentos técnicos estão linkados.
- [ ] Deploy está acessível.
- [ ] Capturas estão atualizadas.
