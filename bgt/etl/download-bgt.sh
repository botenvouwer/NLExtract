#!/bin/bash

# See https://www.pdok.nl/nl/producten/pdok-downloads/download-basisregistratie-grootschalige-topografie
today=`date +"%d-%m-%Y"`

if [ -n "$2" ]
then
  blocks=$2
else
  # ID's van 32x32 km gebieden om de BGT te downloaden. Let op, de ID's mogen geen voorloopnullen bevatten.
  blocks="39 45 48 50 51 54 55 56 57 58 59 60 61 62 63 74 75 96 97 98 99 104 105 106 107 110 111 145 148 149 150 151 156 157 158 159 180 181 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 224 225 228 229 230"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -z "$1" ] && pushd leveringen/latest || pushd $1
for block in ${blocks}
do 
  echo "Downloading BGT-blok ${block} ..."
  block_url="https://downloads.pdok.nl/service/extract.zip?extractname=bgt&extractset=citygml&excludedtypes=plaatsbepalingspunt&history=true&tiles=%7B%22layers%22%3A%5B%7B%22aggregateLevel%22%3A4%2C%22codes%22%3A%5B${block}%5D%7D%5D%7D&enddate=${today}"

  echo "$block_url"

  bash ${DIR}/robust-download.sh ${block_url} bgt_${block}.zip
done

popd
