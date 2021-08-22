#!/bin/bash

function printUsage() {
	cat <<EOF
Usage: dic <word[s]>
EOF
}

if [ $# -eq 0 ]; then
	printUsage
	exit 1
fi

query="$@"
curl --max-time 5 -sSLG "https://cn.bing.com/dict/search" --data-urlencode "q=$query" |\
	grep -Eo '<meta name="description" content="(.+) " ?/>' |\
	sed -E 's/<meta name="description" content="必应词典为您提供.+的释义，(.+)" ?\/>/\1/' |\
	sed -E 's/(.*)(，)(.*)/\1 \3/' | awk -v "QUERY=$query" '{
		c=0;
		print QUERY;
		for(i=1;i<=NF;i++) {
			if(match($i, "^[a-z]+\\.|网络释义：$") != 0) {
				if(c==0) printf "\n";
				printf "\n";
				c++;
			}
			printf "%s ",$i;
		}
		printf "\n";
	}'

if [ ${DISABLE_DIC_HISTORY:-0} -ne 1 ]; then
	echo "$(date +%Y-%m-%dT%H:%M:%S) $@" >> $HOME/.dic_history
fi
