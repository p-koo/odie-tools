#!/usr/bin/python

import os.path
import pandas as pd
import sys

def fastqc_scrape_sequence_length(directory,seqlengthindex,offset):
    """loop through all files in directory and parse filename and
    average read length from Basic Statistics.txt files generated 
    from fastqc_parse_statistics.py and store in dataframe"""

    # create empty dataframe
    df = pd.DataFrame(columns=['filename', 'ave_length'])

    # loop through directory to find 'Basic Statistics.txt' files
    dirlist = os.listdir(directory)
    for dirpath in dirlist:
        if os.path.isdir(os.path.join(directory,dirpath)):
            filepath = os.path.join(directory,dirpath, "Basic Statistics.txt")
            if os.path.exists(filepath):
                print "scraping " + filepath
                
                # parse average length
                tb = pd.read_table(filepath)
                length = tb.iloc[seqlengthindex,1]
                if '-' in length:
                    index = length.find('-')
                    averagelength = (int(length[0:index])+int(length[index+1::]))/2
                else:
                    averagelength = int(length)

                # parse filename
                filename = dirpath[:-offset]

                # add filename and sequence length to data frame
                df.loc[len(df)] = [filename, averagelength]
    
    return df
    
def main():
    """ This script takes in a path and parses the fastqc_data.txt 
    files in each subdirectory"""

    # Open a file
    # directory="/Users/pkk23/Desktop/Postdoc/fredpdavis/rawdata/qualitycontrol/"
    # outfilename='SequenceLength.csv'  
    directory = sys.argv[1]
    outfilename = sys.argv[2]
    seqlengthindex = 5    # index where sequence length is located
    offset = 7            # offset to remove _fastqc at end of directory

    # main parent directory
    df = fastqc_scrape_sequence_length(directory,seqlengthindex,offset)

    # save database to csv file
    df.to_csv(os.path.join(directory, outfilename))
    print "saving " + os.path.join(directory, outfilename)
    
if __name__ == "__main__":
    main()

