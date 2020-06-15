# ROS2/OpenDDS dev environment

It is possible to create development environments using tooling commonly available for Windows 10, macOS 10.14, Ubuntu Linux Bionic Beaver (18.04), and Ubuntu Xenial Xerus (16.04), and most recently Ubuntu Focal Fossa (20.04). See the ROS2 installation instructions using the latest release for more details.
**For now, development environment support will focus on using docker as instructed below.**

## Install Docker

1. Install docker
    * [https://docs.docker.com/install/linux/docker-ce/ubuntu/](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
    * [https://docs.docker.com/docker-for-mac/](https://docs.docker.com/docker-for-mac/)
    * [https://docs.docker.com/docker-for-windows/](https://docs.docker.com/docker-for-windows/)
2. Understand the docker command line [https://docs.docker.com/engine/reference/commandline/cli/](https://docs.docker.com/engine/reference/commandline/cli/)
3. Pull the docker build environment. Contains the latest OpenDDS (master) and currently ROS2 eloquent release.

```
docker pull objectcomputing/opendds_ros2
```

## Build

1. Create a workspace directory on the host filesystem (e.g. opendds\_rmw\_ws)
2. Clone `rmw_build` repo into directory from previous step

```
git clone https://github.com/oci-labs/rmw_build
```

3. Run docker to start build environment

```
docker run -it -v /host/path/to/workspace_directory:/opt/workspace objectcomputing/opendds_ros2 bash
```

4. In the docker container, make sure you’re in `/opt/workspace`

```
cd /opt/workspace
```

5. Create the workspace (pulls all necessary rmw and test repos) by running the following command in the container.

```
./rmw_build/create_workspace.sh
```

6. Build the workspace (builds only what we need)

```
./rmw_build/build_all.sh
```

## Testing

The new run\_test.sh script has several features

* Runs with gdb to capture call stack (i.e. bt) if the code fails
* Can run sub or pub from the same script
* Can run other RMW implementations such as the default FastRTPS
This test script does not replace the [system tests](https://github.com/ros2/system_tests.git) but is more for RMW developers to test and debug in various environments.

1. Get help on the `run_test.sh` script.

```
./rmw_build/run_test.sh -h
```

2. Run the publisher test (sources environment and executes the test publisher code using the OpenDDS RMW)

```
./rmw_build/run_test.sh
```

3. Run the subscriber test (sources environment and executes the test subscriber code using the OpenDDS RMW)

```
./rmw_build/run_test.sh -s
```

Note: Add `--ros-args --disable-rosout-logs` to the end of the `RMW_IMPLEMENTATION` line in `run_test.sh` to disable rosout logging

```
eval RMW_IMPLEMENTATION="$alt_rmw ros2 run --prefix '${gdb_cmd}' $run_test$executable_suffix --ros-args --disable-rosout-logs"
```

## Debugging

Good gdb references

* [https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)
* gdb help

```
(gdb) help
```

1. Run the test in breakpoint debug mode

```
./rmw_build/run_test.sh -b
```

2. Show current (aka present) working directory for relative file paths

```
(gdb) pwd
```

3. Set breakpoint in publisher code and run

* Show block of 10 lines centered on line 52

```
(gdb) list 52
```

* Set breakpoint at line 52

```
(gdb) b 52
```

* Run execution

```
(gdb) run
```

* After breakpoint is hit, execute next line

```
(gdb) next
```

4. Set breakpoint in `rmw_init` function from fresh run

* Run the code

```
(gdb) run
```

* Accept to restart execution if applicable

```
y
```

* List the code in source file `rmw_init.cpp` at function `rm_init`

```
(gdb) list src/rmw_opendds/rmw_opendds_cpp/src/rmw_init.cpp:rmw_init
```

* Set breakpoint in file `rmw_init.cpp` at first line of `rmw_init` function

```
(gdb) b src/rmw_opendds/rmw_opendds_cpp/src/rmw_init.cpp:rmw_init
```

* Run the code

```
(gdb) run
```

* Accept to restart execution if applicable

```
y
```

* Next until desired line

```
(gdb) next
```

* Backtrace (`bt`) Shows the call stack

```
(gdb) bt
```

5. Set breakpoint in `rmw_create_node` from fresh run

* Run the code

```
(gdb) run
```

* Accept to restart execution if applicable

```
y
```

* Show first line of function `rmw_create_node` in file `rmw_node.cpp`

```
(gdb) list src/rmw_opendds/rmw_opendds_cpp/src/rmw_node.cpp:rmw_create_node
```

* Set breakpoint on first line of `rmw_create_node` in file `rmw_node.cpp`

```
(gdb) b src/rmw_opendds/rmw_opendds_cpp/src/rmw_node.cpp:rmw_create_node
```

* To desired line of code

```
(gdb) run
y
(gdb) next
```

* To see the backtrace (`bt`) at that line of code

```
(gdb) bt
```

Edit files from `/host/path/to/workspace_directory` from your host OS using your favorite editor.
