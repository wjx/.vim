#!/usr/bin/python

import sys
import os
import time

def usage():
    print "usage : recent.py [filename]"

def addToRecentFile(filename):
    tmpfilename=os.path.join(os.environ["HOME"],'.vim/.recent_files.tmp')
    recent_files= os.path.join(os.environ["HOME"],'.vim/recent_files')
    date=time.strftime('%Y%m%d %H:%M' ,time.localtime())
    filename=filename.replace(os.environ["HOME"],"~")
    
    tmpfile=open(tmpfilename, "a")

    if os.path.exists(recent_files):
        fic=open(recent_files, 'r')
        for line in fic.readlines():
            if line.split(" ")[0] != filename:
                print >> tmpfile, line[:-1]

        fic.close()

    print >> tmpfile,filename.ljust(49) + " " + date
    tmpfile.close()

    os.rename(tmpfilename, recent_files)


### MAIN ####

if len(sys.argv) == 1:
    usage()
    sys.exit(1)

absfilename=sys.argv[1]
filename=absfilename.split('/')[-1]
append=True

# Not append svn temp file
if filename[:3] == 'svn':
    append=False

# Not append cvs temp file
if filename[:3] == 'cvs':
    append=False

if append:
    addToRecentFile(absfilename)
