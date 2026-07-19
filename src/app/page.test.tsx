import { render, screen } from "@testing-library/react";
import { axe } from "vitest-axe";
import { describe, expect, it } from "vitest";
import Home from "./page";

describe("Página inicial", () => {
  it("exibe a identificação do projeto", () => {
    render(<Home />);

    expect(
      screen.getByRole("heading", { level: 1, name: "Cofrinhos Web" }),
    ).toBeInTheDocument();
  });

  it("não possui violações automatizadas de acessibilidade", async () => {
    const { container } = render(<Home />);
    const resultado = await axe(container);

    expect(resultado.violations).toEqual([]);
  });
});
