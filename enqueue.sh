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

echo "rsync -r $SF_REMOTEUSER@$SF_REMOTEHOST:$SF_REMOTEDIR/$SOURCE $DEST"
rsync -r --progress $SF_REMOTEUSER@$SF_REMOTEHOST:$SF_REMOTEDIR/$SOURCE $DEST

echo "deleting samples"
find $DEST/$SOURCE -iname "Sample" -exec rm -rf {} \;
find $DEST/$SOURCE -iname "Sample.???" -exec rm -rf {} \;

echo "extracting rar files"
find $DEST/$SOURCE -iname '*.rar' -execdir unrar e {} -y \;

echo "deleting rar files"
find $DEST/$SOURCE -iname '*.rar' -execdir rm -rf {} \;
find $DEST/$SOURCE -iname '*.r[0-9][0-9]' -execdir rm -rf {} \;

echo "adding file to convert queue"
echo "${SOURCE} ${DEST}" > convertlist.txt
