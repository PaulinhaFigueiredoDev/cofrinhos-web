import { expect, test } from "@playwright/test";

test("exibe a identificação do projeto", async ({ page }) => {
  await page.goto("/");

  await expect(
    page.getByRole("heading", { level: 1, name: "Cofrinhos Web" }),
  ).toBeVisible();
});
