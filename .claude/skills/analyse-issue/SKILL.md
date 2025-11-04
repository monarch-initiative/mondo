---
name: analyse-issue
description: Analyze MONDO GitHub issues for validity, suggest improvements, and generate structured
  reports with duplication checks and identifier validation
---

# Analyze a GitHub issue for validity

## Instructions

When handling GitHub issues:

1. **View the issue**: Use `gh issue view [number]` to read the issue
2. **Analyze validity**: Assess if the request is medically and terminologically valid (this is NOT always the case, so please be careful)
  - Try to understand the specific design pattern a disease belongs to. Do that by looking at similar classes, and by carefully considering the yaml files in src/patterns/dosdp-patterns/, which define design patterns.
  - If a suitable pattern exists, but you think its underspecified, you may suggest improvements to the pattern (as part of your final report, read on)
  - If no suitable pattern exists, you should propose one, at least in a rough outline, as part of the final report (read on)
3. **Search for improvements**: Look, for example, for more specific parents/terms that might be better
   - As usual, use obo-grepl.obo for the search
   - If any of the diseases analysed as part of this issue belongs to a design pattern (as determined above) but lacks a logical definition and human readable definition, you may propose one as part of the issue
4. **Present findings** in the following format (see below). Write them to a file @src/ontology/tmp/issue_x_analysis.md, where "x" should be the issue number.
5. **Post comment**. ALWAYS ASK FOR PERMISSION TO DO THIS. Offer to post the the file created as a comment to the issue being analysed (using gh). ALWAYS ASK FOR PERMISSION TO DO THIS.

### Model information

Include at the top of your report:

```
⚠️ **WARNING: This report is AI-generated**
**Model:** [Retrieve programmatically - check environment context or system information]
**Generated:** [Use date command to get current timestamp in UTC]
```

**IMPORTANT:**
- NEVER write the model name from memory or training data
- Look for the model information in the system environment or context provided at the start of the conversation
- If the exact model ID is provided in your system context (e.g., "claude-sonnet-4-5-20250929"), use that
- If unavailable, state "Model information unavailable"
- Always generate the timestamp programmatically using `date -u +"%Y-%m-%d %H:%M:%S UTC"` or similar
- Always check if an example you give is valid by using obo-grepl.obo. Be very very careful not to hallucinate subclass (is_a) relations.

### ✅ Why the user request is valid:

- Mermaid diagram that describes SPECIFICALLY THE USER REQUESTED change.
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

