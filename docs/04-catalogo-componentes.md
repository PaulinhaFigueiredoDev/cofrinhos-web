# Catálogo de Componentes — Cofrinhos

| Campo | Valor |
|---|---|
| Documento | Inventário e contrato dos componentes visuais |
| Produto | Hub e detalhe de Cofrinhos |
| Versão | 1.0.0 |
| Organização | Atomic Design |
| Estilos | CSS Modules com BEM |

## 1. Objetivo

Este documento define os componentes próprios necessários para reproduzir as telas de referência. Ele registra composição, responsabilidades, propriedades, variações, semântica e estados.

As imagens representam duas telas:

- Hub de Cofrinhos em diferentes posições de rolagem e com saldo exibido ou oculto.
- Detalhe do Cofrinho em diferentes posições de rolagem e com saldo exibido ou oculto.

Os componentes devem ser construídos de forma reutilizável. O fluxo funcional da entrega está concentrado em visibilidade do saldo, navegação para o detalhe e retorno ao Hub.

## 2. Mapa das telas

### Hub de Cofrinhos

```text
PaginaCofrinhos
└── TemplateHubCofrinhos
    ├── HeaderNavegacao
    │   ├── BotaoIcone — voltar
    │   ├── BotaoVisibilidadeSaldo
    │   └── BotaoIcone — ajuda
    ├── ResumoCofrinhos
    │   ├── ValorMonetario — total guardado
    │   ├── LinhaRendimento
    │   └── TagCdi
    ├── CardDestaque — Desafio dos Cofrinhos
    ├── SecaoConteudo — Meus Cofrinhos como título principal
    │   ├── ListaCofrinhos
    │   │   └── CartaoCofrinho[]
    │   └── BotaoNovoCofrinho
    └── SecaoConteudo — Qual o próximo objetivo?
        └── ListaAtalhos — tamanho médio
            └── Atalho[]
```

### Detalhe do Cofrinho

```text
PaginaDetalheCofrinho
└── TemplateDetalheCofrinho
    ├── HeaderNavegacao
    │   ├── BotaoIcone — voltar
    │   ├── BotaoVisibilidadeSaldo
    │   ├── BotaoIcone — ajuda
    │   └── BotaoIcone — editar
    ├── CabecalhoDetalheCofrinho
    │   ├── IlustracaoCofrinho
    │   ├── título
    │   └── ValorMonetario — valor guardado
    ├── LinhaRendimento
    ├── ListaAtalhos — tamanho pequeno
    │   └── Atalho[]
    ├── SecaoConteudo — Aproveite mais o Cofrinho
    │   └── CarrosselRecomendacoes
    │       ├── CardRecomendacao
    │       └── IndicadorPaginacao
    └── SecaoHistorico
        ├── GrupoAbasHistorico
        └── ListaHistorico
            ├── GrupoHistoricoData
            └── ItemHistorico
```

## 3. Regras compartilhadas

### Reutilização entre telas

Todos os elementos com anatomia ou comportamento equivalente partem do mesmo componente de base. Hub e detalhe configuram propriedades; não mantêm cópias próprias desses componentes.

| Base reutilizável | Configuração no Hub | Configuração no detalhe |
|---|---|---|
| `HeaderNavegacao` | voltar, visibilidade e ajuda | voltar, visibilidade, ajuda e editar |
| `BotaoIcone` | voltar e ajuda | voltar, ajuda, editar e controles visuais |
| `BotaoVisibilidadeSaldo` | estado global | o mesmo estado global |
| `ValorMonetario` | total, rendimento e cards | saldo, rendimento e histórico |
| `LinhaRendimento` | rótulo “Rendeu” + `TagCdi` | rótulo “Rendimento bruto” + valor |
| `Atalho` | tamanho médio | tamanho pequeno |
| `ListaAtalhos` | objetivos sugeridos | ações do cofrinho |
| `SecaoConteudo` | seções do Hub | recomendações e histórico |

Componentes específicos existem somente quando a estrutura é própria, como `ResumoCofrinhos`, `CabecalhoDetalheCofrinho`, `TemplateHubCofrinhos` e `TemplateDetalheCofrinho`.

### Componentes próprios

Todos os elementos visuais serão implementados no projeto. Os SVGs do Phosphor Icons serão acessados exclusivamente pelo componente próprio `Icone`.

### Área de interação

- Alvos interativos possuem área mínima de 44 × 44 CSS pixels.
- Todo controle operável possui foco visível.
- Botões com apenas ícone exigem nome acessível.
- Um componente clicável não contém outro componente clicável.

