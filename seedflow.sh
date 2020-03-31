#!/bin/bash
source ./my.env
SOURCE=$1
DEST=$2

if test -z "$SOURCE"
then
    echo "No source directory specified"
    exit 1
elif test -z "$DEST"
then
    echo "No destination directory specified"
    exit 1
fi

# Add check that promts if env variables are missing

echo "rsync -r $SF_REMOTEUSER@$SF_REMOTEHOST:$SF_REMOTEDIR/$SOURCE $SF_BASEPATH/dump"
rsync -r --progress $SF_REMOTEUSER@$SF_REMOTEHOST:$SF_REMOTEDIR/$SOURCE $SF_BASEPATH/dump

echo "deleting samples"
find $SF_BASEPATH/dump/$SOURCE -iname "Sample" -exec rm -rf {} \;
find $SF_BASEPATH/dump/$SOURCE -iname "Sample.???" -exec rm -rf {} \;

echo "extracting rar files"
find $SF_BASEPATH/dump/$SOURCE -iname '*.rar' -execdir unrar e {} -y \;

echo "deleting rar files"
find $SF_BASEPATH/dump/$SOURCE -iname '*.rar' -execdir rm -rf {} \;
find $SF_BASEPATH/dump/$SOURCE -iname '*.r[0-9][0-9]' -execdir rm -rf {} \;
aniconvert.py -r $SF_BASEPATH/dump/$SOURCE -o $DEST
rm -rf $SF_BASEPATH/dump/$SOURCE
