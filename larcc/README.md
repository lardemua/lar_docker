# LARCC

Build image:

```
docker build -f larcc.Dockerfile -t lardemua/larcc:noetic-11.8 .
```

Create a distrobox:

```
SHELL=/bin/bash distrobox create --image lardemua/larcc-distrobox:noetic-11.8 --name larcc-distrobox --additional-flags "--gpus all" --home $HOME/larcc-distrobox
```

Enter the created distrobox:

```
distrobox enter larcc-distrobox
```

Set up ROS for your user:

```
./user-setup.bash
```

