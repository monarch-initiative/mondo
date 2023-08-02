# Protege 5.6 setup for Mondo Editors

(This was adopted from the [Gene Ontology editors guide](http://wiki.geneontology.org/index.php/Protege5_5_setup_for_GO_Eds))

## Operating System
These instructions are for Mac OS

## Protege version
As of August 2023, Mondo editors are using `Protege version 5.6.

## Download and install Protege
- Get Protege from [protege.stanford.edu](https://protege.stanford.edu/)
- Unzip and move the Protege app to your Applications folder.
- See [Install_Protege5_Mac](https://protegewiki.stanford.edu/wiki/Install_Protege5_Mac) for more instructions and troubleshooting common problems.

### ELK reasoner

The ELK reasoner is included with Protege 5.6. For instructions on adding the ELK reasoner (if you are using an older version of Protege, see the [Install Elk 0.5 in Protege how to guide](https://oboacademy.github.io/obook/howto/installing-elk-in-protege/).)

## Increase memory in Protege

1. Protege needs at least 4G of RAM to cope with Mondo, ideally use 12G or 16G if your machine can handle it.
1. If running from Protege.app on a mac, open the /Applications/Protege-5.5.0/Protégé.app/Contents/info.plist file
1. Below the line: <string>-Xss16M</string>
1. Insert another line: <string>-Xmx12G</string>
1. Note - if you have issues opening Protege, then reduce the memory, try 10G (or lower) instead.

## Fix memory settings
- Protege needs at least 4G of RAM to cope with Mondo, ideally use 12G or 16G if your machine can handle it.
- If running from Protege.app on a mac, open the /Applications/Protege-5.5.0/Protégé.app/Contents/info.plist file
  - Below the line: `<string>-Xss16M</string>`
  - Insert another line: `<string>-Xmx12G</string>`

_Note - if you have issues opening Protege, then reduce the memory, try 10G (or lower) instead._

## Instructions for new Protege users

### Obtaining your ID range
- Curators and projects are assigned specific Mondo term ID ranges by senior editors.
- These ID ranges are stored in the file: [mondo-idranges.owl](https://github.com/monarch-initiative/mondo/blob/master/src/ontology/mondo-idranges.owl)
- **NOTE:** You should only use IDs within your range.

### Setting ID range
Protégé 5.6 can now automatically set up the ID range for a given user by exploiting the `idranges.owl` file, if it exists. 

This Protege version looks at the ID range file and matches your user name in Protege to the names in the file to automatically set up your ID range. Thus as long as this information matches you no longer need to manually set the ID range. You will get a message if your user name does not match one in the file asking you to pick an ID range.

**Note**: If you are switching from an old Protege version to Protege 5.6, you may need to reset your range to the last used ID rather than just the full range or Protege would try to fill in gaps in the range.

If you are using an older version of Protege, see the [instructions on setting the ID range in OBO Academy](https://oboacademy.github.io/obook/howto/idrange/).)

### Switching ID range

If you edit another ontology besides Mondo, you will need to switch your ID range. Protege (unfortunately) does not remember the last prefix or ID range that you used when you switch between ontologies. Therefore we need to manually update this each time we switch ontologies. See [instructions here](https://oboacademy.github.io/obook/howto/switching-ontologies/).

## User details

1. `User name` Clcik `Use supplied user name:` add your name (ie nicolevasilevsky)
2. Check `Use Git user name when available`
3. Add `ORCID`. Add the ID number only, do not include https://, ie 0000-0001-5208-3432

![UserDetails](images/UserDetails.png)

## Setting username and auto-adding creation date

1. In the Protege menu, go to `Preferences` > `New Entities Metadata` tab
1. Check `Annotate new entities with creator (user)` box
1. In the `Creator property` field, add `http://purl.org/dc/terms/creator`
1. `Creator value` Select Use ORCID
1. `Date property` http://purl.org/dc/elements/1.1/date
1. `Date value format` Select ISO-8601

<img width="883" alt="image" src="https://github.com/monarch-initiative/mondo/assets/6722114/ef1a9b25-c7e6-41fd-a6c6-7335e32b78a9">

