#!/bin/sh
sed -e 's/ \([0-9]\)/ 0\1/g' action | sed -e 's/ 0\([0-9][0-9]\)/ \1/g' > action_cbl
echo "ok"
