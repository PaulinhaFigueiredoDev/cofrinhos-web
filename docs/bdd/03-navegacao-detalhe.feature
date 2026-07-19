# language: pt
@navegacao
Funcionalidade: Navegar entre Hub e detalhe do cofrinho
  Como pessoa que consulta seus cofrinhos
  Quero abrir um cofrinho e retornar ao Hub
  Para explorar seus dados sem perder o contexto

  @principal @playwright
  Cenário: NAV-001 — Abrir o detalhe de Reserva
    Dado que estou no Hub de Cofrinhos
    Quando aciono o cartão "Reserva"
    Então acesso a rota "/cofrinhos/reserva"
    E vejo o título "Reserva"

  @principal @playwright
  Cenário: NAV-002 — Abrir o detalhe de Casa
    Dado que estou no Hub de Cofrinhos
    Quando aciono o cartão "Casa"
    Então acesso a rota "/cofrinhos/casa"
    E vejo o título "Casa"

  @principal @playwright
  Cenário: NAV-003 — Voltar do detalhe para o Hub
    Dado que estou na rota "/cofrinhos/reserva"
    Quando aciono o botão "Voltar"
    Então acesso a rota "/cofrinhos"
    E vejo o título "Meus Cofrinhos"

  @playwright
  Cenário: NAV-004 — Voltar ao Hub após acesso direto ao detalhe
    Dado que abri diretamente a rota "/cofrinhos/reserva"
    Quando aciono o botão "Voltar"
    Então acesso a rota "/cofrinhos"

  @playwright @acessibilidade
  Cenário: NAV-005 — Abrir e voltar usando somente teclado
    Dado que estou no Hub de Cofrinhos usando teclado
    Quando movo o foco até o cartão "Reserva"
    E pressiono Enter
    Então acesso o detalhe de Reserva
    Quando movo o foco até "Voltar"
    E pressiono Enter
    Então retorno ao Hub

  @vitest
  Cenário: NAV-006 — Exibir foco no cartão inteiro
    Dado que o cartão Reserva recebeu foco
    Então o indicador de foco envolve toda a superfície do cartão
