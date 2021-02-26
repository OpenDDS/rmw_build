#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

use="opendds"
tests="test_communication"
while getopts ":hcfa" opt; do
case ${opt} in
    c )
        use="cyclone"
    ;;
    f )
        use="fastrtps"
    ;;
    a )
        tests="rcl_interfaces test_communication test_quality_of_service test_rclcpp test_security"
    ;;
    h ) printf "options:\n [-c] use cyclone dds\n [-f] use fastrtps\n [-a] build all tests\n"
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

colcon build --symlink-install --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to $tests
