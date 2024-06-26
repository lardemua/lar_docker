# lar_docker

Useful dockerfiles and other docker related material

## Available Images

### ROS Noetic Distrobox

Build image:

```
docker build -f ros-noetic-distrobox -t lardemua/ros-distrobox:noetic .
```

Create a distrobox:

```
SHELL=/bin/bash distrobox create --image lardemua/ros-distrobox:noetic --name ros-distrobox --additional-flags "--gpus all" --home $HOME/ros-distrobox
```

Enter the created distrobox:

```
distrobox enter ros-distrobox
```

Set up ROS for your user:

```
/user-setup.sh
```

### ROS Noetic Distrobox with Cuda 11.8

Build image:

```
docker build -f ros-noetic-cuda-11-8-distrobox -t lardemua/ros-cuda-distrobox:noetic-11.8 .
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
/user-setup.sh
```
