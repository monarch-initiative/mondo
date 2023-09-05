# Mondo ingest updates

## Bulk update deprecated external classes

In order to accurately reflect an external concept is obsoleted, we have a 
pipeline in the Mondo makefile pipeline that allows us to read the deprecation 
status from Mondo ingest system and update all the mappings in mondo-edit.obo.

To run this pipeline, run:

```
sh run.sh make update_deprecated_mappings -B
```

This will rewrite all of the Mondo:equivalentTo tags to Mondo:equivalentObsolete.
Know that there may be some fringe cases that need to be fixed manually but QC
will inform you about them.