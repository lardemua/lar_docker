# ROS Noetic Distrobox with Cuda 11.8

Build image:

```
docker build -f ros-noetic-cuda-11-8.Dockerfile -t lardemua/ros-cuda-distrobox:noetic-11.8 .
```

Create a distrobox:

```
SHELL=/bin/bash distrobox create --image lardemua/ros-cuda-distrobox:noetic-11.8 --name ros-cuda-distrobox --additional-flags "--gpus all" --home $HOME/ros-cuda-distrobox
```

Enter the created distrobox:

```
distrobox enter ros-cuda-distrobox
```

Set up ROS for your user:

```
./user-setup.bash
```
