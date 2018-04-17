#!/bin/sh

# Fills up the given file to be an image of a complete 1.44 MByte floppy

if [ "$#" -ne 1 ]; then
    echo "Usage $0 <filename>"
    exit 1
fi

# determine the number of bytes currently in the floppy image
currentsize=$(($(wc -c < "$1")))
if [ "$currentsize" -lt 513 ]; then
    echo "The floppy image $1 must be at least 513 bytes in size"
    exit 2
fi
# calculate the number of bytes in the last sector of the floppy image
secfillsize=$(($currentsize % 512))
# calculate the number of bytes to fill to a sector boundary
secfillsount=$((512 - $secfillsize))

# if there is something to fill, fill it to the next sector boundary
if [ "$secfillsize" -ne 0 ]; then
    dd if=/dev/zero of="$1" seek=$currentsize bs=1 count=$secfillsount conv=notrunc status=none
fi

# determine the number of sectors the image has currently
floppysecs=$(($(wc -c < "$1") / 512))

# insert the number of sectors to read to the boot sector
printf "$(printf '\\%03o' $(($floppysecs - 1)))" | dd of="$1" bs=1 seek=509 count=1 conv=notrunc status=none

# calculate the number of sectors that have to be written to have a full floppy image
fillsecs=$((2880 - $floppysecs))

# fill the floppy image
dd if=/dev/zero of="$1" seek=$floppysecs bs=512 count=$fillsecs conv=notrunc status=none
