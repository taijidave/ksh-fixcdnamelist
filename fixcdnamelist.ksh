#!/bin/ksh

#	5:01 PM 1/26/2009

#	fixcdnamelist.ksh 
#	use: ./fixcdnamelist.ksh filename

#	NOTE: 
#	Prep Listfile: (ie, from Sound Ideas .pdf listing...)
#	  ...remove illegal filename char's:  \ / : * ? " < > |   {and ';' b/c Nero doesn't like it}


#echo $1


#1) remove multi-line descriptions:  {NOTE: check/confirm the filenum-suffix... here -&- in Step-5}
#   grep "\-01 " $1 > ztmpfile0
   grep "\-1 " $1 > ztmpfile0

#2. change uppercase to lowercase!! ;-D
   cat ztmpfile0 | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' > ztmpfile1

#2b. fix illegal char's: 
# find/replace ": " -> "- " {note the trailing space}, 
   cat ztmpfile1 | sed 's/: /- /g' | \
# find/replace ";" -> "-" 	...Nero doesn't like it
   sed 's/;/-/g' | \
# find/replace "?" -> "" 
   sed 's/?//g' | \
# find/replace "~" -> "" 
   sed 's/~/-/g' | \
# find/replace "%" -> "pct" 	...WinAmp doesn't like it
   sed 's/%/pct/g' | \
# find/replace """ -> "'" 
   sed "s/\"/'/g" | \
# find/replace "\" -> "-" 
   sed 's#\\#-#g' | \
# find/replace "/" -> "-"
   sed 's#\/#-#g' | \
# find/replace "*" -> "^"
   sed 's/*/^/g' | \
# find/replace "<" -> "-"
   sed 's/</-/g' | \
# find/replace ">" -> "-"
   sed 's/>/-/g' | \
# find/replace "|" -> "-"
   sed 's/|/-/g' > ztmpfile2

#3. fix last column of durations: find/replace "1:" -> ":" , "2:" -> ":" , etc
   cat ztmpfile2 | sed 's/0:/:/g' \
   | sed 's/1:/:/g' \
   | sed 's/2:/:/g' \
   | sed 's/3:/:/g' \
   | sed 's/4:/:/g' \
   | sed 's/5:/:/g' \
   | sed 's/6:/:/g' \
   | sed 's/7:/:/g' \
   | sed 's/8:/:/g' \
   | sed 's/9:/:/g' \
   | sed 's/10:/:/g' > ztmpfile3

#4. then...  remove the last column of durations
   cat ztmpfile3 | awk -F: '{print $1}' > ztmpfile4

#5. remove prefix metadata: find/replace [unique string] with ":" {illegal filename char: perfect!}
#   cat ztmpfile4 | sed 's/-01 / : /' > cdnamelist
   cat ztmpfile4 | sed 's/-1 / : /' > cdnamelist

rm ztmpfile*

