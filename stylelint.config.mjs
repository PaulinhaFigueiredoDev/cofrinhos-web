/** @type {import("stylelint").Config} */
const config = {
  extends: ["stylelint-config-standard", "stylelint-config-css-modules"],
  rules: {
    "selector-class-pattern": [
      "^[a-z][a-z0-9]*(?:-[a-z0-9]+)*(?:(?:__|--)[a-z0-9]+(?:-[a-z0-9]+)*)*$",
      {
        message: "Use classes em kebab-case com elementos e modificadores BEM.",
      },
    ],
  },
};

export default config;
