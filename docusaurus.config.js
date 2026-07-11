// @ts-check
import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'DockerLabs',
  tagline: 'A $0 learning platform — 500+ hands-on Docker & Kubernetes labs',
  favicon: 'img/favicon.svg',

  url: 'https://dockerlabs.collabnix.com',
  baseUrl: '/',

  organizationName: 'collabnix',
  projectName: 'dockerlabs',
  trailingSlash: false,

  // Legacy content has thousands of cross-links; don't fail the build on them.
  onBrokenLinks: 'warn',
  onBrokenAnchors: 'warn',
  onBrokenMarkdownLinks: 'warn',

  markdown: {
    mermaid: true,
    // `.md` -> CommonMark (safe for legacy files full of <, {, unescaped chars)
    // `.mdx` -> MDX/JSX. Admonitions & Mermaid still work in both.
    format: 'detect',
  },
  themes: ['@docusaurus/theme-mermaid'],

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          path: 'docs',
          routeBasePath: '/',
          sidebarPath: './sidebars.js',
          editUrl: 'https://github.com/collabnix/dockerlabs/edit/master/',
          showLastUpdateTime: true,
          // Don't turn committed dependencies / vendored files into lab pages.
          exclude: [
            '**/node_modules/**',
            '**/vendor/**',
            '**/_*.{js,jsx,ts,tsx,md,mdx}',
            '**/_*/**',
            '**/*.test.{js,jsx,ts,tsx}',
            '**/__tests__/**',
          ],
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
        sitemap: {
          changefreq: 'weekly',
          priority: 0.5,
          ignorePatterns: ['/tags/**'],
          filename: 'sitemap.xml',
        },
        // Add Google Analytics by setting a real ID here, e.g.:
        // gtag: { trackingID: 'G-XXXXXXXXXX', anonymizeIP: true },
      }),
    ],
  ],

  // NOTE on SEO: with `trailingSlash: false`, Docusaurus emits each page as
  // `beginners/ADD-command.html` — byte-for-byte the same URL the old Jekyll
  // site used. So the legacy `.html` URLs keep working natively and no redirect
  // plugin is needed. The clean `/beginners/ADD-command` form also resolves via
  // GitHub Pages' `.html` fallback and is set as the canonical URL.

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: {
        defaultMode: 'light',
        respectPrefersColorScheme: true,
      },
      docs: {
        sidebar: {
          hideable: true,
          autoCollapseCategories: true,
        },
      },
      navbar: {
        title: 'DockerLabs',
        logo: {
          alt: 'DockerLabs by Collabnix',
          src: 'images/moby_large.png',
          height: 32,
        },
        items: [
          {
            to: '/cheatsheets',
            label: 'Cheatsheets',
            position: 'left',
          },
          {
            href: 'https://collabnix.com',
            label: 'Collabnix',
            position: 'right',
          },
          {
            href: 'https://github.com/collabnix/dockerlabs',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Learn',
            items: [
              {label: 'Modern Docker Workshop', to: '/docker-workshop'},
              {label: 'Docker & AI Agents', to: '/docker-workshop/lab10/overview'},
              {label: 'Kubernetes 101', to: '/docker-workshop/kubernetes-101/overview'},
            ],
          },
          {
            title: 'Community',
            items: [
              {label: 'Slack (10,000+)', href: 'https://launchpass.com/collabnix'},
              {label: 'Discord', href: 'https://discord.gg/QEkCXAXYSe'},
              {label: 'Twitter / X', href: 'https://twitter.com/collabnix'},
            ],
          },
          {
            title: 'More',
            items: [
              {label: 'Collabnix Blog', href: 'https://collabnix.com'},
              {label: 'Docker Cheatsheet', href: 'https://collabnix.com/docker-cheatsheet/'},
              {label: 'GitHub', href: 'https://github.com/collabnix/dockerlabs'},
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Collabnix Community · DockerLabs. Built with Docusaurus.`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
        additionalLanguages: ['bash', 'docker', 'yaml', 'json', 'go', 'python', 'nginx'],
      },
    }),
};

export default config;
