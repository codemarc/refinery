#!/bin/bash

# grab the latest released open refine
openrefine=$(curl -s https://github.com/OpenRefine/OpenRefine/releases |grep -A2 "release-downloads" |
grep -Eoi '<a [^>]+>' |grep -Eo 'href="[^\"]+"' |head -1 |sed 's/\"//g' |cut -d'=' -f2)
curl -L https://github.com$openrefine | tar zx 	
mv openrefine* refine

# and kick it off
./refine/refine

