#!/bin/bash

PRGDIR=`dirname $0`
EXEC="../dic.sh"

while read query; do
	echo "----<< $query >>----"
	sh "$PRGDIR"/"$EXEC" "$query"
	echo
done < "$PRGDIR/./words.txt"