### Componentes preparados para evolução

Componentes de ação recebem callback opcional:

```ts
type AcaoOpcional = {
  aoAtivar?: () => void;
};
```

Quando `aoAtivar` estiver presente, o componente executa a ação. As instâncias atuais sem ação usam `aria-disabled="true"` e impedem ativação.

### Valores monetários

Todos os valores passam pelo componente `ValorMonetario`. Esse componente é a única fronteira responsável por formatação e máscara de privacidade.

### Scroll horizontal

Listas horizontais usam scroll nativo, `scroll-snap`, toque, trackpad e teclado. Uma parte do próximo item permanece visível para indicar continuidade.

## 4. Tokens necessários

Antes dos componentes, serão criados tokens para:

| Grupo | Exemplos de uso |
|---|---|
| Cor | fundo, texto, texto secundário, azul de ação, verde financeiro, borda |
| Tipografia | título de página, título de seção, corpo, legenda, valor monetário |
| Espaçamento | padding de página, gap de cards, espaçamento interno |
| Borda | divisores e contorno dos cards |
| Raio | cards, tags, atalhos e botões circulares |
| Tamanho | ícones, ilustrações, altura mínima de controles |
| Foco | cor, largura e afastamento do outline |
| Movimento | transição de foco e redução de movimento |
| Layout | largura máxima, safe areas e gutters |

## 4.1 Mapa de HTML semântico

| Componente ou região | Elemento principal | Regra |
|---|---|---|
| Página | `<main>` | um por rota |
| `HeaderNavegacao` | `<header>` + `<nav>` | `nav` nomeado como “Navegação da página” |
| `BotaoIcone` | `<button type="button">` | usado para ações |
| `BotaoVisibilidadeSaldo` | `<button type="button">` | usa `aria-pressed` |
| `CartaoCofrinho` | `<a>` via `Link` | toda a superfície é um único link |
| `ListaCofrinhos` | `<ul>` + `<li>` | um item por cofrinho |
| `ListaAtalhos` | `<ul>` + `<li>` | contém botões `Atalho` |
| `Atalho` | `<button type="button">` | ação preparada para evolução |
| `TagCdi` | `<span>` | texto estático |
| `SecaoConteudo` | `<section>` | associada ao heading com `aria-labelledby` |
| `CardDestaque` | `<button type="button">` | card de ação preparado para evolução |
| `CardRecomendacao` | `<article>` | recomendação independente |
| `GrupoAbasHistorico` | container com `role="tablist"` | agrupa as abas |
| `AbaHistorico` | `<button role="tab">` | informa `aria-selected` |
| `ListaHistorico` | `<ul>` + `<li>` | agrupa registros por data |
| Data do histórico | `<time datetime>` | data legível e valor ISO |
| `EstadoErro` | região com heading | mensagem e ação de nova tentativa |

Hierarquia do Hub:

```text
main
├── header/nav
├── resumo financeiro
├── button — destaque
├── section
│   ├── h1 — Meus Cofrinhos
│   └── ul — lista de cofrinhos
└── section
    ├── h2 — Qual o próximo objetivo?
    └── ul — lista de atalhos
```

Hierarquia do detalhe:

```text
main
├── header/nav
├── h1 — nome do cofrinho
├── section — ações do cofrinho
├── section
│   ├── h2 — Aproveite mais o Cofrinho
│   └── article — recomendação
└── section
    ├── h2 — Histórico
    ├── tablist
    └── ul — registros
```

`ValorMonetario` usa `<span>`. Quando o saldo estiver oculto, o valor real também fica ausente dos atributos HTML.

## 5. Átomos

### 5.1 `Icone`

Responsabilidade: renderizar um SVG local com dimensões e cor consistentes.

Fonte de ativos: Phosphor Icons, distribuído sob licença MIT. O pacote fica encapsulado por este componente; as páginas não importam ícones diretamente.

```ts
type NomeIcone =
  | "voltar"
  | "olho-aberto"
  | "olho-fechado"
  | "ajuda"
  | "editar"
  | "chevron-direita"
  | "adicionar"
  | "fechar"
  | "reserva"
  | "casa"
  | "viagem"
  | "casamento"
  | "celular"
  | "guardar"
  | "resgatar"
  | "programar"
  | "pix"
  | "deposito";

type PropriedadesIcone = {
  nome: NomeIcone;
  tamanho?: "pequeno" | "medio" | "grande";
  variante?: "interface" | "ilustracao";
  decorativo?: boolean;
};
```

Regras:

