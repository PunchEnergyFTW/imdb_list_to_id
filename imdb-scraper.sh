#!/bin/bash
read -p "Full URL of the IMDb List: " starturl
while true
do
nexturl=$(lynx -dump "$starturl" | grep -o 'https://www.imdb.com/search/title/.*=adv_nxt' | head -1)
lynx -dump "$starturl" | grep -o 'https://www.imdb.com/title/tt.*/?ref_=adv_li_tt' | sed 's-https://www.imdb.com/title/--g' | sed 's-/?ref_=adv_li_tt--g' >> imdb-ids.txt
echo $starturl >> scraped-links.txt
if [ "$starturl" == "$nexturl" ]
	then
	echo Starturl is the same as Nexturl
	exit
fi
starturl=$nexturl
number=$(($number + 1))
if [ -z "$starturl" ]
	then
		echo "No Next Button found! Probably the last Site - YES is was scraped."
		exit
	else
		echo Done scraping Link number: $number
fi
done
