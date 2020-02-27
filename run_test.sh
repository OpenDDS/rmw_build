#!/usr/bin/env bash
alt_rmw="rmw_opendds_cpp"
run_test="examples_rclcpp_minimal_publisher publisher_member_function"
gdb_cmd="gdb -ex run --args"

while getopts ":ha:sb" opt; do
case ${opt} in
    a ) 
        alt_rmw=$OPTARG
        echo "NOTE: For optional DDS implementations, only rmw_fastrtps_cpp is installed by default. All others require extra installation steps. https://index.ros.org/doc/ros2/Installation/DDS-Implementations/."
    ;;  
    s ) 
        run_test="examples_rclcpp_minimal_subscriber subscriber_member_function"
    ;;    
    b )
        gdb_cmd="gdb --args"
    ;;
    h ) echo "options: [-s] switch to subscriber [-a] use alternate rmw (i.e. rmw_cyclonedds_cpp, rmw_fastrtps_cpp, or rmw_connext_cpp). [-b] breakpoint debugging"
    exit
    ;;
esac
done
 
which gdb &> /dev/null
if [ $? == 1 ];then
    apt update
    apt install -y gdb
fi

script=`realpath $0`
script_path=`dirname $script`
pushd $script_path &> /dev/null
pushd .. &> /dev/null
. /opt/ros/eloquent/setup.bash
. install/local_setup.bash
eval RMW_IMPLEMENTATION="$alt_rmw ros2 run --prefix '${gdb_cmd}' $run_test"
popd &> /dev/null
popd &> /dev/null
 