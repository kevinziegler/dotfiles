WORKING_DIR=$1;

echo $WORKING_DIR | sed "s:^$HOME:~:"
