import { GOVERNANCE_LIVE, governance } from "./governance";

export interface NavItem {
  label: string;
  href?: string;
  children?: { label: string; href: string; blurb?: string }[];
}

export const nav: NavItem[] = [
  { label: "Home", href: "/" },
  {
    label: "About",
    children: [
      { label: "Sources", href: "/pages/sources/", blurb: "Resources Mondo integrates and aligns with" },
      { label: "Who Uses Mondo", href: "/pages/users/", blurb: "Organizations building on Mondo" },
      // Hidden until the governance site is published (see src/lib/governance.ts).
      ...(GOVERNANCE_LIVE
        ? [{ label: "Governance and Operations", href: governance.home, blurb: "How Mondo is run, and how decisions are made (external site)" }]
        : []),
    ],
  },
  { label: "Downloads", href: "/pages/download/" },
  { label: "Rare Diseases", href: "/pages/rare-disease/" },
  {
    label: "Community",
    children: [
      { label: "Community Calls", href: "/pages/community-calls/", blurb: "Monthly community use-case talks" },
      { label: "Workshops", href: "/pages/workshop/", blurb: "Expert workshops, reports and recordings" },
      { label: "Contribute", href: "/pages/contributors/", blurb: "Ways to get involved, and thanks to our contributors" },
    ],
  },
  {
    label: "Publications & Talks",
    children: [
      { label: "Publications", href: "/pages/publications/", blurb: "Papers, blogs and how to cite Mondo" },
      { label: "Presentations", href: "/pages/presentations/", blurb: "Talks, keynotes and posters" },
    ],
  },
];

// Footer columns mirror the top navigation: one column for the top-level pages,
// then one column per dropdown.
const topLevel = nav.filter((i) => i.href).map((i) => ({ label: i.label, href: i.href! }));
const groups = nav
  .filter((i) => i.children)
  .map((i) => ({ heading: i.label, links: i.children!.map(({ label, href }) => ({ label, href })) }));

export const footerLinks = [{ heading: "Mondo", links: topLevel }, ...groups];
