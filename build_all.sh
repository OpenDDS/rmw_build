#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

build_cyclonedds="no"
while getopts ":hc" opt; do
case ${opt} in
    c ) 
        build_cyclonedds="yes"
    ;;  
    h ) echo "options: [-c] build cyclone"
    exit
    ;;
esac
done

dpkg -l ccache &>/dev/null
if [ $? == 1 ];then
    apt update
    apt install -y ccache
fi
export PATH=/usr/lib/ccache:$PATH

pushd $script_path  &> /dev/null
echo "BUILD OPENDDS RMW"
./build_rmw.sh 
if [ $build_cyclonedds == "yes" ];then
    echo "BUILD CYCLONE"
    ./build_cyclone.sh
fi
echo "BUILD EXAMPLES"
./build_examples.sh 
popd  &> /dev/null
