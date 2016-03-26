#!/usr/bin/python
import os, sys, getopt

def parse_fastqc(directory, files):
    """ This function takes as input a directory and 
    parses the fastqc_data.txt file into separate files"""

    # open fastqc data file
    path,filename = os.path.split(directory)
    summary = open(directory)
    summary.readline()

    # parse fastqc data into separate txt files
    filecount = 0
    numcounts = 0
    for line in summary:

        # find indicator for a file signal '>>'
        if line[0:2] == '>>':
            numcounts += 1

            # every '>>' alternates between a new file and 
            # the end of the currrent file
            if (numcounts%2) == 1:
                f = open(os.path.join(path, files[filecount]),'w')
                continue
            else:
                filecount += 1
                f.close()

        # write data to corresponding file    
        if not f.closed:
            f.write(line)


def main():
    """ This script takes in a path and parses the fastqc_data.txt 
    files in each subdirectory"""

    # main parent directory
    directory = sys.argv[1]

    # order of the outputs from fastqc_data.txt
    files=['Basic Statistics.txt',
           'Per base sequence quality.txt',
           'Per tile sequence quality.txt',
           'Per sequence quality scores.txt',
           'Per base sequence content.txt',
           'Per sequence GC content.txt',
           'Per base N content.txt',
           'Sequence Length Distribution.txt',
           'Sequence Duplication Levels.txt',
           'Overrepresented sequences.txt',
           'Adapter Content.txt',
           'Kmer Content.txt']
    
    # loop through all files in direcotry
    dirlist = os.listdir(directory)
    for dirpath in dirlist:
        if os.path.isdir(os.path.join(directory,dirpath)):
            filepath = os.path.join(directory,dirpath, "fastqc_data.txt")
            if os.path.exists(filepath):
                print "parsing "+filepath
                parse_fastqc(filepath, files)

if __name__ == "__main__":
    main()

