# Repair obsoleted classes 

## Repair axioms pointing to deprecated classes with their replacement class using Robot

Generic instructions for ROBOT repair are [here](http://robot.obolibrary.org/repair).

If an equivalent axiom uses a class that has been obsoleted, this workflow allows you to update the obsoleted class with the replacement class (indicated using the [term replaced by](http://purl.obolibrary.org/obo/IAO_0100001). 

This situation can arise in a number of different ways, such as:

 1. When you are editing an ontology in Protege, you obsolete a class, but forget to repair axioms that reference this.
 2. When you regenerate an import file and the import file has obsoleted classes that are used in logical definitions for Mondo terms.

- For more on obsoletion workflows, see the [obsoletion guide](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/).

3. To repair the Mondo ontology (with the name `mondo-edit.obo`) run the following command:

`robot repair -i mondo-edit.obo -o mondo-edit-repaired.obo`

4. **Diff:** You can compare this with the original file by running this command:
`diff -u mondo-edit.obo mondo-edit-repaired.obo`

- For help understanding the diff output, see this [stack exchange article](https://unix.stackexchange.com/questions/81998/understanding-of-diff-output).

5. If the changes that were made look good then you can simply replace the source file with the repaired file using this command:
`mv mondo-edit-repaired.obo mondo-edit.obo`

6. By default, annotation axioms are not migrated to replacement classes. However, this can be enabled for a list of annotation properties passed either as arguments to `--annotation-property`. The make file will be enhanced in the future to include all of these commands. For now, here are the commands to use on the command line.

`robot repair \
  --input mondo-edit.obo \
  --annotation-property oboInOwl:hasDbXref \
  --output mondo-edit-repaired.obo`
  
`robot repair \
  --input mondo-edit.obo \
  --annotation-property oboInOwl:hasExactSynonym \
  --output mondo-edit-repaired.obo`

`robot repair \
  --input mondo-edit.obo \
  --annotation-property oboInOwl:hasNarrowSynonym \
  --output mondo-edit-repaired.obo`

`robot repair \
  --input mondo-edit.obo \
  --annotation-property oboInOwl:hasBroadSynonym \
  --output mondo-edit-repaired.obo`
  
`robot repair \
  --input mondo-edit.obo \
  --annotation-property oboInOwl:hasRelatedSynonym \
  --output mondo-edit-repaired.obo`  
  
`robot repair \
  --input mondo-edit.obo \
  --annotation-property rdfs:seeAlso \
  --output mondo-edit-repaired.obo`  
  
`robot repair \
  --input mondo-edit.obo \
  --annotation-property oboInOwl:inSubset \
  --output mondo-edit-repaired.obo`    
  
[Robot documentation on prefixes](http://robot.obolibrary.org/global#prefixes)  
[Default/built in Robot prefixes](https://github.com/ontodev/robot/blob/master/robot-core/src/main/resources/obo_context.jsonld) 

