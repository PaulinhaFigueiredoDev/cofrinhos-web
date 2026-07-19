# language: pt
@componentes
Funcionalidade: Exibir componentes visuais preparados para composição
  Como pessoa que visualiza a demonstração
  Quero encontrar uma interface consistente entre Hub e detalhe
  Para compreender a estrutura do produto

  @vitest
  Cenário: CMP-001 — Exibir a tag CDI como texto estático
    Dado que estou no Hub de Cofrinhos
    Então vejo a tag "100% do CDI"
    E a tag é apresentada como texto

  @vitest
  Cenário: CMP-002 — Exibir o header padrão no Hub
    Dado que estou no Hub de Cofrinhos
    Então o header apresenta "Voltar"
    E o header apresenta o controle de visibilidade
    E o header apresenta "Ajuda"
    E o botão "Voltar" apresenta estado acessível "indisponível"

  @vitest
  Cenário: CMP-003 — Exibir o header do detalhe
    Dado que estou no detalhe de Reserva
    Então o header apresenta "Voltar"
    E o header apresenta o controle de visibilidade
    E o header apresenta "Ajuda"
    E o header apresenta "Editar"

  @vitest
  Cenário: CMP-004 — Exibir atalhos médios no Hub
    Dado que estou no Hub de Cofrinhos
    Quando alcanço a seção "Qual o próximo objetivo?"
    Então vejo os atalhos "Viagem", "Casamento" e "Celular"
    E cada atalho usa o tamanho "medio"
    E cada atalho possui ilustração Phosphor em estilo duotone

  @vitest
  Cenário: CMP-005 — Exibir atalhos pequenos no detalhe
    Dado que estou no detalhe de Reserva
    Então vejo os atalhos "Guardar", "Resgatar", "Programar pra guardar" e "Receber Pix"
    E cada atalho usa o tamanho "pequeno"
    E o atalho "Guardar" usa a variação "destaque"
    E os demais atalhos usam a variação "neutra"

  @vitest @acessibilidade
  Cenário: CMP-006 — Comunicar o estado atual dos atalhos
    Dado que um atalho ainda não possui uma ação configurada
    Quando o atalho é renderizado
    Então ele utiliza a semântica de botão
    E possui o estado acessível "indisponível"
    E permanece alcançável por teclado
    E sua ativação preserva a rota atual

  @vitest
  Cenário: CMP-007 — Exibir atalhos em uma faixa horizontal
    Dado que existem mais atalhos do que o espaço horizontal disponível
    Quando a lista de atalhos é apresentada
    Então os atalhos permanecem em uma única faixa horizontal
    E parte do próximo atalho permanece visível

  @vitest
  Cenário: CMP-008 — Exibir o cartão completo de Reserva
    Dado que o Hub recebeu os dados de Reserva
    Então o cartão exibe uma ilustração Phosphor em estilo duotone
    E exibe o nome "Reserva"
    E exibe o valor monetário formatado
    E exibe um chevron decorativo
    E toda a superfície pertence ao mesmo link

  @vitest
  Cenário: CMP-009 — Exibir a entrada visual Novo Cofrinho
    Dado que estou no Hub de Cofrinhos
    Então vejo o texto "Novo Cofrinho"
    E vejo o ícone de adicionar
    E o componente apresenta estado acessível "indisponível"

  @vitest
  Cenário: CMP-010 — Exibir a recomendação do detalhe
    Dado que estou no detalhe de Reserva
    Quando alcanço a seção "Aproveite mais o Cofrinho"
    Então vejo a recomendação "Guardando todo mês você chega mais rápido ao objetivo"
    E vejo a chamada "Programe pra guardar"
    E vejo o indicador visual da primeira posição

  @vitest
  Cenário: CMP-011 — Exibir ícones consistentes
    Dado que a interface apresenta ícones funcionais e ilustrativos
    Quando visualizo o Hub e o detalhe
    Então os ícones funcionais usam o estilo regular do Phosphor
    E as ilustrações usam o estilo duotone do Phosphor
