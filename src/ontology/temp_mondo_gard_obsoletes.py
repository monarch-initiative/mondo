"""GARD::Mondo obsoletes"""
import os

import pandas as pd

THIS_DIR = os.path.dirname(os.path.realpath(__file__))
# OBSOLETES_PATH = os.path.join(THIS_DIR, 'reports', 'obsoletes.tsv')
# SSSOM_PATH = os.path.join(THIS_DIR, 'tmp', 'mondo.sssom.tsv')
OBS_SSSOM_PATH = os.path.join(THIS_DIR, 'tmp', 'mondo-obsoletes.sssom.tsv')

# obs_df = pd.read_csv(OBSOLETES_PATH, sep='\t')
# sssom_df = pd.read_csv(SSSOM_PATH, sep='\t', comment='#')
obs_sssom_df = pd.read_csv(OBS_SSSOM_PATH, sep='\t', comment='#')


# obs_ids = set(obs_df['id'])
# mapped_obs_df = sssom_df[(sssom_df['subject_id'].isin(obs_ids)) & (sssom_df['object_id'].str.startswith('GARD:'))]
mapped_obs_df = obs_sssom_df[obs_sssom_df['object_id'].str.startswith('GARD:')]
mapped_obs_df.to_csv(os.path.join(THIS_DIR, 'reports', 'gard-mondo-mapped-obsoletes.tsv'), sep='\t', index=False)
