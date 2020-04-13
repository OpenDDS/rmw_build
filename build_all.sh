#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

build_std_msgs="no"
build_cyclonedds="no"
while getopts ":hsc" opt; do
case ${opt} in
    s ) 
        build_std_msgs="yes"
    ;;  
    c ) 
        build_cyclonedds="yes"
    ;;  
    h ) echo "options: [-s] build std_msgs [-c] build cyclone"
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
if [ $build_std_msgs == "yes" ];then
    rm ../src/common_interfaces/std_msgs/*_IGNORE
    echo "BUILD STD MSGS"
    ./build_std_msgs.sh
else
    touch ../src/common_interfaces/std_msgs/AMENT_IGNORE
    touch ../src/common_interfaces/std_msgs/COLCON_IGNORE
fi
echo "BUILD EXAMPLES"
./build_examples.sh 
popd  &> /dev/null
