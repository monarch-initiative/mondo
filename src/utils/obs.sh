#/bin/sh
owltools --use-catalog mondo-edit.obo  --obsolete-replace $@ -o -f obo OBS.tmp && obo-grep.pl --neg -r 'id: (UBERON|CL|ENVO|NCBITaxon|PATO):' OBS.tmp | grep -v ^owl-axioms > OBS