- SVG usa `currentColor` quando a arte permitir.
- Ícone decorativo recebe `aria-hidden="true"`.
- Nome acessível pertence ao botão ou link que contém o ícone.
- `variante="interface"` usa peso `regular`.
- `variante="ilustracao"` usa peso `duotone`.

### Catálogo Phosphor

| Nome interno | Ícone Phosphor | Variação | Uso |
|---|---|---|---|
| `voltar` | `CaretLeftIcon` | interface | headers |
| `olho-aberto` | `EyeIcon` | interface | saldo exibido |
| `olho-fechado` | `EyeSlashIcon` | interface | saldo oculto |
| `ajuda` | `QuestionIcon` | interface | headers |
| `editar` | `PencilSimpleIcon` | interface | detalhe |
| `chevron-direita` | `CaretRightIcon` | interface | cards e linhas |
| `adicionar` | `PlusIcon` | interface | Novo Cofrinho |
| `fechar` | `XIcon` | interface | recomendação |
| `reserva` | `PiggyBankIcon` | ilustração | cofrinho Reserva |
| `casa` | `HouseIcon` | ilustração | cofrinho Casa |
| `viagem` | `SuitcaseRollingIcon` | ilustração | atalho Viagem |
| `casamento` | `DiamondIcon` | ilustração | atalho Casamento |
| `celular` | `DeviceMobileIcon` | ilustração | atalho Celular |
| `guardar` | `CurrencyCircleDollarIcon` | interface | atalho Guardar |
| `resgatar` | `HandWithdrawIcon` | interface | atalho Resgatar |
| `programar` | `ArrowClockwiseIcon` | interface | atalho Programar |
| `pix` | `QrCodeIcon` | interface | atalho Pix |
| `deposito` | `CurrencyCircleDollarIcon` | interface | histórico |

Trecho da implementação esperada:

```tsx
import {
  CaretLeftIcon,
  CaretRightIcon,
  EyeIcon,
  EyeSlashIcon,
  HouseIcon,
  PiggyBankIcon,
  QuestionIcon,
} from "@phosphor-icons/react";

const catalogoIcones = {
  voltar: CaretLeftIcon,
  "chevron-direita": CaretRightIcon,
  "olho-aberto": EyeIcon,
  "olho-fechado": EyeSlashIcon,
  ajuda: QuestionIcon,
  reserva: PiggyBankIcon,
  casa: HouseIcon,
} satisfies Partial<Record<NomeIcone, PhosphorIcon>>;
```

O catálogo completo deve permanecer no arquivo do componente `Icone`. Adicionar um SVG à interface significa registrar um novo nome interno e seu componente Phosphor.

### 5.2 `BotaoIcone`

Responsabilidade: oferecer uma ação compacta composta somente por ícone.

```ts
type PropriedadesBotaoIcone = {
  rotulo: string;
  icone: NomeIcone;
  aoAtivar?: () => void;
  estado?: "padrao" | "indisponivel";
};
```

Usos nas referências:

- Voltar.
- Ajuda.
- Editar.
- Fechar card de recomendação.
- Navegação do carrossel.

Semântica: `<button type="button">`.

### 5.3 `BotaoVisibilidadeSaldo`

Responsabilidade: alternar o estado global de privacidade.

```ts
type PropriedadesBotaoVisibilidadeSaldo = {
  visibilidade: "exibido" | "oculto";
  aoAlternar: () => void;
};
```

Variações:

| Estado atual | Ícone | Nome acessível |
|---|---|---|
| Exibido | olho aberto | Ocultar saldos |
| Oculto | olho fechado | Exibir saldos |

Semântica: `<button type="button" aria-pressed>`.

`aria-pressed` é `true` quando a privacidade está ativa, isto é, quando `visibilidade="oculto"`.

### 5.4 `ValorMonetario`

Responsabilidade: formatar ou mascarar valores.

```ts
type PropriedadesValorMonetario = {
  valorEmCentavos: number;
  visibilidade: "exibido" | "oculto";
  enfase?: "principal" | "secundaria" | "positiva";
};
```

Saídas:

- Exibido: `R$ 1,00`.
- Oculto: `R$ ••••`.

Semântica: `<span>`. Quando oculto, o leitor de tela recebe “Saldo oculto”.

### 5.5 `TagCdi`

Responsabilidade: exibir o rótulo estático da rentabilidade de referência.

```ts
type PropriedadesTagCdi = {
  texto?: "100% do CDI";
};
```

Conteúdo padrão: `100% do CDI`.

Semântica: `<span>`. Aparência verde, texto branco e cantos arredondados.

