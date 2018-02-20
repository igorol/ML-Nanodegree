from glob import glob
import os

listoffiles = glob('./*csv')

print listoffiles

for infilename in listoffiles:
    lines_seen = set()  # holds lines already seen
    outfile = open('temp', "w")
    for line in open(infilename, "r"):
        if line not in lines_seen:  # not a duplicate
            outfile.write(line)
            lines_seen.add(line)
    outfile.close()
    os.system('mv temp {}'.format(infilename))