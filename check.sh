#!/bin/sh

	stime=`date +%s`
	
	dir=.
	treads=10;


	> tmp;
	find $dir -type f -name "*.c" > tmpfile
#	find $dir -type f -name "*.h" >> tmpfile

	afile=`cat tmpfile |wc -l`
 
	strcount=1

	for ((i=1; i<=afile; i++))
	do
		for ((j=0; j<=treads; j++))
		do
			let "num = $i + $j"
			echo $num

			filen=`sed -n $num"p" tmpfile`;

			./treads.sh $filen &

			let "num = $i + $j"
		done
	
		wait;
		let "i = i + $treads";
	
	done

	cat tmp |grep -v ^$ > tmp2

 	awk '	 BEGIN { FS=" " ; OFS=" " }
 	        { 	a++
			top=100;
			
			line = line + $7;
 			if ($3 != 0) {
	 			r++;
				allerr=allerr+$3;
			}
	 	        if ($5 != 0)
	        		w++;
 	        	if ($3 == 0 && $5 == 0)
 	        		nr++;
			if ($3 > rtop[top-1]) {
				sect = top;
				j = 0;
				while(sect >= 1) {
					if (sect%2) { #ne 4etnoe
						up = int(sect/2)+1
						flag = 1
					}
					else { #4etnoe
						up = int(sect/2)
						flag = 0
					}
					sect = int(sect/2)
					
					if (($3 <= rtop[i+up-1]) && ($3 >= rtop[i+up])) {
					 	j = i + up
						break;
					}
					else if ($3 > rtop[i+up]) { #in up section
						continue;
					}	
					else { #in down section
						i = i + up 
					continue;
					}     		
				}
					
				for (k=top; k>(0+j); k--) {
					rtop[k] = rtop[k-1]
					topf[k] = topf[k-1]
				}
				
				rtop[j] = $3;
				topf[j] = $1;
				i = 0;
			}


		}
        	
        	END { print "\nCheck line: " line "\nQuantity find error: " allerr "\nQuantity check files: " a "\nQuantity files containing error: " r "\nQuantity files containing warning: " w "\nGood file: " nr "\nPercent good in all: " 100*nr/a"%"
			{ print ("\ntop " top " error:\n") }	
 	                while(rtop[i]) {
 	           		{ print	("file: " topf[i] "\nerror: " rtop[i])}
 	           		i++;
 	           	}
 	       	} ' tmp2
			
	let "exectime=(`date +%s`-stime)/60";
	echo -n "Checking time:" $exectime min;
	