# This program requres a completed metadata text file
# It will dump songs in a json array line-by-line

import json, ast

meta = []
with open('metadata5000x.txt', 'r+') as metafile:
    for line in metafile:
        # convert each dict to a json array
        temp = ast.literal_eval(line)
        meta.append(temp)

with open("meta.json", "w") as f:
    for d in meta:
        # dump the file
        json.dump(d, f)
        f.write('\n')
