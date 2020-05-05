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

pushd $script_path &> /dev/null
pushd .. &> /dev/null

while true; do
    read -p "Remove build directory to prevent build contanimation?" yn
    case $yn in
        [Yy]* ) rm -rf build; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

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

colcon build --install-base install_test_$use --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rcl_interfaces test_communication

popd &> /dev/null
popd &> /dev/null
