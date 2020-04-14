#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

build_cyclonedds="no"
while getopts ":hsc" opt; do
case ${opt} in
    s ) 
        echo "deprecated. building std_msgs by default now."
    ;;  
    c ) 
        build_cyclonedds="yes"
    ;;  
    h ) echo "options: [-c] build cyclone"
    exit
    ;;
esac
done

pushd $script_path  &> /dev/null
. /opt/ros/eloquent/setup.bash
echo "BUILD OPENDDS RMW"
./build_rmw.sh 
if [ $build_cyclonedds == "yes" ];then
    echo "BUILD CYCLONE"
    ./build_cyclone.sh
fi
rm ../src/common_interfaces/std_msgs/*_IGNORE
echo "BUILD STD MSGS"
./build_std_msgs.sh
echo "BUILD EXAMPLES"
./build_examples.sh 
popd  &> /dev/null
