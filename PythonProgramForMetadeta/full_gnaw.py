# This is the wrapper-wrapper for Gracenote using Pygn.
# It will do single searches for a song or album as long as the artist is provided,
# but it also includes the first version of "Simple Gnaw" for handling files.
# Please note that this version of Gnaw does not contain nested error checking, backup logins for Gracenote,
# or existing data recognition. This should only be used as a demonstration or to pull metadata for < 50 songs.

from __future__ import print_function
from tqdm import tqdm
import pygn, sys, json, csv, getopt

# Login
clientID = '1441931071-E781596CC5CC4E1EBD05775BCC16A317'
userID = '49918418169816731-A8CD882F481B3E8C18D613F8A18E9DF4'

# Init lists
music = []
mout = []
meta = []

def usage():
    print("gnaw.py -s <track title>\ngnaw.py -a <album name>\ngnaw.py -f <input CSV>")

def handleFile(CSV):
    # Init lists
    music = []
    meta = []
    name = CSV[:-4] + "_metadata.txt"

    # Open the csv
    with open(CSV) as songcsv:
        songreader = csv.reader(songcsv, delimiter = ',')
        for row in songreader:
            music.append(row)

    index = 0
    # Main Loop
    with open(name, 'a+') as fileout:
        for item in tqdm(music):
            try:
                temp = pygn.search(clientID=clientID, userID=userID, artist=item[1], track=item[2])
                fileout.write("%s\n" % temp)
                index += 1
            except Exception:
                fileout.write("%s\n" % "None")
                index += 1
                continue

def main(argv):
    try:
        opts, args = getopt.getopt(argv, "s:a:f:h", ["song=", "album=", "file=", "help"])
    except getopt.GetoptError:
        usage()
        sys.exit(2)

    usefile, usesong, usealbum = False, False, False
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage()
            sys.exit(2)
        elif opt in ("-a", "--album"):
            album = arg
            usealbum = True
        elif opt in ("-f", "--file"):
            infile = arg
            usefile = True
        elif opt in ("-s", "--song"):
            song = arg
            usesong = True

    if usefile == True:
        handleFile(infile)
    elif usesong == True:
        artist = sys.argv[3]
        data = pygn.search(clientID=clientID, userID=userID, artist=artist, track=song)
        print(json.dumps(data, indent=2))
    elif usealbum == True:
        artist = sys.argv[3]
        data = pygn.search(clientID=clientID, userID=userID, artist=artist, album=album)
        print(json.dumps(data, indent=2))


if __name__ == "__main__":
    main(sys.argv[1:])
