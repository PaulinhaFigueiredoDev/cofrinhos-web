import type { IconProps } from "@phosphor-icons/react";
import {
  ArrowClockwiseIcon,
  CaretLeftIcon,
  CaretRightIcon,
  CurrencyCircleDollarIcon,
  DeviceMobileIcon,
  DiamondIcon,
  EyeIcon,
  EyeSlashIcon,
  HandWithdrawIcon,
  HouseIcon,
  PencilSimpleIcon,
  PiggyBankIcon,
  PlusIcon,
  QrCodeIcon,
  QuestionIcon,
  SuitcaseRollingIcon,
  XIcon,
} from "@phosphor-icons/react";

// NomeIcone impede nomes inválidos como "olho-aberto-2" ou "olho-aberto-3", que não existem no diretório de ícones.
export type NomeIcone =
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

// TamanhoIcone limitando os tamanhos aceitos
export type TamanhoIcone = "pequeno" | "medio" | "grande";

// VarianteIcone separando ícones de interface de ilustrações.
export type VarianteIcone = "interface" | "ilustracao";

// PropriedadesIcone define as propriedades aceitas para o componente de ícone.
type PropriedadesIconeComuns = {
  nome: NomeIcone;
  tamanho?: TamanhoIcone;
  variante?: VarianteIcone;
};

export type PropriedadesIcone =
  | (PropriedadesIconeComuns & {
      decorativo: true;
      "aria-label"?: never;
    })
  | (PropriedadesIconeComuns & {
      decorativo?: false;
      "aria-label": string;
    });

const catalogoIcones = {
  voltar: CaretLeftIcon,
  "olho-aberto": EyeIcon,
  "olho-fechado": EyeSlashIcon,
  ajuda: QuestionIcon,
  editar: PencilSimpleIcon,
  "chevron-direita": CaretRightIcon,
  adicionar: PlusIcon,
  fechar: XIcon,
  reserva: PiggyBankIcon,
  casa: HouseIcon,
  viagem: SuitcaseRollingIcon,
  casamento: DiamondIcon,
  celular: DeviceMobileIcon,
  guardar: CurrencyCircleDollarIcon,
  resgatar: HandWithdrawIcon,
  programar: ArrowClockwiseIcon,
  pix: QrCodeIcon,
  deposito: CurrencyCircleDollarIcon,
} satisfies Record<NomeIcone, React.ComponentType<IconProps>>;

const tamanhosIcone: Record<TamanhoIcone, number> = {
  pequeno: 16,
  medio: 24,
  grande: 40,
};

export function Icone({
  nome,
  tamanho = "medio",
  variante = "interface",
  decorativo = false,
  "aria-label": ariaLabel,
}: PropriedadesIcone) {
  const ComponenteIcone = catalogoIcones[nome];

  return (
    <ComponenteIcone
      size={tamanhosIcone[tamanho]}
      weight={variante === "ilustracao" ? "duotone" : "regular"}
      aria-hidden={decorativo}
      aria-label={decorativo ? undefined : ariaLabel}
    />
  );
}
