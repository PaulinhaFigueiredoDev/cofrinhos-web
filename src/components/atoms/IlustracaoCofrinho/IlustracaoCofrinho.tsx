import { Icone, type NomeIcone, type TamanhoIcone } from "../Icon/Icone";

export type TipoCofrinho = "reserva" | "casa";

export type TamanhoIlustracao = "cartao" | "detalhe";

export type PropriedadesIlustracaoCofrinho = {
  tipo: TipoCofrinho;
  tamanho: TamanhoIlustracao;
};

const catalogoIlustracoes: Record<TipoCofrinho, NomeIcone> = {
  reserva: "reserva",
  casa: "casa",
};

const tamanhosIlustracao: Record<TamanhoIlustracao, TamanhoIcone> = {
  cartao: "medio",
  detalhe: "grande",
};

export default function IlustracaoCofrinho({
  tipo,
  tamanho,
}: PropriedadesIlustracaoCofrinho) {
  return (
    <Icone
      nome={catalogoIlustracoes[tipo]}
      tamanho={tamanhosIlustracao[tamanho]}
      variante="ilustracao"
      decorativo
    />
  );
}