### 5.6 `Divisor`

Responsabilidade: separar grupos de conteúdo.

```ts
type PropriedadesDivisor = {
  orientacao?: "horizontal";
};
```

Semântica: elemento decorativo com `aria-hidden="true"` ou borda CSS do container.

### 5.7 `TituloSecao`

Responsabilidade: padronizar o título principal “Meus Cofrinhos” e títulos de seção como “Qual o próximo objetivo?”, “Aproveite mais o Cofrinho” e “Histórico”.

```ts
type PropriedadesTituloSecao = {
  filhos: React.ReactNode;
  nivel: 1 | 2 | 3;
};
```

Renderiza o nível de heading correspondente à hierarquia da página.

No Hub, “Meus Cofrinhos” usa nível 1. No detalhe, o nome do cofrinho é o nível 1 e os demais títulos usam nível 2 ou 3 conforme a composição.

### 5.8 `IlustracaoCofrinho`

Responsabilidade: renderizar a ilustração correspondente à categoria.

```ts
type PropriedadesIlustracaoCofrinho = {
  tipo: "reserva" | "casa";
  tamanho?: "cartao" | "detalhe";
  nome?: string;
};
```

A ilustração é decorativa quando o nome já está visível ao lado.

`IlustracaoCofrinho` compõe `Icone` com `variante="ilustracao"`. O tamanho `cartao` corresponde ao token médio e `detalhe` ao token grande.

### 5.9 `Skeleton`

Responsabilidade: reservar o espaço de conteúdo durante carregamento.

```ts
type PropriedadesSkeleton = {
  variante: "texto" | "icone" | "cartao";
};
```

Respeita `prefers-reduced-motion` e integra os organismos de loading.

## 6. Moléculas

### 6.1 `HeaderNavegacao`

Responsabilidade: organizar navegação e ações superiores.

Referência visual dedicada: `header-navigation.png`.

```ts
type PropriedadesHeaderNavegacao = {
  aoVoltar?: () => void;
  visibilidade: "exibido" | "oculto";
  aoAlternarVisibilidade: () => void;
  exibirAjuda?: boolean;
  exibirEdicao?: boolean;
  aoAbrirAjuda?: () => void;
  aoEditar?: () => void;
};
```

Composição:

- `BotaoIcone` de voltar à esquerda.
- Grupo de ações à direita.
- `BotaoVisibilidadeSaldo`.
- `BotaoIcone` de ajuda.
- `BotaoIcone` de editar somente no detalhe.

Variações:

| Variação | Composição | Uso |
|---|---|---|
| `padrao` | voltar + visibilidade + ajuda | Hub e referência `header-navigation.png` |
| `detalhe` | voltar + visibilidade + ajuda + editar | Detalhe do cofrinho |

O componente nasce completo em estrutura, responsividade, semântica e estados. Ele não será remontado diretamente nas páginas. Hub e detalhe apenas configuram as propriedades da mesma implementação.

Comportamento na entrega:

- Visibilidade possui ação funcional e alterna entre olho aberto e fechado.
- Voltar possui ação funcional no detalhe e navega para `/cofrinhos`.
- Voltar no Hub preserva a composição da referência com `aria-disabled="true"`.
- Ações sem callback usam `aria-disabled="true"` e preservam a composição visual.
- Cada ação reutiliza `BotaoIcone`; os SVGs não são inseridos diretamente no header.

Layout:

- Usa safe area superior.
- Mantém os botões alinhados e espaçados.
- Permanece no fluxo da página; não precisa ser sticky.
- Distribui a ação de voltar à esquerda e o grupo de ações à direita.
- Mantém altura e espaçamentos consistentes nas duas variações.

### 6.2 `LinhaRendimento`

Responsabilidade: apresentar rótulo, valor e complemento à direita.

```ts
type PropriedadesLinhaRendimento = {
  rotulo: "Rendeu" | "Rendimento bruto";
  valorEmCentavos: number;
  visibilidade: "exibido" | "oculto";
  complemento?: React.ReactNode;
  exibirChevron?: boolean;
};
```

No Hub, `complemento` recebe `TagCdi`. No detalhe, apresenta o valor alinhado à direita e o chevron visual.

### 6.3 `CartaoCofrinho`

Responsabilidade: resumir um cofrinho e navegar ao detalhe.

```ts
type PropriedadesCartaoCofrinho = {
  cofrinho: Cofrinho;
  visibilidade: "exibido" | "oculto";
  href: `/cofrinhos/${string}`;
};
```

