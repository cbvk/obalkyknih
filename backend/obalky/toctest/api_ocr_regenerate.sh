#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "Je nutne uvest povinny parametr, cestu k import adresari !!!"
    exit 0
fi

SCRIPT_DIR_PART=$1
SCRIPT_DIR='/opt/obalky/www/import/'$SCRIPT_DIR_PART

if [ ! -d $SCRIPT_DIR ] ; then
    echo "### IMPORT ADRESAR $SCRIPT_DIR  --- NEEXISTUJE ---"
    exit 0
fi

SCRIPT_DIR_ESCAPED=$(echo "$SCRIPT_DIR" | sed -r 's/\//\\\//g')
awk "/"$SCRIPT_DIR_ESCAPED"$/,/import begin/{print}" /opt/obalky/log/import.log > $SCRIPT_DIR/import_extract.log

if [ `grep 'ok, product' $SCRIPT_DIR/import_extract.log | wc -l` -ne 1 ] ; then
    echo "!!! $SCRIPT_DIR   =>    UPLOADS OVERLAPPING, UNABLE TO GET RELIABLE OUTPUT"
    rm $SCRIPT_DIR/import_extract.log
    echo 'http://www.obalkyknih.cz/import/'$SCRIPT_DIR_PART'/toc.pdf' >> /opt/obalky/toctest/api_ocr_regenerate.unpaired
    exit 0
fi

cat $SCRIPT_DIR/import_extract.log | grep 'ocrFlag, tocId' | sed "s/\(.*\)tocId=\(.*\)/\2/" > $SCRIPT_DIR/toc.id

### OCR regenerate
TOCID=$(cat "$SCRIPT_DIR"/toc.id)
if [ "$TOCID" != "" ] && [ -f $SCRIPT_DIR/toc.pdf ]; then
    echo ">>> $SCRIPT_DIR   =>    TOCID: $TOCID"
    cp $SCRIPT_DIR/toc.pdf /opt/obalky/ocr/input/$TOCID.pdf
else
    echo "    $SCRIPT_DIR   =>    OCR not required"
fi

rm $SCRIPT_DIR/import_extract.log
