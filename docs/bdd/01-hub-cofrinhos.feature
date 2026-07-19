# language: pt
@hub
Funcionalidade: Consultar o Hub de Cofrinhos
  Como pessoa que utiliza Cofrinhos
  Quero visualizar meu resumo e meus cofrinhos
  Para consultar os valores guardados e acessar seus detalhes

  Contexto:
    Dado que a preferência de visibilidade está como "exibido"

  @principal @vitest @playwright
  Cenário: HUB-001 — Carregar o Hub com sucesso
    Dado que a API simulada possui os cofrinhos:
      | id      | nome    | icone  | saldoEmCentavos | rendimentoBrutoEmCentavos |
      | reserva | Reserva | reserva | 100             | 0                            |
      | casa    | Casa    | casa    | 0               | 0                            |
    Quando acesso a rota "/cofrinhos"
    Então vejo o título "Meus Cofrinhos"
    E vejo o cofrinho "Reserva" com o valor "R$ 1,00"
    E vejo o cofrinho "Casa" com o valor "R$ 0,00"

  @vitest
  Cenário: HUB-002 — Calcular o total guardado
    Dado que Reserva possui saldo de 100 centavos
    E Casa possui saldo de 0 centavos
    Quando o resumo do Hub é apresentado
    Então o total guardado exibido é "R$ 1,00"

  @vitest
  Cenário: HUB-003 — Calcular o rendimento total
    Dado que Reserva possui rendimento bruto de 0 centavos
    E Casa possui rendimento bruto de 0 centavos
    Quando o resumo do Hub é apresentado
    Então o valor ao lado de "Rendeu" é "R$ 0,00"

  @vitest
  Cenário: HUB-004 — Apresentar carregamento do Hub
    Dado que a API simulada ainda está processando a lista
    Quando acesso a rota "/cofrinhos"
    Então vejo o estado de carregamento dos cofrinhos
    E o espaço do resumo e dos cartões permanece reservado

  @vitest
  Cenário: HUB-005 — Apresentar erro ao carregar o Hub
    Dado que a API simulada responde com erro ao listar cofrinhos
    Quando acesso a rota "/cofrinhos"
    Então vejo a mensagem "Não foi possível carregar os cofrinhos."
    E vejo o botão "Tentar novamente"

  @vitest
  Cenário: HUB-006 — Tentar carregar o Hub novamente
    Dado que a primeira consulta da lista respondeu com erro
    E que a próxima consulta responderá com sucesso
    Quando aciono "Tentar novamente"
    Então a API simulada recebe uma nova consulta
    E vejo os cartões de Reserva e Casa

  @vitest @acessibilidade
  Cenário: HUB-007 — Tornar todo o cartão do cofrinho um único link
    Dado que o Hub apresenta o cartão de Reserva
    Quando consulto os elementos interativos do cartão
    Então existe um único link para "/cofrinhos/reserva"
    E ilustração, nome, valor e chevron pertencem ao mesmo link
    E o link possui foco visível
