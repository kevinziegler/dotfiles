WORKING_DIR=$1;

# Replace HOME with `~`, and truncate all other path segments to 1 character
TRUNCATED_PARENT=$( \
    dirname $WORKING_DIR \
    | sed "s:^$HOME:~:" \
    | awk -F'/' '{for (i=1; i<=NF; i++) printf substr($i, 1, 1) "/" }' \
);

printf "$TRUNCATED_PARENT$(basename $WORKING_DIR)";
# Truncate all path segments except the tail to 1 character
