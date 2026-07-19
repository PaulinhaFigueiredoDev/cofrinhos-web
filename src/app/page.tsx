import styles from "./page.module.css";

export default function Home() {
  return (
    <main className={styles.inicio}>
      <section className={styles.inicio__conteudo} aria-labelledby="titulo">
        <p className={styles.inicio__etapa}>Fundação do projeto</p>
        <h1 id="titulo" className={styles.inicio__titulo}>
          Cofrinhos Web
        </h1>
        <p className={styles.inicio__descricao}>
          A interface do Hub e do detalhe dos cofrinhos será construída nas
          próximas etapas.
        </p>
      </section>
    </main>
  );
}
