import pandas as pd

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('report_last_release', type=str,
                    help='A TSV file containing the stats for the last release')
parser.add_argument('report_current_release', type=str,
                    help='A TSV file containing the stats for the last release')
parser.add_argument('output', type=str,
                    help='A TSV path for the output of changed terms')
parser.add_argument('output_new', type=str,
                    help='A TSV path for the output of new terms')

args = parser.parse_args()
report_last_release=args.report_last_release
report_current_release=args.report_current_release
output=args.output
output_new=args.output_new

def load_report_data(fn, prefix):
    df = pd.read_csv(fn, sep='\t')
    df.columns = ['mondo_id', 'label', 'definition','obsoletion_candidate','obsolete']
    df['mondo_id']=[i.replace("<http://purl.obolibrary.org/obo/MONDO_","MONDO:").replace(">","") for i in df['mondo_id']]
    df_m = pd.melt(df, id_vars='mondo_id', value_vars=['label', 'definition','obsoletion_candidate','obsolete'])
    df_m.columns = ['mondo_id', 'property',	'value_'+prefix]
    return df_m

def format_new_table(df):
    if 'definition' not in df:
        df['definition'] = ''
    if 'label' not in df:
        df['label'] = ''
    if 'obsolete' not in df:
        df['obsolete'] = ''
    if 'obsoletion_candidate' not in df:
        df['obsoletion_candidate'] = ''
    df.fillna('', inplace=True)
    return df[['mondo_id','label','definition','obsolete','obsoletion_candidate']]

df_report_last_release=load_report_data(report_last_release,'old')
df_report_current_release=load_report_data(report_current_release,'new')

last_ids = df_report_last_release['mondo_id'].unique()
current_ids = df_report_current_release['mondo_id'].unique()
new_terms = [x for x in current_ids if x not in last_ids]

df_obsoleted = df_report_current_release[(df_report_current_release['property']=='obsolete') & (df_report_current_release['value_new'].notnull())][['mondo_id','value_new']].copy()
obsoleted_terms=df_obsoleted['mondo_id'].unique()
df_labels = df_report_current_release[df_report_current_release['property']=='label'][['mondo_id','value_new']].copy()
df_labels.drop_duplicates(inplace=True)
df_labels.columns = ['Mondo ID','Label']

df_report_full= pd.merge(df_report_last_release, df_report_current_release, on=['mondo_id','property'],how='right')
df_report_full.fillna('', inplace=True)
df_report = df_report_full[df_report_full['value_old']!=df_report_full['value_new']].copy()

df_report_new=df_report[df_report['mondo_id'].isin(new_terms)].copy()
del df_report_new['value_old']
df_report_new_wide=df_report_new.pivot(index='mondo_id', columns='property', values='value_new')
df_report_new_wide=pd.DataFrame(df_report_new_wide.to_records())

df_report_new_wide = format_new_table(df_report_new_wide)
df_report_new = df_report_new_wide.copy()

df_report_changed=df_report[~df_report['mondo_id'].isin(new_terms)].copy()

df_report_new.to_csv(output_new, sep="\t",index=False)
df_report_changed.to_csv(output, sep="\t",index=False)

df_changed_labels = df_report_changed[(df_report_changed['property']=='label') & ~(df_report_changed['mondo_id'].isin(obsoleted_terms))]
df_changed_definitions = df_report_changed[(df_report_changed['property']=='definition') & ~(df_report_changed['mondo_id'].isin(obsoleted_terms))]
df_obsolete_terms = df_report_changed[(df_report_changed['property']=='obsolete')]
df_obsolete_candidates = df_report_changed[(df_report_changed['property']=='obsoletion_candidate') & (df_report_changed['value_old']!=True) & ~(df_report_changed['mondo_id'].isin(obsoleted_terms))]
df_old_obsolete_candidates = df_report_changed[(df_report_changed['property']=='obsoletion_candidate') & (df_report_changed['value_old']==True) & ~(df_report_changed['mondo_id'].isin(obsoleted_terms))]


ct_new_terms = len(df_report_new['mondo_id'].unique())
ct_changed_labels = len(df_changed_labels['mondo_id'].unique())
ct_changed_definitions = len(df_changed_definitions['mondo_id'].unique())
ct_obsolete_terms = len(df_obsolete_terms['mondo_id'].unique())
ct_obsolete_candidates = len(df_obsolete_candidates['mondo_id'].unique())
ct_old_obsolete_candidates = len(df_old_obsolete_candidates['mondo_id'].unique())

print("## Overview:")
print("")
print("")
print(f"* Number of new terms: {ct_new_terms}")
print(f"* Number of changed labels: {ct_changed_labels}")
print(f"* Number of changed definitions: {ct_changed_definitions}")
print(f"* Number obsoleted terms: {ct_obsolete_terms}")
print(f"* Number of new obsoletion candidates: {ct_obsolete_candidates}")
print(f"* Number of terms who were previously candidate for obsoletion and are now not anymore: {ct_old_obsolete_candidates}")
print("")
print("")


print("## New terms")
df_report_new.columns = ['Mondo ID', 'Label', 'Definition', 'Obsoletion candidate?', 'Obsolete']

print(df_report_new[['Mondo ID', 'Label', 'Definition']].to_markdown(index=False))

print("")
print("")
print("## Changed terms")
df_changed_labels.columns = ['Mondo ID', 'property', 'Previous release', 'New release']
df_changed_definitions.columns = ['Mondo ID', 'property', 'Previous release', 'New release']
df_obsolete_terms.columns = ['Mondo ID', 'property', 'Previous release', 'New release']
df_obsolete_candidates.columns = ['Mondo ID', 'property', 'Previous release', 'New release']
df_old_obsolete_candidates.columns = ['Mondo ID', 'property', 'Previous release', 'New release']
df_changed_labels = df_changed_labels.merge(df_labels,how="left",on="Mondo ID")
df_changed_definitions = df_changed_definitions.merge(df_labels,how="left",on="Mondo ID")
df_obsolete_terms = df_obsolete_terms.merge(df_labels,how="left",on="Mondo ID")
df_obsolete_candidates = df_obsolete_candidates.merge(df_labels,how="left",on="Mondo ID")
df_old_obsolete_candidates = df_old_obsolete_candidates.merge(df_labels,how="left",on="Mondo ID")

if len(df_changed_labels)>0:
    print("")
    print("### Changed labels")
    print("")
    print(df_changed_labels[['Mondo ID','Label', 'Previous release', 'New release']].to_markdown(index=False))
else:
    print("No changed labels.")

print("")
print("### Changed definitions")
print("")

if len(df_changed_definitions)>0:
    print(df_changed_definitions[['Mondo ID','Label', 'Previous release', 'New release']].to_markdown(index=False))
else:
    print("No changed definitions.")

print("")
print("### Obsolete terms")
print("")

if len(df_obsolete_terms)>0:
    print(df_obsolete_terms[['Mondo ID','Label']].to_markdown(index=False))
else:
    print("No obsoleted classes.")

print("")
print("### New obsoletion candidates")
print("")
    
if len(df_obsolete_candidates)>0:
    print(df_obsolete_candidates[['Mondo ID','Label']].to_markdown(index=False))
else:
    print("No new candidates for obsoletion.")

print("")
print("### Terms that were previously candidate for obsoletion and are now not anymore")
print("")
    
if len(df_old_obsolete_candidates)>0:
    print(df_obsolete_candidates[['Mondo ID','Label']].to_markdown(index=False))
else:
    print("No changes.")

