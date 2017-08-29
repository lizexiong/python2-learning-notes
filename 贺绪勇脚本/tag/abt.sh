#!/bin/sh

#for c in 2 5 10 20; do
for c in 5 10; do
while read LINE
do
echo ab -t 20 -c $c "$LINE"
ab -t 20 -c $c "$LINE"
sleep 5s
done < tp.txt
done
