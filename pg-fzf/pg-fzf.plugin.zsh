pg-fzf-pgpass() {
    local PG_PASS=$HOME/.pgpass;

    local database=$( \
        awk -F ':' '{ print $3 }' $PG_PASS \
        | fzf --border --select-1 --query=$1 --prompt="Select a database: "
    );

    if (( !$+database )) && echo "Couldn't find a matching database" && return 1

    local host=$( \
        awk -F ':' \
            -v database=$database \
            '{ if ($3==database) { print $1 } }' \
            $PG_PASS \
        | fzf --select-1 --border --prompt="Select host: "
    );

    if (( !$+host )) && echo "Couldn't find a matching host" && return 1

    local user=$( \
        awk -F ':' \
            -v database=$database \
            -v host=$host \
            '{ if ($3==database && $1==host) { print $4 } }' \
            $PG_PASS \
        | fzf --select-1 --border --prompt="Select user: "
    );

    if (( !$+user )) && echo "Couldn't find a matching user" && return 1

    psql -h $host $database $user
}

pg-fzf-local() {
    local database=$( \
        psql --list -A -t \
        | grep "|" \
        | cut -d"|" -f1 \
        | fzf --border --select-1 --query=$1 --prompt="Select a database: "
    );

    if (( !$+database )) && echo "Couldn't find a matching database" && return 1

    psql $database
}

pg-fzf() {
    case $1 in
        "local"|"loc"|"l")
            echo "loading local"
            pg-fzf-local $2
            ;;
        "remote"|"rem"|"r")
            echo "loading remote"
            pg-fzf-pgpass $2
            ;;
        *)
    esac
}