O componente nasce completo e recebe os dados necessários para resolver ilustração, nome, valor e destino. A página não monta partes internas do card.

Composição:

- `IlustracaoCofrinho`.
- Nome.
- `ValorMonetario`.
- `Icone` chevron-direita.

### Ilustração SVG

`cofrinho.icone` contém um identificador de domínio, como `reserva` ou `casa`. `IlustracaoCofrinho` delega a resolução do SVG ao catálogo interno de `Icone`:

```tsx
function IlustracaoCofrinho({ tipo, tamanho }: PropriedadesIlustracaoCofrinho) {
  return (
    <Icone
      nome={tipo}
      tamanho={tamanho === "detalhe" ? "grande" : "medio"}
      variante="ilustracao"
      decorativo
    />
  );
}
```

Essa solução mantém SVG e React fora do modelo de domínio e concentra todos os imports do Phosphor no componente `Icone`.

### Valor

O card recebe `saldoEmCentavos` dentro de `cofrinho` e delega a apresentação a `ValorMonetario`:

```tsx
<ValorMonetario
  valorEmCentavos={cofrinho.saldoEmCentavos}
  visibilidade={visibilidade}
  enfase="principal"
/>
```

O card não formata moeda nem implementa a máscara diretamente.

### Área clicável

Semântica: um único `<Link>` envolve toda a superfície do card. Ilustração, nome, valor e chevron pertencem ao mesmo alvo de navegação. Não existem botões ou links aninhados.

O nome acessível começa com “Abrir cofrinho Reserva”. O saldo permanece disponível como descrição do conteúdo; quando oculto, a árvore acessível recebe “Saldo oculto”.

Estrutura esperada:

```tsx
<Link
  href={`/cofrinhos/${cofrinho.id}`}
  className={styles["cartao-cofrinho"]}
>
  <VisualmenteOculto>Abrir cofrinho</VisualmenteOculto>
  <IlustracaoCofrinho tipo={cofrinho.icone} tamanho="cartao" />
  <span className={styles["cartao-cofrinho__nome"]}>
    {cofrinho.nome}
  </span>
  <ValorMonetario
    valorEmCentavos={cofrinho.saldoEmCentavos}
    visibilidade={visibilidade}
    enfase="principal"
  />
  <Icone nome="chevron-direita" decorativo />
</Link>
```

Estados:

- Padrão.
- Hover em dispositivos compatíveis.
- Foco visível.
- Saldo exibido.
- Saldo oculto.

### 6.4 `BotaoNovoCofrinho`

Responsabilidade: representar a futura entrada de criação preservando o layout da referência.

```ts
type PropriedadesBotaoNovoCofrinho = {
  aoAtivar?: () => void;
};
```

Composição:

- Texto “Novo Cofrinho”.
- `Icone` adicionar.

Semântica: `<button type="button">`, com `aria-disabled="true"` na instância atual.

### 6.5 `Atalho`

Responsabilidade: representar um shortcut reutilizável no Hub e no detalhe.

```ts
type PropriedadesAtalho = {
  titulo: string;
  ilustracao: React.ReactNode;
  tamanho: "pequeno" | "medio";
  variante?: "destaque" | "neutra";
  aoAtivar?: () => void;
};
```

Tamanhos:

| Tamanho | Uso | Característica |
|---|---|---|
| `medio` | Hub: Viagem, Casamento e Celular | card mais largo e alto, ilustração de objetivo |
| `pequeno` | Detalhe: Guardar, Resgatar, Programar e Pix | card compacto, ícone de ação |

Variações visuais:

- `destaque`: fundo azul e conteúdo branco, usado em Guardar.
- `neutra`: fundo cinza claro, ícone azul e texto escuro.

Semântica: `<button type="button">`. As instâncias atuais recebem `aria-disabled="true"`. O tamanho altera dimensões e espaçamentos, preservando a mesma estrutura de ilustração + título.

### 6.6 `CardDestaque`

Responsabilidade: apresentar o banner “Desafio dos Cofrinhos”.

```ts
type PropriedadesCardDestaque = {
  titulo: string;
  descricao: string;
  ilustracao: "desafio";
  aoAtivar?: () => void;
};
```

Composição: ilustração, bloco textual e chevron. A instância atual usa `aria-disabled="true"`.

### 6.7 `IndicadorPaginacao`

Responsabilidade: comunicar a posição visual do carrossel de recomendações.

```ts
type PropriedadesIndicadorPaginacao = {
  total: number;
  atual: number;
};
```

