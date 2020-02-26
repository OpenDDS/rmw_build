#!/usr/bin/env bash
alt_rmw="rmw_opendds_cpp"
run_test="examples_rclcpp_minimal_publisher publisher_member_function"
while getopts ":ha:s" opt; do
case ${opt} in
    a ) 
        alt_rmw=$OPTARG
        echo "NOTE: For optional DDS implementations, only rmw_fastrtps_cpp is installed by default. All others require extra installation steps. https://index.ros.org/doc/ros2/Installation/DDS-Implementations/."
    ;;  
    s ) 
        run_test="examples_rclcpp_minimal_subscriber subscriber_member_function"
    ;;    
    h ) echo "options: [-s] switch to subscriber [-a] use alternate rmw (i.e. rmw_cyclonedds_cpp, rmw_fastrtps_cpp, or rmw_connext_cpp). For optional DDS implementations, only rmw_fastrtps_cpp is installed by default. All others require extra installation steps. https://index.ros.org/doc/ros2/Installation/DDS-Implementations/"
    exit
    ;;
esac
done
echo $alt_rmw
echo $run_test
 
which gdb
if [ $? == 1 ];then
    apt update
    apt install -y gdb
fi

script=`realpath $0`
script_path=`dirname $script`
pushd $script_path
pushd ..
. /opt/ros/eloquent/setup.bash
. install/local_setup.bash
RMW_IMPLEMENTATION=$alt_rmw ros2 run --prefix 'gdb -ex run --args' $run_test
popd 
popd
 