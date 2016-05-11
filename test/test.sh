#!/bin/bash

PRGDIR=`dirname $0`
EXEC="../dic.sh"

for word in `cat "$PRGDIR"/"./words.txt"`; do
	echo "----<< $word >>----"
	sh "$PRGDIR"/"$EXEC" "$word"
	echo
done