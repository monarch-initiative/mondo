# Changelog

This has now moved to a file in the top of the github repo
[https://github.com/monarch-initiative/mondo/blob/master/Changes.md](https://github.com/monarch-initiative/mondo/blob/master/Changes.md) 

## 2017-09-20

Chris visits EBI and discusses plan with Simon, Sira. GitHub repo created for sharing disease yaml DPs.

Experiment with kboom runs including EFO

## 2017-09-24

Initial version of mondo created by running kboom using as input:

* Efo-disease
* Omim, diseases
* Orphanet/ORDO, after initial pre-processing
* DC

Note NCIT was explicitly excluded as it complicates the results due to large differences in how EFO/DO deal with cancer vs NCIT (see later). We also removed MESH due to low quality (but of course we retain xrefs to MESH, we simply did not input its structure into kboom)

and merging the results, the following parameters used:

```
PRIORITIES_ID := -s OMIM 10 -s EFO 8 -s DOID 6 -s Orphanet 7 -s MESH 4
PRIORITIES_LABEL :=  -l DOID 10 -l EFO 11 -l NCIT 8 -l Orphanet 5  -l OMIM 3 -l MESH 1
PRIORITIES_DEF := -d Orphanet 10 -d NCIT 8 -l EFO 11 -d DOID 5  -d MESH 3 -d OMIM 1
```

The resulting ontology had new IDs minted. The clique leader was retained with a MONDO:Leader annotation. The kboom xref interpretations also retained as annotations.

We were conservative with automatic merging. Post kboom we used ontobio to determine classes that were likely candidates for merging. These were then manually merged, and any reasoner errors investigated.

Many of these were cancer-related. A common pattern was DO or EFO classifying “X cancer” under “Y carcinoma” (where X isa/part of Y). This is common because the typical form of many cancers is a carcinoma, but this causes issues if “X cancer” has sarcomas as children. These were resolved by assuming “X cancer” can be generic, unless it is to a very specific tissue type that is entirely epithelial for example.

Note we will likely return to cancers later and swap in NCIT. It is too hard to do this as an initial step.

I also merged in a lot of the historic DCs. These were originally used for grouping OMIMs. Many were previously merged into DO/EFO/Orphanet. However, some were retained. These were manually merged based on obvious lexical and graph properties. Some remain.


## 2017-10-02

Merging of multiple equivalent classes

## 2017-10-18

First release using new pipeline. kboom was used to combine orphanet,
efo, omim and doid. Note ncit is slated for future incorporation.

The resulting ontology was merged using most probably equivalence
axioms. MONDO IDs assigned as clique leaders. Source xrefs were
retained, but these xrefs were annotated with kboom interpretations
(see editors guide for details).

The kboom report was used to examine dubious merge groupings, these
were then manually addressed. Some issues were filed on the old
tracker: [https://github.com/monarch-initiative/monarch-disease-ontology/issues](https://github.com/monarch-initiative/monarch-disease-ontology/issues)

Additional axiomatization was added for straightforward high level
grouping classes.

For the release, we map back to original clique leaders. We also make
a 'pre' release consisting of classes with MONDO IDs as primary. See
obo page for more details:

[http://obofoundry.org/ontology/mondo.html](http://obofoundry.org/ontology/mondo.html) 


