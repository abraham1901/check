#!/bin/sh

	str=$(scripts/checkpatch.pl --file $BASH_ARGV | grep ^total: | while read str1 
	do
		fil=`basename $BASH_ARGV`;
		echo $fil $str1;
	done)
	echo $str >> tmp

