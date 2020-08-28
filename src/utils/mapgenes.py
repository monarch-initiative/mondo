import mygene
import csv
syms = []
with open('geneset.txt', newline='') as csvfile:
     spamreader = csv.reader(csvfile, delimiter='\t', quotechar='|')
     for row in spamreader:
         syms.append(row[0])

mg = mygene.MyGeneInfo()
#xli = ['DDX26B','CCDC83', 'MAST3', 'RPL11', 'ZDHHC20', 'LUC7L3', 'SNORD49A', 'CTSH', 'ACOT8']
#xli = ['CCDC83', 'MAST3', 'RPL11']
rows = mg.querymany(syms, species=10090, scopes="symbol", fields=["ensembl.gene"], returnall=True)['out']
for r in rows:
    print(r['ensembl']['gene'])