Composição: marcador ativo azul e marcadores inativos cinza. Inclui texto acessível “Item 1 de 3”.

### 6.8 `AbaHistorico`

Responsabilidade: representar uma opção do grupo Tudo, Depósitos e Resgates.

```ts
type PropriedadesAbaHistorico = {
  id: "tudo" | "depositos" | "resgates";
  rotulo: string;
  selecionada: boolean;
  aoSelecionar?: () => void;
};
```

Semântica: `<button role="tab">`. A aba Tudo aparece selecionada no conteúdo mockado.

### 6.9 `ItemHistorico`

Responsabilidade: apresentar um registro financeiro mockado.

```ts
type PropriedadesItemHistorico = {
  tipo: "deposito";
  descricao: string;
  valorEmCentavos: number;
  visibilidade: "exibido" | "oculto";
  aoAtivar?: () => void;
};
```

Composição: ícone, descrição, `ValorMonetario` e chevron. A instância atual é conteúdo demonstrativo.

## 7. Organismos

### 7.1 `ResumoCofrinhos`

Responsabilidade: compor o resumo financeiro superior do Hub.

```ts
type PropriedadesResumoCofrinhos = {
  totalEmCentavos: number;
  rendimentoEmCentavos: number;
  visibilidade: "exibido" | "oculto";
};
```

Composição:

- Rótulo “Total guardado”.
- `ValorMonetario` principal.
- `Divisor`.
- `LinhaRendimento` com rótulo “Rendeu”.
- `TagCdi` estática.

### 7.2 `ListaCofrinhos`

Responsabilidade: renderizar a coleção de cofrinhos.

```ts
type PropriedadesListaCofrinhos = {
  cofrinhos: Cofrinho[];
  visibilidade: "exibido" | "oculto";
};
```

Semântica: `<ul>` com um `CartaoCofrinho` por `<li>`.

### 7.3 `CabecalhoDetalheCofrinho`

Responsabilidade: apresentar a identidade e o saldo principal do detalhe.

```ts
type PropriedadesCabecalhoDetalheCofrinho = {
  cofrinho: Cofrinho;
  visibilidade: "exibido" | "oculto";
};
```

Composição:

- `IlustracaoCofrinho` em tamanho detalhe.
- `<h1>` com o nome.
- Rótulo “Valor guardado”.
- `ValorMonetario` principal.
- `Divisor`.

### 7.4 `ListaAtalhos`

Responsabilidade: organizar os atalhos reutilizáveis em rolagem horizontal nas duas telas.

```ts
type PropriedadesListaAtalhos = {
  atalhos: AtalhoDados[];
  tamanho: "pequeno" | "medio";
  rotulo: string;
};
```

Usos:

- Hub: `tamanho="medio"` e rótulo “Qual o próximo objetivo?”.
- Detalhe: `tamanho="pequeno"` e rótulo “Ações do cofrinho”.

Layout sugerido:

```css
.lista-atalhos {
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: minmax(10rem, 42%);
  gap: var(--espaco-4);
  overflow-x: auto;
  overscroll-behavior-inline: contain;
  scroll-snap-type: inline mandatory;
}
```

### 7.5 `CardRecomendacao`

Responsabilidade: apresentar a recomendação “Guardando todo mês você chega mais rápido ao objetivo”.

```ts
type PropriedadesCardRecomendacao = {
  titulo: string;
  chamada: string;
  icone: "programar";
  aoFechar?: () => void;
  aoAtivar?: () => void;
};
```

Composição:

- Ícone superior.
- Controle de fechar.
- Título.
- Divisor.
- Chamada inferior.
- Botão circular com chevron.

A instância atual usa estrutura preparada para callbacks e estado indisponível nas ações.

### 7.6 `CarrosselRecomendacoes`

Responsabilidade: organizar o card de recomendação e seus indicadores.

```ts
type PropriedadesCarrosselRecomendacoes = {
  itens: Recomendacao[];
  indiceAtual: number;
};
```

Composição:

- Faixa horizontal de cards.
- Setas visuais laterais.
- `IndicadorPaginacao`.

O conteúdo inicial é mockado e a faixa usa scroll horizontal nativo.

### 7.7 `GrupoAbasHistorico`

Responsabilidade: compor as abas Tudo, Depósitos e Resgates.

```ts
type PropriedadesGrupoAbasHistorico = {
  selecionada: "tudo" | "depositos" | "resgates";
};
```

Composição: três `AbaHistorico` e indicador inferior da aba selecionada.

### 7.8 `GrupoHistoricoData`

Responsabilidade: agrupar registros por data.

