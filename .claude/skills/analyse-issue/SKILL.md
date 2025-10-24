---
name: analyse-issue
description: Analyze MONDO GitHub issues for validity, suggest improvements, and generate structured
  reports with duplication checks and identifier validation
---

# Analyze a GitHub issue for validity

## Instructions

When handling GitHub issues:

1. **View the issue**: Use `gh issue view [number]` to read the issue
2. **Analyze validity**: Assess if the request is medically and terminologically valid
3. **Search for improvements**: Look, for example, for more specific parents/terms that might be better
4. **Present findings** in the following format. Print the findings on the terminal, but also write them to a file @src/ontology/tmp/issue_x_analysis.md, where "x" should be the issue number:Collapse commentComment on line R433matentzn commented on Sep 4, 2025 matentznon Sep 4, 2025MemberAuthorMore actionsSee here for an example.ReactWrite a replyResolve commentCode has comments. Press enter to view.

### Model information

- Write a clearly visible warning that the report is AI generated
- Write which model you are using for generating the report

### ✅ Why the user request is valid:

- Mermaid diagram that describes SPECIFICALLY THE USER REQUESTED changeExpand commentComment on line R442ResolvedCode has comments. Press enter to view.
  - Use bottom UP (BT) for arrow direction
  - Use `-.->|PROPOSED<br/>NEW PARENT|` for proposed new parents and `-.->|PROPOSED<br/>REMOVED PARENT|` for proposed removed parents
  - Example:

    ```mermaid
    graph BT
        B[MONDO:0005341 skin basal cell carcinoma] -->  A[MONDO:0004993 carcinoma]
        C[MONDO:0019317 follicular atrophoderma-basal cell carcinoma] -.->|PROPOSED<br/>NEW PARENT| B
        C --> D[MONDO:0010535 Bazex-Dupre-Christol syndrome]
        
        style C fill:#ccffcc
        style A fill:#ccffcc
        style B fill:#ccffcc
    ```

- Medical/clinical justification, ideally with pubmed evidence
- Terminological correctness  
- Ontological gaps being addressed

### 💡 Suggested improvements:

- Section to describe changes / refinements over what the user is suggesting
- Mermaid diagram that describes the change (ONLY include this if there are actual changes being suggested!)
- More specific parent/classification if applicable, ideally with pubmed evidence
- Additional relationships that should be considered
- Supporting literature/references

Example: For classification requests, always check if there's a more specific parent term (e.g., "benign vascular tumor" instead of general "cancer or benign tumor").

### High level action items

- Example: Add X as subclass to Y.

### General formatting instructions on the report

- The title in the issue report should just be "Issue analysis"
- Do not include an "implementation plan" in the report
- If there are no suggested improvements over the user request

