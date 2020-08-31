#!/usr/bin/env python

import argparse
import pandas as pd

def main():
    """
    Slurp into csv
    """
    parser = argparse.ArgumentParser(description='foo'
                                                 """
                                                 bar
                                                 """,
                                     formatter_class=argparse.RawTextHelpFormatter)

    parser.add_argument('-m', '--module', type=str, default='modules/disease_by_location.csv',
                        help='Module to enhance')

    parser.add_argument('files',nargs='*')
    args = parser.parse_args()
    
    indf = pd.read_csv(args.module)

    for f in args.files:
        ndf = pd.read_csv(f, sep="\t")
        for _,row in ndf.iterrows():
            print('{}'.format(row[2:4]))


if __name__ == "__main__":
    main()
