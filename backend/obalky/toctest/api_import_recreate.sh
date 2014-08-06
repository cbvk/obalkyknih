#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "Je nutne uvest povinny parametr, cestu k import adresari !!!"
    exit 0
fi

SCRIPT_DIR=$1

if [ ! -d $SCRIPT_DIR ] ; then
    echo "### IMPORT ADRESAR $SCRIPT_DIR  --- NEEXISTUJE ---"
    exit 0
fi

SCRIPT_DIR_ESCAPED=$(echo "$SCRIPT_DIR" | sed -r 's/\//\\\//g')
awk "/"$SCRIPT_DIR_ESCAPED"$/,/import done/{print}" /opt/obalky/log/import.log > $SCRIPT_DIR/import_extract.log

cat $SCRIPT_DIR/import_extract.log | grep ean13 | sed "s/\(.*\)'ean13' => \(.*\),/\2/" > $SCRIPT_DIR/param.ean
cat $SCRIPT_DIR/import_extract.log | grep nbn | sed "s/\(.*\)'nbn' => \(.*\),/\2/" > $SCRIPT_DIR/param.nbn
cat $SCRIPT_DIR/import_extract.log | grep oclc  |sed "s/\(.*\)'oclc' => \(.*\),/\2/" > $SCRIPT_DIR/param.oclc
cat $SCRIPT_DIR/import_extract.log | grep 'ocrFlag, tocId' | sed "s/\(.*\)tocId=\(.*\)/\2/" > $SCRIPT_DIR/toc.id
sed -ri "s/'//g" $SCRIPT_DIR/param.ean
sed -ri "s/'//g" $SCRIPT_DIR/param.nbn
sed -ri "s/'//g" $SCRIPT_DIR/param.oclc

##############################
# Vytvarim api_import script
##############################
cat <<"EOF" > $SCRIPT_DIR/api_import.sh
#!/bin/bash
curl -F "login=admin@cbvk.cz" -F "password=31415" \
EOF

### EAN13 - GET DATA ###
EAN=$(cat "$SCRIPT_DIR"/param.ean)
if [ "$EAN" != "" ]; then
    echo '	 -F "isbn='$EAN'" \' >> $SCRIPT_DIR/api_import.sh
fi

### NBN - GET DATA ###
NBN=$(cat "$SCRIPT_DIR"/param.nbn)
if [ "$NBN" != "" ]; then
    echo '	 -F "nbn='$NBN'" \' >> $SCRIPT_DIR/api_import.sh
fi

### OCLC - GET DATA ###
OCLC=$(cat "$SCRIPT_DIR"/param.oclc)
if [ "$OCLC" != "undef" ]; then
    echo '	 -F "oclc='$OCLC'" \' >> $SCRIPT_DIR/api_import.sh
fi

### COVER - POST DATA ###
if [ -f $SCRIPT_DIR/cover ]; then
    echo '	 -F "cover=@cover" \' >> $SCRIPT_DIR/api_import.sh
fi

### TOC - POST DATA ###
i=1
for filename in $SCRIPT_DIR/toc_page_*; do
    echo '	 -F "toc_page_'$i'=@'$(basename $filename)'" \' >> $SCRIPT_DIR/api_import.sh
    let i++
done

### META - POST DATA ###
if [ -f $SCRIPT_DIR/meta ]; then
    echo '	 -F "meta=@meta" \' >> $SCRIPT_DIR/api_import.sh
fi

### OCR regenerate
TOCID=$(cat "$SCRIPT_DIR"/toc.id)
if [ "$TOCID" != "" ] && [ -f $SCRIPT_DIR/toc.pdf ]; then
    echo ">>> $SCRIPT_DIR   =>    TOCID: $TOCID"
    #cp $SCRIPT_DIR/toc.pdf /opt/obalky/ocr/input/$TOCID.pdf
fi

echo '	 http://www.obalkyknih.cz/api/import' >> $SCRIPT_DIR/api_import.sh
#chmod u+x $SCRIPT_DIR/api_import.sh
rm $SCRIPT_DIR/api_import.sh
rm $SCRIPT_DIR/import_extract.log $SCRIPT_DIR/param.ean $SCRIPT_DIR/param.nbn $SCRIPT_DIR/param.oclc
