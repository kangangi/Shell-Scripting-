#! /bin/bash

today=$(date +%Y%m%d)
weather_report=raw_data_$today

city=Nairobi
curl wttr.in/$city --output $weather_report
grep °C $weather_report > temperatures.txt
obs_tmp=$(head -1 temperatures.txt | tr -s " " | xargs | rev | cut -d " " -f2 | rev | sed 's/\x1b\[[0-9;]*m//g')
fc_temp=$(head -3 temperatures.txt | tail -1 | tr -s " " | xargs | cut -d "C" -f2 | rev | cut -d " " -f2 | rev | sed 's/\x1b\[[0-9;]*m//g')
hour=$(TZ='Kenya/Nairobi' date -u +%H)
day=$(TZ='Kenya/Nairobi' date -u +%d)
month=$(TZ='Kenya/Nairobi' date +%m)
year=$(TZ='Kenya/Nairobi' date +%Y)

record=$(echo -e "$year\t$month\t$day\t$hour\t$obs_tmp\t$fc_temp")
echo $record
echo $record>>rx_poc.log