```ts
type PropriedadesGrupoHistoricoData = {
  data: string;
  itens: ItemHistoricoDados[];
  visibilidade: "exibido" | "oculto";
};
```

Composição: heading da data e lista de `ItemHistorico`.

### 7.9 `SecaoHistorico`

Responsabilidade: compor o histórico mockado do detalhe.

```ts
type PropriedadesSecaoHistorico = {
  grupos: GrupoHistoricoDados[];
  visibilidade: "exibido" | "oculto";
};
```

Composição:

- `TituloSecao` “Histórico”.
- `GrupoAbasHistorico` com Tudo selecionado.
- `GrupoHistoricoData`.

### 7.10 `SecaoConteudo`

Responsabilidade: padronizar a relação entre título e conteúdo das seções do Hub e detalhe.

```ts
type PropriedadesSecaoConteudo = {
  titulo: string;
  nivelTitulo: 1 | 2 | 3;
  filhos: React.ReactNode;
};
```

Composição: `TituloSecao` e conteúdo recebido. Semântica: `<section aria-labelledby>`.

### 7.11 `ListaHistorico`

Responsabilidade: organizar os grupos de registros históricos mockados.

```ts
type PropriedadesListaHistorico = {
  grupos: GrupoHistoricoDados[];
  visibilidade: "exibido" | "oculto";
};
```

Composição: um `GrupoHistoricoData` para cada data disponível.

## 8. Templates

### 8.1 `TemplateHubCofrinhos`

Responsabilidade: definir a ordem e o espaçamento das seções do Hub.

```ts
type PropriedadesTemplateHubCofrinhos = {
  cofrinhos: Cofrinho[];
  visibilidade: "exibido" | "oculto";
  aoAlternarVisibilidade: () => void;
};
```

Ordem:

1. `HeaderNavegacao`.
2. `ResumoCofrinhos`.
3. `CardDestaque`.
4. `SecaoConteudo` com “Meus Cofrinhos” em `<h1>`.
5. `ListaCofrinhos`.
6. `BotaoNovoCofrinho`.
7. “Qual o próximo objetivo?”.
8. `ListaAtalhos` com tamanho médio.

### 8.2 `TemplateDetalheCofrinho`

Responsabilidade: definir a ordem e o espaçamento das seções do detalhe.

```ts
type PropriedadesTemplateDetalheCofrinho = {
  cofrinho: Cofrinho;
  visibilidade: "exibido" | "oculto";
  aoAlternarVisibilidade: () => void;
  aoVoltar: () => void;
};
```

Ordem:

1. `HeaderNavegacao`.
2. `CabecalhoDetalheCofrinho`.
3. `LinhaRendimento`.
4. `ListaAtalhos` com tamanho pequeno.
5. “Aproveite mais o Cofrinho”.
6. `CarrosselRecomendacoes`.
7. `SecaoHistorico`.

## 9. Componentes de estado

### 9.1 `CarregamentoHub`

Combina skeletons de resumo e dois cartões. Possui texto acessível “Carregando cofrinhos”.

### 9.2 `CarregamentoDetalhe`

Combina skeletons da ilustração, título, valores e atalhos. Possui texto acessível “Carregando cofrinho”.

### 9.3 `EstadoErro`

```ts
type PropriedadesEstadoErro = {
  titulo: string;
  mensagem: string;
  aoTentarNovamente: () => void;
};
```

Composição: título, mensagem e botão “Tentar novamente”.

### 9.4 `EstadoCofrinhoNaoEncontrado`

Composição: heading “Cofrinho não encontrado”, texto de apoio e link para `/cofrinhos`.

## 10. Matriz de uso

| Componente | Hub | Detalhe | Exibido | Oculto |
|---|:---:|:---:|:---:|:---:|
| `HeaderNavegacao` | ✓ | ✓ | ✓ | ✓ |
| `BotaoVisibilidadeSaldo` | ✓ | ✓ | ✓ | ✓ |
| `ResumoCofrinhos` | ✓ |  | ✓ | ✓ |
| `TagCdi` | ✓ |  | ✓ | ✓ |
| `CardDestaque` | ✓ |  | ✓ | ✓ |
| `CartaoCofrinho` | ✓ |  | ✓ | ✓ |
| `BotaoNovoCofrinho` | ✓ |  | ✓ | ✓ |
| `ListaAtalhos` médio | ✓ |  | ✓ | ✓ |
| `CabecalhoDetalheCofrinho` |  | ✓ | ✓ | ✓ |
| `LinhaRendimento` | ✓ | ✓ | ✓ | ✓ |
| `ListaAtalhos` pequeno |  | ✓ | ✓ | ✓ |
| `CarrosselRecomendacoes` |  | ✓ | ✓ | ✓ |
| `SecaoHistorico` |  | ✓ | ✓ | ✓ |
| `SecaoConteudo` | ✓ | ✓ | ✓ | ✓ |
| `ValorMonetario` | ✓ | ✓ | ✓ | ✓ |

