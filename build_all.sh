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

export PATH=/usr/lib/ccache:$PATH
. /opt/ros/eloquent/setup.bash

pushd $script_path  &> /dev/null
if [ $build_cyclonedds == "yes" ];then
    echo "BUILD CYCLONE"
    ./build_cyclone.sh
    . ../install/local_setup.bash
fi

pushd .. &> /dev/null
echo "BUILD ALL"
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rmw_opendds_cpp  
. install/local_setup.bash
colcon build --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rcl_interfaces examples_rclcpp_minimal_publisher examples_rclcpp_minimal_subscriber 

popd &> /dev/null
popd &> /dev/null
