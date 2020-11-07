These notes are for the EDITORS of mondo

**PLEASE READ THE DOCUMENTATION HERE**

https://docs.google.com/document/d/19bp9MpCHCxbjMmbntB2e5gZNzzNlu06DnDB8xcoSXK8/edit#

The rest of this document describes generic ontology editing guidelines

## Editors Version

Make sure you have an ID range in the [idranges file](mondo-idranges.owl)

If you do not have one, get one from the head curator.

The editors version is [mondo-edit.obo](mondo-edit.obo)

** DO NOT EDIT mondo.obo OR mondo.owl in the top level directory **

[../../mondo.owl](../../mondo.owl) is the release version

To edit, open the file in Protege. First make sure you have the repository cloned, see [the GitHub project](https://github.com/monarch-initiative/mondo) for details.

## ID Ranges

These are stored in the file

 * [mondo-idranges.owl](mondo-idranges.owl)

** ONLY USE IDs WITHIN YOUR RANGE!! **

If you have only just set up this repository, modify the idranges file
and add yourself or other editors. Note Protege does not read the file
- it is up to you to ensure correct Protege configuration.


### Setting ID ranges in Protege

We aim to put this up on the technical docs for OBO on http://obofoundry.org/

For now, consult the [GO Tutorial on configuring Protege](http://go-protege-tutorial.readthedocs.io/en/latest/Entities.html#new-entities)


## Release Manager notes

You should only attempt to make a release AFTER the edit version is
committed and pushed, and the travis build passes.

to release:

    cd src/ontology
    make

If this looks good type:

    make prepare_release

This generates derived files such as mondo.owl and mondo.obo and places
them in the top level (../..). The versionIRI will be added.

Commit and push these files.

    git commit -a

And type a brief description of the release in the editor window

Finally type

    git push origin master

IMMEDIATELY AFTERWARDS (do *not* make further modifications) go here:

 * https://github.com/monarch-initiative/mondo/releases
 * https://github.com/monarch-initiative/mondo/releases/new

The value of the "Tag version" field MUST be

    vYYYY-MM-DD

The initial lowercase "v" is REQUIRED. The YYYY-MM-DD *must* match
what is in the versionIRI of the derived mondo.owl (data-version in
mondo.obo).

Release title should be YYYY-MM-DD, optionally followed by a title (e.g. "january release")

Then click "publish release"

__IMPORTANT__: NO MORE THAN ONE RELEASE PER DAY.

The PURLs are already configured to pull from github. This means that
BOTH ontology purls and versioned ontology purls will resolve to the
correct ontologies. Try it!

 * http://purl.obolibrary.org/obo/mondo.owl <-- current ontology PURL
 * http://purl.obolibrary.org/obo/mondo/releases/YYYY-MM-DD.owl <-- change to the release you just made

For questions on this contact Chris Mungall or email obo-admin AT obofoundry.org

# Travis Continuous Integration System

Check the build status here: [![Build Status](https://travis-ci.org/monarch-initiative/mondo.svg?branch=master)](https://travis-ci.org/monarch-initiative/mondo)

Note: if you have only just created this project you will need to authorize travis for this repo. Go to [https://travis-ci.org/profile/monarch-initiative](https://travis-ci.org/profile/monarch-initiative) for details

# Mondo QC report and metrics

Mondo QC is split into two conceptual parts:

1. Violations
2. Warnings

Violations _have to be fixed_ and are executed every time a pull request is created. They are implemented as sparql queries with a postfix "violation", like `no-label-violation.sparql`. To create a new violation, we create a new SPARQL SELECT query that queries for the violation, and name it including the `-violation` postfix. The violation query is executed using ROBOT verify, which will make the CI (Travis/Jenkins) pipeline fail if the query has more than `0` results.

_Warnings_ do not have to be fixed, but are indications of something going wrong. Warnings are implemented in the same way as `violation` queries with a SPARQL Select query, named with a postfix (example: `single-child-warning.sparql`).

Warnings generate a report in the `src/ontology/reports/` directory, with that name scheme:
`src/ontology/reports/ontologyname.owl-sparql-check-name.tsv`, for example: `src/ontology/reports/mondo.owl-single-child-warning.tsv`. The same logic is used for ROBOT reports. 

There now is a jupyter notebook (`src/ontology/reports/mondo_analysis.ipynb`) that automatically reads all files following the above naming schemes (and some more) and generating overviews. The notebook can be edited using:

```
sh run.sh make run_notebook
```

But usually, the only thing you would want to do is generating a markdown overview like so:

```
sh run.sh make reports/mondo_analysis.md
```

# Mondo tagging system

All tags are embedded into `components/mondo-tags.owl`. The way it works:

1. All DOSDP matches are tagged with their corresponding pattern(s), using `dc:conformsTo`.
2. All SPARQL queries with `-tags.sparql` in the name are expected to be CONSTRUCT queries (example: `src/sparql/single-child-tags.sparql`). They will match a pattern, and set a tag using `dc:conformsTo`.
