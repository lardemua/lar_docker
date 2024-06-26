#!/bin/bash

# ROS Noetic configuration
echo "" >> ~/.bashrc
echo "# ROS" >> ~/.bashrc
source /opt/ros/noetic/setup.bash
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
rosdep update

# Set up Catkin Workspace
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws && catkin_make
source ~/catkin_ws/devel/setup.bash
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
echo "export PYTHONPATH=~/catkin_ws/src:\$PYTHONPATH" >> ~/.bashrc

# Avoid roscore using all the RAM with distrobox
echo "" >> ~/.bashrc
echo "# Avoid roscore using all the RAM" >> ~/.bashrc
echo "ulimit -Sn 524288" >> ~/.bashrc
echo "ulimit -Hn 524288" >> ~/.bashrc

# Make sure Python accesses user packages
echo "" >> ~/.bashrc
echo "export PYTHONPATH=~/.local/lib/python3.8/site-packages:\$PYTHONPATH" >> ~/.bashrc

# Source .bashrc
source ~/.bashrc
