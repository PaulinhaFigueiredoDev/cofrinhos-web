# language: pt
@visibilidade
Funcionalidade: Controlar a visibilidade dos saldos
  Como pessoa que consulta seus cofrinhos
  Quero exibir ou ocultar valores financeiros
  Para controlar minha privacidade durante toda a navegação

  @principal @vitest
  Cenário: VIS-001 — Ocultar todos os valores no Hub
    Dado que os saldos estão exibidos
    E estou no Hub de Cofrinhos
    Quando aciono "Ocultar saldos"
    Então o total guardado é apresentado como "R$ ••••"
    E o rendimento é apresentado como "R$ ••••"
    E o saldo de cada cofrinho é apresentado como "R$ ••••"
    E o botão passa a ser nomeado "Exibir saldos"

  @principal @vitest
  Cenário: VIS-002 — Exibir todos os valores no Hub
    Dado que os saldos estão ocultos
    E estou no Hub de Cofrinhos
    Quando aciono "Exibir saldos"
    Então o total guardado é apresentado como "R$ 1,00"
    E o rendimento é apresentado como "R$ 0,00"
    E o botão passa a ser nomeado "Ocultar saldos"

  @principal @playwright
  Cenário: VIS-003 — Preservar saldos ocultos ao abrir o detalhe
    Dado que o Hub está com os saldos ocultos
    Quando abro o cofrinho Reserva
    Então acesso a rota "/cofrinhos/reserva"
    E o valor guardado é apresentado como "R$ ••••"
    E o rendimento bruto é apresentado como "R$ ••••"

  @playwright
  Cenário: VIS-004 — Atualizar o Hub após alterar a visibilidade no detalhe
    Dado que os saldos estão ocultos no detalhe de Reserva
    Quando aciono "Exibir saldos"
    E volto para o Hub
    Então o total guardado é apresentado como "R$ 1,00"
    E os cartões apresentam seus valores

  @principal @playwright
  Cenário: VIS-005 — Persistir a preferência após recarregar
    Dado que escolhi ocultar os saldos
    Quando recarrego a página
    Então os saldos permanecem ocultos
    E a preferência salva é "oculto"

  @vitest
  Cenário: VIS-006 — Usar saldos exibidos como preferência inicial
    Dado que não existe preferência salva
    Quando a área de Cofrinhos é carregada
    Então a visibilidade inicial é "exibido"

  @vitest
  Cenário: VIS-007 — Recuperar-se de uma preferência inválida
    Dado que a preferência salva possui um valor inválido
    Quando a área de Cofrinhos é carregada
    Então a visibilidade utilizada é "exibido"

  @vitest @acessibilidade
  Cenário: VIS-008 — Proteger o valor oculto da árvore acessível
    Dado que o saldo de Reserva é "R$ 1,00"
    Quando a visibilidade está como "oculto"
    Então "R$ 1,00" não está presente no conteúdo acessível
    E a tecnologia assistiva recebe "Saldo oculto"

  @vitest
  Esquema do Cenário: VIS-009 — Usar o ícone correspondente à visibilidade
    Dado que a visibilidade atual é "<estado>"
    Quando o botão de visibilidade é renderizado
    Então o ícone utilizado é "<icone>"
    E o nome acessível é "<rotulo>"

    Exemplos:
      | estado  | icone         | rotulo          |
      | exibido | olho-aberto   | Ocultar saldos  |
      | oculto  | olho-fechado  | Exibir saldos   |
