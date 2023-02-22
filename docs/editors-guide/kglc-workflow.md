# KGCL workflows

## Add synonym using KGCL

- Open a new issue with the description of the request.
 - In the description, ontobot looks for the phrase `Hey ontobot!, apply: `
 - This phase should be followed by bullets of KGCL (Knowledge Graph Change Language) commands
 - For e.g.:
 
 ```
Hey ontobot! apply:
 - create broad synonym 'ABCD' for CURIE:1234
```

- Commands that are functional as of now:
  - create broad synonym 'ABCD' for CURIE:1234
  - create exact synonym 'ABCD' for CURIE:1234
  - create narrow synonym 'ABCD' for CURIE:1234
  - create related synonym 'ABCD' for CURIE:1234
  - obsolete CURIE:1234 with replacement CURIE:4567
 - create node http://purl.obolibrary.org/obo/ABCD_99999999 'label of the node'
 - rename CURIE:1234 from 'old label' to 'new label'
