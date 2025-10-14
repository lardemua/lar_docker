# Use distrobox image with ROS Noetic with CUDA 11.8 as base
FROM lardemua/ros-cuda-distrobox:noetic-11.8

# Set shell for better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install system packages and ROS dependencies in a single layer
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    # System tools
    vim \
    gnupg \
    git \
    socat \
    # Video4Linux dependencies
    libv4l-dev \
    v4l-utils \
    # Astra camera dependencies
    libgflags-dev \
    libgoogle-glog-dev \
    libusb-1.0-0-dev \
    libeigen3-dev \
    # Additional system libraries
    libpcap-dev \
    libfreenect-dev \
    # ROS packages (consolidated and deduplicated)
    ros-noetic-moveit \
    ros-noetic-industrial-robot-status-interface \
    ros-noetic-scaled-controllers \
    ros-noetic-pass-through-controllers \
    ros-noetic-ur-client-library \
    ros-noetic-ur-msgs \
    ros-noetic-velocity-controllers \
    ros-noetic-force-torque-sensor-controller \
    ros-noetic-image-geometry \
    ros-noetic-camera-info-manager \
    ros-noetic-image-transport \
    ros-noetic-image-publisher \
    ros-noetic-usb-cam \
    ros-noetic-velodyne-description \
    ros-noetic-velodyne-gazebo-plugins \
    ros-noetic-backward-ros \
    ros-noetic-rgbd-launch \
    ros-noetic-octomap-* \
    ros-noetic-smach-ros && \
    # Clean up apt cache to reduce image size
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Build and install libuvc
RUN git clone https://github.com/libuvc/libuvc.git && \
    mkdir -p /libuvc/build && \
    cd /libuvc/build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig && \
    cd / && \
    rm -rf /libuvc/

# Install Python dependencies
RUN pip install --no-cache-dir \
    tensorflow[and-cuda] \
    mediapipe \
    scikit-learn \
    matplotlib \
    opencv-python \
    numpy==1.23.5 \
    protobuf==3.20.3 \
    tabulate \
    pyfiglet \
    torchvision

# Clone ROS repositories
RUN source /opt/ros/noetic/setup.bash && \
    mkdir -p /root/larcc_ws/src && \
    cd /root/larcc_ws/src && \
    git clone https://github.com/lardemua/universal_robot.git && \
    git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git && \
    git clone https://github.com/ros-industrial/ur_msgs.git -b noetic-devel && \
    git clone https://github.com/ros-industrial/robotiq.git && \
    git clone https://github.com/orbbec/ros_astra_camera.git && \
    git clone https://github.com/ros-drivers/velodyne.git -b master && \
    git clone https://github.com/tu-darmstadt-ros-pkg/hector_models.git && \
    git clone https://github.com/ros-drivers/freenect_stack.git && \
    git clone https://github.com/ros-drivers/usb_cam.git -b develop && \
    git clone https://github.com/lardemua/atom.git && \
    # Remove unwanted robotiq packages
    rm -rf robotiq/robotiq_2f_gripper_action_server \
    robotiq/robotiq_2f_gripper_control \
    robotiq/robotiq_3f_gripper_articulated_gazebo_plugins \
    robotiq/robotiq_3f_gripper_control \
    robotiq/robotiq_3f_gripper_joint_state_publisher \
    robotiq/robotiq_3f_rviz \
    robotiq/robotiq_ethercat

# Build the catkin workspace
RUN source /opt/ros/noetic/setup.bash && \
    cd /root/larcc_ws && \
    catkin_make
