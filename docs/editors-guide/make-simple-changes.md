# Make changes to Mondo via simple commands

**Description**: Mondo has a workflow that allows for simple changes to be added via commands added to an issue. Users can suggest addition of a synonym, obsoletion of a class, create a new class or rename a class. 

- Open a new issue with the description of the request.
 - In the description, ontobot looks for the phrase `Hey ontobot!, apply: `
 - This phase should be followed by bullets of KGCL (Knowledge Graph Change Language) commands
 - For e.g.:
 
 ```
Hey ontobot! apply:
- create broad synonym 'ABCD' for MONDO:0001234
```

- Commands that are functional as of now:
  - create broad synonym 'ABCD' for MONDO:0001234
  - create exact synonym 'ABCD' for MONDO:0001234
  - create narrow synonym 'ABCD' for MONDO:0001234
  - create related synonym 'ABCD' for MONDO:0001234
  - obsolete MONDO:0001234 with replacement MONDO:0001234
  - create node MONDO:0001234 'label of the class'
  - rename MONDO:0001234 from 'old label' to 'new label'
