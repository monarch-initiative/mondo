import argparse
import pandas as pd

def main(args):
    # Read the input files into pandas dataframes
    old_df = pd.read_csv(args.old_rare_list, sep='\t')
    new_df = pd.read_csv(args.new_rare_list, sep='\t')

    # Filter the dataframes
    df_added = old_df[~old_df['ID'].isin(new_df['ID'])]
    df_removed = new_df[~new_df['ID'].isin(old_df['ID'])]

    # Save the filtered dataframes to TSV files
    df_removed.to_csv(args.new_rare_diseases, sep='\t', index=False)
    df_added.to_csv(args.lost_rare_diseases, sep='\t', index=False)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process and filter two TSV files")
    parser.add_argument("old_rare_list", help="Path to the first input TSV file")
    parser.add_argument("new_rare_list", help="Path to the second input TSV file")
    parser.add_argument("new_rare_diseases", help="Path to the first output TSV file")
    parser.add_argument("lost_rare_diseases", help="Path to the second output TSV file")

    args = parser.parse_args()

    main(args)
