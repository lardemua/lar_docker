# ROS Noetic Distrobox

Build image:

```
docker build -f ros-noetic.Dockerfile -t lardemua/ros-distrobox:noetic .
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
./user-setup.bash
```

