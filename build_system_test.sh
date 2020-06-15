#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

use="opendds"

while getopts ":hcf" opt; do
case ${opt} in
    c )
        use="cyclone"
    ;;
    f )
        use="fastrtps"
    ;;
    h ) echo "options: [-c] use cyclone dds [-f] use fastrtps"
    exit
    ;;
esac
done

. /opt/ros/foxy/setup.bash
echo $use
if [ $use == "opendds" ];then
    ./rmw_build/build_rmw.sh
fi
if [ $use == "cyclone" ];then
    ./rmw_build/build_cyclone.sh
fi
if [ $use != "fastrtps" ];then
    . install/local_setup.bash
fi

colcon build --symlink-install --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rcl_interfaces test_communication
