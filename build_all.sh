#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

build_std_msgs="no"
while getopts ":hs" opt; do
case ${opt} in
    s ) 
        build_std_msgs="yes"
    ;;  
    h ) echo "options: [-s] build std_msgs"
    exit
    ;;
esac
done

pushd $script_path  &> /dev/null
. /opt/ros/eloquent/setup.bash
echo "BUILD OPENDDS RMW"
./build_rmw.sh 
echo "BUILD CYCLONE"
./build_cyclone.sh
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
