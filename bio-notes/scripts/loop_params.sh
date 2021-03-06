#!/usr/bin/env bash

usage() { echo "Usage: $0 [-t <string>] [-q <string>] [-d <string>]" 1>&2; exit 1; }

while getopts ":t:q:d:" o; do
    case "${o}" in
        t)
            t=${OPTARG}
            ;;
        q)
            q=${OPTARG}
            ;;
        d)
            d=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${t}" ] || [ -z "${q}" ] || [ -z "${d}" ]; then
    usage
fi

for a_val in 80 82 85 87 90 93 95
do
	dir_name="${d}/a{a_val}"
	mkdir $dir_name
	mpggb -i $t -q $q -n 10 -s 50000 -p 95 -a ${a_val} -n 10 -k 27 -t 16 -o $dir_name
	viz=$(find $dir_name -name '*bandage_viz.png')
	open $viz
	printf "\n============================================================ \n"
	printf "\n                         Done $a_val\n"
	printf "\n============================================================ \n"
done
