# This program is used to fill in metadata for the "top5000songs.csv" file, make sure it's in the same directory
# If you have a previous output file it will skip over the existing lines (still writes the data to a new file)
# It dumps it to "metadata5000x.txt" - make sure to alter filenames as needed

from __future__ import print_function
from tqdm import tqdm
import pygn, sys, json, csv

# Logins
clientID = '1441931071-E781596CC5CC4E1EBD05775BCC16A317'
userID = '49918418169816731-A8CD882F481B3E8C18D613F8A18E9DF4'

clientID2 = '709371742-00E7F1DE5F12945112375208FDFFFD5B'
userID2 = '27681944132852331-1A932F0545D3D2A22080194840BC047E'


# Init lists
music = []
meta = []

# Open the csv
with open('top5000songs.csv') as songcsv:
    songreader = csv.reader(songcsv, delimiter = ',')
    for row in songreader:
        music.append(row)

# CHANGE THIS FILENAME DEPENDING ON THE LAST OUTPUT!
with open('metadata5000.txt', 'r+') as metafile:
    for row in metafile:
        meta.append(row)

index = 0
# Main Loop
with open('metadata5000x.txt', 'a+') as fileout:
    # TQDM is the progressbar - it's a lifesaver
    for item in tqdm(music):
        try:
            if meta[index] == "None\n":
                # Pygn search function
                temp = pygn.search(clientID=clientID, userID=userID, artist=item[1], track=item[2])
                fileout.write("%s\n" % temp)
                index += 1
            else:
                temp = meta[index]
                fileout.write(temp)
                index += 1
        except Exception:
            # Try the other login if Gracenote begins throttling
            try:
                temp = pygn.search(clientID=clientID2, userID=userID2, artist=item[1], track=item[2])
                fileout.write("%s\n" % temp)
                index += 1
                continue
            except Exception:
                # Write none if no data comes at all, go to next song
                fileout.write("%s\n" % "None")
                index += 1
                continue
