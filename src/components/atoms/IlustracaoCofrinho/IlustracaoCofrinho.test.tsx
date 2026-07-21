import { render } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import IlustracaoCofrinho from "./IlustracaoCofrinho";

describe("IlustracaoCofrinho", () => {
  it.each([
    ["reserva", "cartao", "24"],
    ["reserva", "detalhe", "40"],
    ["casa", "cartao", "24"],
    ["casa", "detalhe", "40"],
  ] as const)(
    "renderiza %s no tamanho %s",
    (tipo, tamanho, tamanhoEsperado) => {
      const { container } = render(
        <IlustracaoCofrinho tipo={tipo} tamanho={tamanho} />,
      );

      expect(container.querySelector("svg")).toHaveAttribute(
        "width",
        tamanhoEsperado,
      );
    },
  );

  it("renderiza a ilustração como conteúdo decorativo", () => {
    const { container } = render(
      <IlustracaoCofrinho tipo="reserva" tamanho="cartao" />,
    );

    expect(container.querySelector("svg")).toHaveAttribute(
      "aria-hidden",
      "true",
    );
  });
});
