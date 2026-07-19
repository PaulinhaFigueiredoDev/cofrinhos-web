import eslintConfigPrettier from "eslint-config-prettier/flat";
import { defineConfig, globalIgnores } from "eslint/config";
import nextTs from "eslint-config-next/typescript";
import nextVitals from "eslint-config-next/core-web-vitals";

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTs,
  eslintConfigPrettier,
  globalIgnores([
    ".next/**",
    "coverage/**",
    "out/**",
    "playwright-report/**",
    "public/mockServiceWorker.js",
    "test-results/**",
    "next-env.d.ts",
  ]),
]);

export default eslintConfig;
