#!/bin/bash

# Author: alex.mitan@yahoo.com
# License: Apache Version 2.0
# Description: This script will take an image, split it in chunks and then recode it 

if [[ $# -lt 2 ]]; then
    echo "Usage: ./$0 source_picture destination_picture"
    return 1
fi

pic=$1
dest=$2

#TO-DO: Command line parameter for number of chunks

#Check if $3 or $chunks variable is set
#chunks=$3 
#if [[ -z ${chunks+x} ]]; then
#    chunks=3 
#fi

echo "Jumbling initiated"
if [[ -f "$pic" ]]; then
    echo "Attempting to jumble $pic into $dest"
    
    # original -> a b c -> a c b
    # jumbled  -> a c b -> a b c
    split "$pic" -n 3 "${pic}"
    echo "Split into cha[a-c]"
    
    # if a destination is provided write there
    if [[ -n "$dest" ]]; then 
        if [[ -f "$dest" ]]; then
            rm "$dest"
            echo "File $dest overwritten"
            touch "$dest"
        fi
        cat "${pic}"aa "${pic}"ac "${pic}"ab > "$dest"
        echo "$pic jumbled into $dest"
    else                
        # otherwise overwrite the file
        cat "${pic}aa ${pic}ac ${pic}ab" > "$pic"
        echo "$pic (re?)jumbled"
    fi
    
    rm "${pic}aa ${pic}ab ${pic}ac"   # cleanup
else
    echo "Filename absent or invalid!"
fi

