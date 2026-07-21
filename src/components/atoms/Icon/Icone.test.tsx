import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { Icone } from "./Icone";

describe("Icone", () => {
  it("renderiza um ícone de interface com nome acessível", () => {
    render(<Icone nome="ajuda" aria-label="Ajuda" />);

    expect(screen.getByLabelText("Ajuda")).toBeInTheDocument();
  });

  it.each([
    ["pequeno", "16"],
    ["medio", "24"],
    ["grande", "40"],
  ] as const)("aplica o tamanho %s", (tamanho, valorEsperado) => {
    const { container } = render(
      <Icone nome="voltar" tamanho={tamanho} decorativo />,
    );

    expect(container.querySelector("svg")).toHaveAttribute(
      "width",
      valorEsperado,
    );
    expect(container.querySelector("svg")).toHaveAttribute(
      "height",
      valorEsperado,
    );
  });

  it("oculta um ícone decorativo da árvore acessível", () => {
    const { container } = render(<Icone nome="reserva" decorativo />);

    expect(container.querySelector("svg")).toHaveAttribute(
      "aria-hidden",
      "true",
    );
    expect(screen.queryByRole("img")).not.toBeInTheDocument();
  });

  it("renderiza uma ilustração com a variante de ilustração", () => {
    const { container } = render(
      <Icone nome="casa" variante="ilustracao" decorativo />,
    );

    expect(container.querySelector("svg")).toBeInTheDocument();
    expect(container.querySelector("svg")).toHaveAttribute(
      "aria-hidden",
      "true",
    );
  });
});
