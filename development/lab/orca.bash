# A simple wrapper around git for managing Orbit configuration repositories
orca() {
    if [ $# -eq 0 ]; then
        echo "Orca is a simple wrapper around git for Orbit configurations."
    elif [ $# -eq 1 ]; then
        echo "$HOME/.orbit/plugins/$1"
    else
        git -C $HOME/.orbit/plugins/$1 "${@:2}"
    fi
}
