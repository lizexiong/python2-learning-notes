#!/bin/sh

#for c in 2 5 10 20; do
for c in 5 10; do
while read LINE
do
echo webbench -t 30 -c $c "$LINE"
webbench -t 30 -c $c "$LINE"
sleep 10s
done < tp.txt
done
