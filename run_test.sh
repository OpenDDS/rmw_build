#!/usr/bin/env bash
alt_rmw="rmw_opendds_cpp"
run_test="examples_rclcpp_minimal_publisher publisher_member_function"
gdb_cmd="gdb -ex run --args"
executable_suffix=""

while getopts ":ha:sbe:cS" opt; do
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
    e )
        executable_suffix=$OPTARG
    ;;
    c )
        run_test="examples_rclcpp_minimal_client client_main"
    ;;
    S ) run_test="examples_rclcpp_minimal_service service_main"
    ;;
    h ) echo "options: [-s] switch to subscriber [-a] use alternate rmw (i.e. rmw_cyclonedds_cpp, rmw_fastrtps_cpp, or rmw_connext_cpp). [-b] breakpoint debugging [-e] run executable suffix such as \"_instrumented\" or \"_no_param_services\" [-c] run client [-S] run server"
    exit
    ;;
esac
done

script=`realpath $0`
script_path=`dirname $script`
pushd $script_path &> /dev/null
pushd .. &> /dev/null
. /opt/ros/eloquent/setup.bash
. install/local_setup.bash

eval RMW_IMPLEMENTATION="$alt_rmw ros2 run --prefix '${gdb_cmd}' $run_test$executable_suffix"
popd &> /dev/null
popd &> /dev/null
 