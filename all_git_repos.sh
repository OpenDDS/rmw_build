#!/usr/bin/env bash
TXTGRN=$(tput setaf 2) # Green
TXTRST=$(tput sgr0) # Text reset.

script_path=`dirname $0`

gitcommand=""
pipe=""
while getopts ":spbBSH" opt; do
case ${opt} in
    s )
        gitcommand="status -s"
    ;;
    p )
        gitcommand="remote -v"
    ;;
    b )
        gitcommand="branch -a"
    ;;
    B )
        gitcommand="branch -a"
        pipe="|grep \*"
    ;;
    S )
        gitcommand="show -s"
    ;;
    H )
        gitcommand="show -s"
        pipe="|grep -B 1 commit"
    ;;
    r )
        gitcommand="log --reverse --oneline"
    ;;
    ? )
        echo "options: [-s] (status) [-p] (paths) [-b] (branches) [-B] (current branch) [-S] (show) [-H] (show hashes) [-r] (log reverse)"
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
    eval git $gitcommand$pipe
    popd &>/dev/null
done

popd &> /dev/null
popd &> /dev/null
