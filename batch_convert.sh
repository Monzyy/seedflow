#!/bin/bash
jobs=convertlist.txt

while [[ $(head -n 1 $jobs) ]]
do
  job=$(head -n 1 $jobs)
  job=($job)
  jobname=${job[0]}
  jobpath=${job[1]}
  #./AniConvert/aniconvert.py -r $jobpath/$jobname -o $jobpath
  #rm -rf $jobpath/$jobname
  sed -i.bak '1d' $jobs
  echo $jobname
  echo $jobpath
done