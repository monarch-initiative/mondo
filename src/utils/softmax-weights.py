#!/usr/bin/env python

import pandas as pd
import numpy as np

import click

pred_index = {
    'subClassOf': 0,
    'superClassOf': 1,
    'eq': 2,
    'relatedTo': 3
    }


@click.command()
@click.option('--weight3', '-3', type=click.FLOAT, default=1.0)
@click.argument('filename')
def tr(filename, weight3):
    df = pd.read_csv(filename, sep='\t', header=None)
    svec = {}
    for _,row in df.iterrows():
        pred = row[0]
        pair = row[1], row[2]
        s = row[3]
        if pair not in svec:
            svec[pair] = [0,0,0,weight3]
        ix = pred_index[pred]
        svec[pair][ix] += s

    for pair, s in svec.items():
        probs = softmax(s)
        vals = [pair[0],pair[1]] + [str(x) for x in probs]
        print('{}'.format("\t".join(vals)))



def softmax(x):
    """Compute the softmax of vector x."""
    exps = np.exp(x)
    return exps / np.sum(exps)

if __name__ == '__main__':
    tr()
