
import pandas as pd
import numpy as np



test = pd.read_csv("/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Data/Real/Termitetermite_video_tracked.csv")

# split the data payload and add a column for axis
testx = test[['frame', 'id', 'pos_x']]
testx['axis'] = 'x'
testx = testx.rename(columns={'pos_x': 'pos'})

testy = test[['frame', 'id', 'pos_y']]
testy['axis'] = 'y'
testy = testy.rename(columns={'pos_y': 'pos'})

# rbind
test2 = pd.concat([testx, testy])
test2 = test2[['frame', 'id', 'axis', 'pos']]

# the rest that does the reshape is from https://stackoverflow.com/a/47715715

# collect the df w/ a groupby
grouped = test2.groupby(['frame', 'id', 'axis'])['pos'].mean()

# create an array for the outputs, then fill it
shape = tuple(map(len, grouped.index.levels))
arr = np.full(shape, np.nan)
arr[grouped.index.codes] = grouped.values.flat

grouped.index.levels




arr.shape
arr
