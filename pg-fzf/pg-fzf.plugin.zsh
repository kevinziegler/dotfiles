pg-fzf() {
    local PG_PASS=$HOME/.pgpass;

    local database=$( \
        awk -F ':' '{ print $3 }' $PG_PASS \
        | fzf --border --select-1 --query=$1 --prompt="Select a database: "
    );

    [[ -v $database ]] && echo "Couldn't find a matching database" && exit

    local host=$( \
        awk -F ':' \
            -v database=$database \
            '{ if ($3==database) { print $1 } }' \
            $PG_PASS \
        | fzf --select-1 --border --prompt="Select host: "
    );

    [[ -v $host ]] && echo "Couldn't find a matching host" && exit

    local user=$( \
        awk -F ':' \
            -v database=$database \
            -v host=$host \
            '{ if ($3==database && $1==host) { print $4 } }' \
            $PG_PASS \
        | fzf --select-1 --border --prompt="Select user: "
    );

    [[ -v $user ]] && echo "Couldn't find a matching user" && exit

    psql -h $host $database $user
}
