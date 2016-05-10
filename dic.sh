#!/bin/bash

word=$1
curl "http://cn.bing.com/dict/search?q=$word&go=Submit&qs=bs&form=Z9LH5" 2>/dev/null |\
	grep -Eo '<meta name="description" content="(.+) "/>' |\
	sed -E 's/<meta name="description" content="必应词典为您提供.+的释义，//' |\
	sed 's/"\/>//' | sed -E 's/(.*)(，)(.*)/\1 \3/' | awk -v WORD=$word '{
		c=0;
		print WORD;
		for(i=1;i<=NF;i++) {
			if(match($i, "^[a-z]+\.|网络释义：$") != 0) {
				if(c==0) printf "\n";
				print $i,$++i;
				c++;
			} else {
				print $i;
			}
		}
	}'