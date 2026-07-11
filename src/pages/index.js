import clsx from 'clsx';
import Link from '@docusaurus/Link';
import Layout from '@theme/Layout';
import styles from './index.module.css';

const HIGHLIGHTS = [
  {
    emoji: '🐳',
    title: 'Docker 101 & Inner Loop',
    text: 'Containers, docker init, Compose Watch and a real Product Catalog app you develop, test, build and secure.',
    to: '/docker-workshop/lab1/overview',
  },
  {
    emoji: '🤖',
    title: 'Docker & AI Agents',
    text: 'Build agents with the Docker Agent, Model Runner, MCP Catalog, Agentic Compose and multi-agent systems.',
    to: '/docker-workshop/lab10/overview',
  },
  {
    emoji: '🛡️',
    title: 'Sandboxes & AI Governance',
    text: 'Run untrusted agents safely — isolation, network & filesystem policy, secrets, and governance at scale.',
    to: '/docker-workshop/lab8/overview',
  },
  {
    emoji: '🔒',
    title: 'Supply Chain Security',
    text: 'Harden containers, scan with Docker Scout, and adopt Docker Hardened Images with dhictl.',
    to: '/docker-workshop/security/container-security/overview',
  },
  {
    emoji: '☁️',
    title: 'Docker Offload',
    text: 'Offload builds and heavy workloads to the cloud straight from your local Docker workflow.',
    to: '/docker-workshop/lab7/overview',
  },
  {
    emoji: '☸️',
    title: 'Kubernetes 101',
    text: 'Pods, Deployments, Services, Ingress, scaling, and Compose Bridge from Compose to Kubernetes.',
    to: '/docker-workshop/kubernetes-101/overview',
  },
];

function Hero() {
  return (
    <header className={styles.hero}>
      <div className="container">
        <h1 className={styles.heroTitle}>DockerLabs</h1>
        <p className={styles.heroSubtitle}>
          A $0 learning platform for all levels — from your first container to
          building AI agents, securing the supply chain, and running on Kubernetes.
        </p>
        <div className={styles.stats}>
          <div className={styles.stat}>
            <div className={styles.statNumber}>500+</div>
            <div className={styles.statLabel}>Hands-on Labs</div>
          </div>
          <div className={styles.stat}>
            <div className={styles.statNumber}>10,000+</div>
            <div className={styles.statLabel}>Community Members</div>
          </div>
          <div className={styles.stat}>
            <div className={styles.statNumber}>$0</div>
            <div className={styles.statLabel}>Forever Free</div>
          </div>
        </div>
        <div className={styles.buttons}>
          <Link className="button button--lg button--secondary" to="/docker-workshop">
            🚀 Start the Modern Workshop
          </Link>
          <Link className="button button--lg button--outline button--secondary" to="/docker-workshop/lab10/overview">
            Build AI Agents with Docker
          </Link>
        </div>
      </div>
    </header>
  );
}

function CardGrid({items}) {
  return (
    <div className="row">
      {items.map((item) => (
        <div key={item.title} className="col col--4">
          <Link className={styles.card} to={item.to}>
            <div className={styles.cardEmoji}>{item.emoji}</div>
            <div className={styles.cardTitle}>{item.title}</div>
            <p className={styles.cardText}>{item.text}</p>
          </Link>
        </div>
      ))}
    </div>
  );
}

export default function Home() {
  return (
    <Layout
      title="DockerLabs — 500+ hands-on Docker & Kubernetes labs"
      description="A $0 learning platform with 500+ hands-on Docker and Kubernetes labs — from your first container to AI agents, security, and Kubernetes. Runs on Docker Desktop and Docker Engine.">
      <Hero />
      <main>
        <section className={styles.section}>
          <div className="container">
            <h2 className={styles.sectionTitle}>🚀 The Modern Docker Workshop</h2>
            <p className={styles.sectionSubtitle}>
              Brand-new, fully tested content for today's Docker — runs on Docker
              Desktop and Docker Engine. No external playground required.
            </p>
            <CardGrid items={HIGHLIGHTS} />
          </div>
        </section>

        <section className={clsx(styles.section, styles.altSection)}>
          <div className="container" style={{textAlign: 'center', maxWidth: 720}}>
            <h2 className={styles.sectionTitle}>Runs on your machine — no playground required</h2>
            <p className={styles.sectionSubtitle}>
              Every lab is tested on Docker Desktop and Docker Engine. Clone,
              run, and learn on your own environment.
            </p>
            <Link className="button button--lg button--primary" to="/docker-workshop/prereq">
              Check the Prerequisites →
            </Link>
          </div>
        </section>
      </main>
    </Layout>
  );
}
