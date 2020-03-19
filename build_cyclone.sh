#!/usr/bin/env bash
script=`realpath $0`
script_path=`dirname $script`

alt_install_base="--symlink-install"
while getopts ":i:" opt; do
case ${opt} in 
    i )
        alt_install_base=" --install-base $OPTARG"
    ;;
    h ) echo "options: [-i] install base (alt to ./install)"
        exit
    ;;
esac
done

pushd $script_path &> /dev/null
pushd .. &> /dev/null
. /opt/ros/eloquent/setup.bash

dpkg -l ros-eloquent-cyclonedds &>/dev/null
if [ $? == 1 ];then
    apt update
    apt install -y ros-eloquent-cyclonedds
fi

colcon build $alt_install_base --cmake-args '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_BUILD_TYPE=Debug' --packages-up-to rmw_cyclonedds_cpp
popd &> /dev/null
popd &> /dev/null
