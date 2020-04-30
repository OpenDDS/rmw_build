#!/usr/bin/env bash
TXTGRN=$(tput setaf 2) # Green
TXTRST=$(tput sgr0) # Text reset.

script_path=`dirname $0`

command=""
pipe=""
while getopts ":spbSHh" opt; do
case ${opt} in 
    s )
        command="status -s"
    ;;
    p )
        command="remote -v"
    ;;
    b )
        command="branch -a"
    ;;
    S )
        command="show -s"
    ;;
    H )
        command="show -s"
        pipe="|grep -B 1 commit"
    ;;
    h )
        echo "options: [-s] (status) [-p] (paths) [-b] (branches) [-S] (show) [-H] (show hashes)"
        exit
    ;;
esac
done

pushd $script_path &> /dev/null
pushd .. &> /dev/null

findgit=$(find . -name ".git"|sort)
for x in $findgit; do
    pushd $(dirname $x) &>/dev/null
    echo -e "${TXTGRN}$(basename $(dirname $x))${TXTRST}"
    eval git $command$pipe
    popd &>/dev/null
done

popd &> /dev/null
popd &> /dev/null
