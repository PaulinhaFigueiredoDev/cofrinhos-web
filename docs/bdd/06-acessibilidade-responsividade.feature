# language: pt
@acessibilidade @responsividade
Funcionalidade: Operar Cofrinhos em diferentes dispositivos e tecnologias assistivas
  Como pessoa que utiliza navegador ou WebView
  Quero acessar o fluxo com diferentes formas de interação
  Para consultar os cofrinhos com autonomia

  @playwright
  Esquema do Cenário: A11Y-001 — Executar o fluxo em diferentes larguras
    Dado que o viewport possui largura de "<largura>" pixels
    Quando acesso o Hub e abro o detalhe de Reserva
    Então o conteúdo permanece legível
    E não existe rolagem horizontal na página
    E a lista de atalhos mantém sua própria rolagem horizontal

    Exemplos:
      | largura |
      | 320     |
      | 390     |
      | 768     |
      | 1280    |

  @playwright
  Cenário: A11Y-002 — Percorrer os controles por teclado
    Dado que estou no Hub usando apenas teclado
    Quando pressiono Tab repetidamente
    Então cada controle recebe foco em ordem coerente
    E o foco permanece visível
    E alcanço o controle de visibilidade
    E alcanço os cartões dos cofrinhos
    E alcanço os atalhos

  @playwright
  Cenário: A11Y-003 — Rolar os atalhos com teclado
    Dado que o foco está na lista horizontal de atalhos
    Quando uso as teclas de navegação horizontal
    Então consigo visualizar os atalhos que estavam fora da área visível
    E o scroll vertical da página continua disponível

  @vitest
  Cenário: A11Y-004 — Nomear botões compostos apenas por ícone
    Dado que o header apresenta botões apenas com ícone
    Quando consulto seus nomes acessíveis
    Então encontro "Voltar", "Ocultar saldos" e "Ajuda"

  @vitest
  Cenário: A11Y-005 — Ocultar SVGs decorativos da árvore acessível
    Dado que um cartão apresenta ilustração e chevron decorativos
    Quando consulto a árvore acessível
    Então esses SVGs utilizam `aria-hidden="true"`
    E o nome do cofrinho permanece disponível no link

  @vitest
  Cenário: A11Y-006 — Manter a hierarquia de títulos do Hub
    Dado que o Hub está carregado
    Então existe um título principal da página
    E "Meus Cofrinhos" e "Qual o próximo objetivo?" seguem a hierarquia definida

  @vitest
  Cenário: A11Y-007 — Manter a hierarquia de títulos do detalhe
    Dado que o detalhe de Reserva está carregado
    Então "Reserva" é o título principal
    E "Aproveite mais o Cofrinho" e "Histórico" são títulos de seção

  @vitest @axe
  Esquema do Cenário: A11Y-008 — Validar as telas com axe
    Dado que a tela "<tela>" está no estado "<estado>"
    Quando executo a auditoria automatizada de acessibilidade
    Então não encontro violações críticas

    Exemplos:
      | tela    | estado  |
      | Hub     | exibido |
      | Hub     | oculto  |
      | Detalhe | exibido |
      | Detalhe | oculto  |

  @playwright
  Cenário: A11Y-009 — Respeitar as safe areas da WebView
    Dado que a aplicação está em um viewport com safe areas
    Quando acesso o Hub ou o detalhe
    Então o header respeita o inset superior
    E o último conteúdo respeita o inset inferior

  @vitest
  Cenário: A11Y-010 — Respeitar preferência de movimento reduzido
    Dado que a pessoa prefere movimento reduzido
    Quando skeletons e estados de foco são apresentados
    Então animações decorativas são reduzidas
