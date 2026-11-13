// Links to the Mondo Governance and Operations site (monarch-initiative/mondo-operations).
// Set GOVERNANCE_LIVE to true once that site is published; every governance link on this site
// (Contribute page sections, the About menu item and the Downloads documentation link) appears automatically.
export const GOVERNANCE_LIVE = false;
export const GOVERNANCE_URL = "https://monarch-initiative.github.io/mondo-operations/";

const g = (path: string) => GOVERNANCE_URL + path;

export const governance = {
  home: g(""),
  roles: g("index.html#project-structure-and-roles"),
  contributing: g("contributing/index.html"),
  codeOfConduct: g("community-guidelines/code-of-conduct/index.html"),
  routes: [
    { label: "Requests and GitHub Discussions", href: g("contributing/ontology-and-project-code.html"), blurb: "Request changes or new terms, report errors and join discussions on GitHub issues." },
    { label: "Workshops and Community Meetings", href: g("contributing/workshops-and-community.html"), blurb: "Take part in workshops and community calls." },
    { label: "Code and Ontology Editing", href: g("contributing/code-and-ontology-editing.html"), blurb: "Contribute ontology changes, bug fixes and feature improvements." },
    { label: "Consulting Domain Experts", href: g("contributing/domain-experts.html"), blurb: "Advise the ontology editors by sharing disease knowledge." },
    { label: "Curation Assistants", href: g("contributing/curation-assistants.html"), blurb: "Support the editor team by reviewing requests and suggesting next steps." },
    { label: "Externally Managed Content Maintainers", href: g("contributing/emc-maintainers.html"), blurb: "Maintain information imported directly into Mondo, and act as its point of contact." },
  ],
};
