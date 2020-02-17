#!/bin/bash
#
# ETL voor IMGeo GML met gebruik Stetl.
#
# Dit is een front-end/wrapper shell-script om uiteindelijk Stetl met een configuratie
# (etl-imgeo.cfg) en parameters (options/myoptions.args) aan te roepen.
#
# Author: Just van den Broecke
# Changed by: William Loosman
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $DIR >/dev/null

NLX_HOME=/app

# Gebruik Stetl meegeleverd met NLExtract (kan in theorie ook Stetl via pip install stetl zijn)
#if [ -z "$STETL_HOME" ]; then
#  STETL_HOME=../../externals/stetl
#fi

# Nodig voor imports
if [ -z "$PYTHONPATH" ]; then
  #Todo: dynamicly find stetl or use stetl prefix in config
  export PYTHONPATH=/usr/local/lib/python3.6/site-packages/Stetl-2.0-py3.6.egg/stetl/:$NLX_HOME:.
else
  export PYTHONPATH=/usr/local/lib/python3.6/site-packages/Stetl-2.0-py3.6.egg/stetl/:$NLX_HOME:.:$PYTHONPATH
fi
# 

# Default arguments/options
options_file=options/default.args

# Optionally overules default options file by using a host-based file options/<your hostname>.args
# To add your localhost add <your hostname>.args in options directory
host_options_file=options/`hostname`.args

[ -f "$host_options_file" ] && options_file=$host_options_file

# Evt via commandline overrulen: etl-imgeo.sh <my options file>
[ -f "$1" ] && options_file=$1

# Uiteindelijke commando. Kan ook gewoon "stetl -c conf/etl-imgeo-v2.1.1.cfg -a ..." worden indien Stetl installed
# python $STETL_HOME/stetl/main.py -c conf/etl-imgeo-v2.1.1.cfg -a "$pg_options temp_dir=temp max_features=$max_features gml_files=$gml_files $multi $spatial_extent"
stetl -c conf/etl-imgeo-v2.1.1.cfg -a $options_file

popd >/dev/null
