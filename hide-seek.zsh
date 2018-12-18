function _hide_and_seek_swap_files() {
    local source_file=$1;
    local target_file=$2;
    local action=$3;

    if ! [[ -e $source_file ]]; then
        echo "No such file $source_file exists.  Nothing to $action!";
        return;
    fi

    if [[ -e $target_file ]]; then
        echo "File already exists at $target_file.  Do you want to overwrite it?";
        read -q "HIDE_SEEK_FILE_REPLY?(y or n) > ";
        echo '\n';

        case $HIDE_SEEK_FILE_REPLY in
            n|no)
                echo "File $target_file exists; aborting...";
                return;
                ;;
            y|yes)
                echo "Overwriting existing $target_file with $source_file";
                ;;
        esac
    fi

    mv $source_file $target_file;

    case $action in
        'hide')
            echo "Hid $source_file at $target_file";
            ;;
        'seek')
            echo "Restored $target_file from $source_file";
            ;;
    esac
}

function hide_file() {
    local hidden_name="$1.hidden";
    _hide_and_seek_swap_files $1 $hidden_name 'hide'
}

function seek_file() {
    local hidden_name="$1.hidden";
    _hide_and_seek_swap_files $hidden_name $1 'seek'
}
