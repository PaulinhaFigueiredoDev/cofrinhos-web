# language: pt
@detalhe
Funcionalidade: Consultar o detalhe de um cofrinho
  Como pessoa que selecionou um cofrinho
  Quero visualizar seus dados e conteúdos relacionados
  Para compreender o objetivo selecionado

  @principal @vitest @playwright
  Cenário: DET-001 — Exibir o detalhe de Reserva
    Dado que a API simulada possui o cofrinho Reserva com saldo de 100 centavos
    Quando acesso a rota "/cofrinhos/reserva"
    Então vejo a ilustração de Reserva
    E vejo o título "Reserva"
    E vejo o rótulo "Valor guardado"
    E vejo o valor "R$ 1,00"
    E vejo "Rendimento bruto" com o valor "R$ 0,00"

  @vitest
  Cenário: DET-002 — Exibir o detalhe de Casa
    Dado que a API simulada possui o cofrinho Casa com saldo de 0 centavos
    Quando acesso a rota "/cofrinhos/casa"
    Então vejo a ilustração de Casa
    E vejo o título "Casa"
    E vejo o valor "R$ 0,00"

  @vitest
  Cenário: DET-003 — Apresentar carregamento do detalhe
    Dado que a API simulada ainda está processando o cofrinho
    Quando acesso a rota "/cofrinhos/reserva"
    Então vejo o estado "Carregando cofrinho"
    E o espaço da ilustração, título, valores e atalhos permanece reservado

  @vitest
  Cenário: DET-004 — Apresentar erro ao carregar o detalhe
    Dado que a API simulada responde com erro ao consultar Reserva
    Quando acesso a rota "/cofrinhos/reserva"
    Então vejo uma mensagem de falha no carregamento
    E vejo o botão "Tentar novamente"

  @vitest
  Cenário: DET-005 — Tentar carregar o detalhe novamente
    Dado que a primeira consulta de Reserva respondeu com erro
    E que a próxima consulta responderá com sucesso
    Quando aciono "Tentar novamente"
    Então vejo o detalhe de Reserva

  @principal @vitest @playwright
  Cenário: DET-006 — Apresentar cofrinho inexistente
    Dado que não existe um cofrinho com o identificador "inexistente"
    Quando acesso a rota "/cofrinhos/inexistente"
    Então vejo o título "Cofrinho não encontrado"
    E vejo uma ação para voltar ao Hub

  @vitest
  Cenário: DET-007 — Exibir o histórico mockado
    Dado que estou no detalhe de Reserva
    Quando alcanço a seção "Histórico"
    Então vejo as abas "Tudo", "Depósitos" e "Resgates"
    E a aba "Tudo" está selecionada
    E vejo a data "12 de julho de 2026"
    E vejo um item "Depósito" com o valor "R$ 1,00"
