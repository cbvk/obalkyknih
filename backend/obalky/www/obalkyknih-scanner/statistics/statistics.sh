#!/bin/bash

if [ "$#" != "4" ]; then
  echo "Syntax: ./statistics.sh searchType searchTerm dateFrom dateTo"
  echo "searchType: Podla coho chceme vyhladavat [sigla/user]"
  echo "searchTerm: Hladany vyraz (napr. ABA001)"
  echo "dateFrom: Datum, od ktoreho chceme zacat hladat (vratane). Musi byt vo formate YYYYMMDD (napr. 20130901)"
  echo "dateTo: Datum, po ktory chceme hladat (vratane). Musi byt vo formate YYYYMMDD(napr. 20130901)"
  echo "Priklad: ./statistics sigla ABA001 20130901 20140101"
fi

echo Hladam potrebne data, pockajte prosim...
find /opt/obalky/www/import -name meta | xargs grep -l "<$1>$2" > /opt/obalky/www/obalkyknih-scanner/statistics/data-stats.txt

coverTotal=0
tocTotal=0
tocPagesTotal=0

echo Pocitam, pockajte prosim...
#pre vsetky vhodne zlozky spocitaj obalky a obsahy
while read line
do
  #extract directory path
  directoryPath=`echo $line | rev | cut -c 6- | rev`

  if [[ ( "$directoryPath" > "/opt/obalky/www/import/$3" ) && ( "$directoryPath" < "/opt/obalky/www/import/$4" ) ]]
  then
    #get number of object in given directory
    coverTmp=`find $directoryPath -name cover | wc -l`
    tocTmp=`find $directoryPath -name toc.pdf | wc -l`
    tocPagesTmp=`find $directoryPath -regex '.*/toc_page_[0-9]+' | wc -l`

    #increment total values of objects
    coverTotal=$((coverTotal + coverTmp))
    tocTotal=$((tocTotal + tocTmp))
    tocPagesTotal=$((tocPagesTotal + tocPagesTmp))
  fi
done < /opt/obalky/www/obalkyknih-scanner/statistics/data-stats.txt

echo "Celkovy pocet obalok: $coverTotal"
echo "Celkovy pocet obsahov: $tocTotal"
echo "Pocet stran obsahov: $tocPagesTotal"

rm /opt/obalky/www/obalkyknih-scanner/statistics/data-stats.txt