## 11. Prioridade de implementação

### Prioridade 1 — fluxo principal

1. `Icone`.
2. `BotaoIcone`.
3. `BotaoVisibilidadeSaldo`.
4. `ValorMonetario`.
5. `HeaderNavegacao`.
6. `CartaoCofrinho`.
7. `ListaCofrinhos`.
8. `ResumoCofrinhos`.
9. `CabecalhoDetalheCofrinho`.
10. `TemplateHubCofrinhos`.
11. `TemplateDetalheCofrinho`.

### Prioridade 2 — composição visual

1. `TagCdi`.
2. `LinhaRendimento`.
3. `Atalho`.
4. `ListaAtalhos`.
5. `BotaoNovoCofrinho`.
6. `CardDestaque`.

### Prioridade 3 — conteúdo complementar

1. `CardRecomendacao`.
2. `CarrosselRecomendacoes`.
3. `IndicadorPaginacao`.
4. `AbaHistorico`.
5. `ItemHistorico`.
6. `GrupoHistoricoData`.
7. `SecaoHistorico`.
8. `SecaoConteudo`.
9. `ListaHistorico`.

### Prioridade 4 — estados

1. `Skeleton`.
2. `CarregamentoHub`.
3. `CarregamentoDetalhe`.
4. `EstadoErro`.
5. `EstadoCofrinhoNaoEncontrado`.

## 12. Cobertura mínima de testes

| Componente | Testes essenciais com Vitest |
|---|---|
| `BotaoVisibilidadeSaldo` | ícone, nome acessível, `aria-pressed` e callback |
| `ValorMonetario` | formatação, máscara e árvore acessível |
| `HeaderNavegacao` | voltar e composição das ações por tela |
| `CartaoCofrinho` | conteúdo, href e navegação por teclado |
| `ResumoCofrinhos` | total, rendimento e tag estática |
| `Atalho` | tamanhos, variantes, `aria-disabled` e bloqueio de ativação |
| `ListaAtalhos` | tamanhos médio/pequeno, ordem e semântica de lista |
| `CabecalhoDetalheCofrinho` | nome, ilustração e privacidade |
| `GrupoAbasHistorico` | Tudo selecionado e semântica de tabs |
| `EstadoErro` | mensagem e nova tentativa |
| `EstadoCofrinhoNaoEncontrado` | heading e retorno ao Hub |

Os componentes estruturais principais também devem passar por `vitest-axe`.

## 13. Estrutura de arquivos sugerida

```text
src/components/
├── atoms/
│   ├── BotaoIcone/
│   ├── BotaoVisibilidadeSaldo/
│   ├── Divisor/
│   ├── Icone/
│   ├── IlustracaoCofrinho/
│   ├── Skeleton/
│   ├── TagCdi/
│   ├── TituloSecao/
│   └── ValorMonetario/
├── molecules/
│   ├── AbaHistorico/
│   ├── Atalho/
│   ├── BotaoNovoCofrinho/
│   ├── CardDestaque/
│   ├── CartaoCofrinho/
│   ├── HeaderNavegacao/
│   ├── IndicadorPaginacao/
│   ├── ItemHistorico/
│   └── LinhaRendimento/
├── organisms/
│   ├── CabecalhoDetalheCofrinho/
│   ├── CardRecomendacao/
│   ├── CarrosselRecomendacoes/
│   ├── GrupoAbasHistorico/
│   ├── GrupoHistoricoData/
│   ├── ListaAtalhos/
│   ├── ListaCofrinhos/
│   ├── ListaHistorico/
│   ├── ResumoCofrinhos/
│   ├── SecaoConteudo/
│   └── SecaoHistorico/
├── templates/
│   ├── TemplateDetalheCofrinho/
│   └── TemplateHubCofrinhos/
└── states/
    ├── CarregamentoDetalhe/
    ├── CarregamentoHub/
    ├── EstadoCofrinhoNaoEncontrado/
    └── EstadoErro/
```

Cada pasta contém:

```text
NomeComponente/
├── NomeComponente.tsx
├── NomeComponente.module.css
└── NomeComponente.test.tsx
```
