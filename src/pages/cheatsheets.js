import Layout from '@theme/Layout';
import Link from '@docusaurus/Link';
import styles from './index.module.css';

const BASE = 'https://collabnix.com';

// Sourced from https://collabnix.com/cheatsheets/
const CATEGORIES = [
  {
    name: 'Core',
    items: [
      {title: 'Docker CLI', desc: 'The core docker command for managing containers, images, and the local engine.', to: '/cheatsheets/docker-cli-cheatsheet/'},
      {title: 'Docker Compose', desc: 'Define and run multi-container applications with a single compose.yaml.', to: '/cheatsheets/docker-compose-cheatsheet/'},
      {title: 'Docker Volumes', desc: 'Manage persistent data storage with named volumes and bind mounts.', to: '/cheatsheets/docker-volumes-cheatsheet-2/'},
      {title: 'Docker Networking', desc: 'Connect containers with bridge, overlay, and host networks; manage ports and DNS.', to: '/cheatsheets/docker-networking-cheatsheet-2/'},
    ],
  },
  {
    name: 'Build',
    items: [
      {title: 'Dockerfile Reference', desc: 'Complete guide to Dockerfile instructions: FROM, RUN, COPY, ARG, ENV, and more.', to: '/cheatsheets/dockerfile-reference-cheatsheet/'},
      {title: 'Docker Buildx', desc: 'Next-gen image builder powered by BuildKit — multi-platform, bake, and history.', to: '/cheatsheets/docker-buildx-cheatsheet/'},
      {title: 'Docker Bake', desc: 'Define complex multi-target build pipelines with HCL or JSON bake files and matrices.', to: '/cheatsheets/docker-bake-cheatsheet/'},
    ],
  },
  {
    name: 'AI',
    items: [
      {title: 'Docker Model Runner', desc: 'Pull and run open-source LLMs locally with an OpenAI-compatible endpoint.', to: '/cheatsheets/docker-model-runner-cheatsheet/'},
      {title: 'Docker MCP Toolkit', desc: 'Discover, install, and manage Model Context Protocol servers from the catalog.', to: '/cheatsheets/docker-mcp-toolkit-cheatsheet/'},
      {title: 'Docker MCP Gateway', desc: 'Run a single MCP endpoint that fronts many containerized MCP servers.', to: '/cheatsheets/docker-mcp-gateway-cheatsheet/'},
      {title: 'Docker Sandboxes (sbx)', desc: 'Ephemeral, isolated sandboxes built for running AI agents securely.', to: '/cheatsheets/docker-sbx-cheatsheet/'},
      {title: 'Docker AI Tools', desc: "Use Docker's AI assistant Gordon and Compose Watch for smart workflows.", to: '/cheatsheets/docker-ai-tools-cheatsheet/'},
    ],
  },
  {
    name: 'Security',
    items: [
      {title: 'Docker Scout', desc: 'Analyze images for CVEs, generate SBOMs, and enforce supply-chain policy.', to: '/cheatsheets/docker-scout-cheatsheet/'},
      {title: 'Docker Content Trust', desc: 'Sign and verify images with Notary to enforce integrity across your supply chain.', to: '/cheatsheets/docker-content-trust-cheatsheet-2/'},
      {title: 'Docker Secrets', desc: 'Securely manage passwords and tokens in Docker Swarm and Compose.', to: '/cheatsheets/docker-secrets-cheatsheet/'},
    ],
  },
  {
    name: 'Desktop & Registry',
    items: [
      {title: 'Docker Desktop', desc: 'All-in-one Docker for Mac, Windows, and Linux with GUI, extensions, and Dev Environments.', to: '/cheatsheets/docker-desktop-cheatsheet-2/'},
      {title: 'Dev Environments', desc: 'Share consistent, containerized dev workspaces with one click from Docker Desktop.', to: '/cheatsheets/dev-environments-cheatsheet/'},
      {title: 'Docker Hub', desc: "The world's largest container registry for searching, pulling, and publishing images.", to: '/cheatsheets/docker-hub-cheatsheet-2/'},
      {title: 'Docker Registry', desc: 'Run your own OCI-compliant registry with authentication, TLS, and garbage collection.', to: '/cheatsheets/docker-registry-cheatsheet/'},
    ],
  },
  {
    name: 'Troubleshooting',
    items: [
      {title: 'Docker Troubleshooting', desc: 'Debug containers, inspect logs, trace networking issues, and fix common problems.', to: '/cheatsheets/docker-troubleshooting-cheatsheet-2/'},
    ],
  },
];

export default function Cheatsheets() {
  return (
    <Layout
      title="Docker Cheatsheets"
      description="A curated directory of Docker cheatsheets — CLI, Compose, Buildx, Scout, Model Runner, MCP, security, and more. Quick references for every Docker workflow.">
      <header className={styles.hero} style={{padding: '3.5rem 0 3rem'}}>
        <div className="container">
          <h1 className={styles.heroTitle} style={{fontSize: '2.6rem'}}>Docker Cheatsheets</h1>
          <p className={styles.heroSubtitle}>
            Quick references for every Docker workflow — from the CLI and Compose
            to Buildx, Scout, Model Runner, and MCP.
          </p>
        </div>
      </header>
      <main className="container" style={{padding: '3rem 1rem'}}>
        {CATEGORIES.map((cat) => (
          <section key={cat.name} style={{marginBottom: '2.5rem'}}>
            <h2 style={{fontWeight: 800, marginBottom: '1.25rem'}}>{cat.name}</h2>
            <div className="row">
              {cat.items.map((it) => (
                <div key={it.title} className="col col--4">
                  <Link className={styles.card} to={`${BASE}${it.to}`}>
                    <div className={styles.cardTitle}>📄 {it.title}</div>
                    <p className={styles.cardText}>{it.desc}</p>
                  </Link>
                </div>
              ))}
            </div>
          </section>
        ))}
        <p style={{textAlign: 'center', color: 'var(--ifm-color-emphasis-600)'}}>
          All cheatsheets are maintained on{' '}
          <Link to={`${BASE}/cheatsheets/`}>collabnix.com/cheatsheets</Link>.
        </p>
      </main>
    </Layout>
  );
}
