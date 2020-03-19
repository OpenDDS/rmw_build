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

dpkg -l ros-eloquent-test-msgs ros-eloquent-osrf-testing-tools-cpp ros-eloquent-launch-testing-ament-cmake &>/dev/null
if [ $? == 1 ];then
    apt update
    apt install -y ros-eloquent-test-msgs ros-eloquent-osrf-testing-tools-cpp ros-eloquent-launch-testing-ament-cmake
fi

pushd $script_path &> /dev/null
pushd .. &> /dev/null

read -r -s -p $'NOTICE: removing build to create clean build. Press enter to continue...\n'
rm -rf build

. /opt/ros/eloquent/setup.bash
echo $use
if [ $use == "opendds" ];then
    ./rmw_build/build_rmw.sh -i install_test_$use
fi
if [ $use == "cyclone" ];then
    ./rmw_build/build_cyclone.sh -i install_test_$use
fi
if [ $use != "fastrtps" ];then
    . install_test_$use/local_setup.bash
fi

colcon build --symlink-install --install-base install_test_$use --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to test_communication

popd &> /dev/null
popd &> /dev/null
