# !/bin/bash

FILE=$1
echo target = $FILE

PWD=`pwd`
echo current = $PWD

rm *.gz         2>/dev/null

cd $FILE
make clean      2>/dev/null 1>/dev/null
cd ..

tar -czf $FILE/$FILE.tar.gz $FILE
