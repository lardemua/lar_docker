# lar_docker

Useful dockerfiles and other docker related material

## Available Images

### ROS Noetic Distrobox

1. build ROS Noetic Distrobox

```
docker build -f ros-noetic-distrobox -t lardemua/ros-noetic-distrobox .
```

2. (optional) build image with nvidia support (cuda 11.8)

```
docker build -f cuda-11-8-ros-noetic-distrobox -t lardemua/cuda-ros-noetic-distrobox:11.8 .
```

3. create a distrobox

```
distrobox create --image lardemua/cuda-ros-noetic-distrobox:11.8 --name cuda-11-8-ros-noetic-distrobox --additional-flags "--runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all -e NVIDIA_DRIVER_CAPABILITIES=all" --home $HOME/cuda-11-8-ros-noetic-distrobox
```
