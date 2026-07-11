// @ts-check
// The Modern Docker Workshop sidebar is generated from the upstream mkdocs nav
// by scripts/port-workshop.mjs and written to sidebars.workshop.json.
import workshopSidebar from './sidebars.workshop.json' with {type: 'json'};

/**
 * Only the Modern Docker Workshop is surfaced in the UI.
 *
 * The ~600 legacy labs still live under docs/ (so their original URLs stay
 * reachable and remain in the sitemap for SEO) but are intentionally NOT placed
 * in any sidebar — they are "published but unlinked from the UI". We do NOT use
 * `unlisted: true` for them, because that would add a `noindex` tag and defeat
 * the whole point of preserving their search ranking.
 *
 * @type {import('@docusaurus/plugin-content-docs').SidebarsConfig}
 */
const sidebars = {
  workshopSidebar: workshopSidebar,
};

export default sidebars;
