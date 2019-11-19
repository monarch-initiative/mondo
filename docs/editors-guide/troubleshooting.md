## Troubleshooting

This page is for documenting issues we have encountered and some solutions on how to fix them.

**Ontop OBDA Protege plugin**
 
If you install the Ontop OBDA Protége plugin, it will cause problems with our ontologies (we were getting super big diffs, and it turned out the first line of the ontology was being changed). The fix was to go back into our preferences in Protégé/New Entities tab and fix the Specified IRI.

See the GitHub issue [here](https://github.com/protegeproject/protege/issues/926) that reports the problem and shows the fix.
 
