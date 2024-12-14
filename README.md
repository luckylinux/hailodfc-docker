# hailodfc-docker
hailodfc Docker Image

# Setup
## Requirements

You need to first clone the Common https://github.com/luckylinux/container-build-tools somewhere in your System first, as I didn't want to over-complicate the Setup with git subtree or git submodule).

Then Symlink the Directory within this Repository to the "includes" Target:

```
git clone https://github.com/luckylinux/container-registry-tools
cd <yourcontainer>
ln -s /path/to/container-build-tools includes
```

## Build Image
You need to download the official Wheel from Hailo Developer Zone for the Hailo Dataflow Compiler.
This cannot be put in the Repository due to License Issues.

Similarly, you will need to build the Docker/Podman Image from Scratch.


## Usage
Put your Model in the `./models` Folder

Bring the Container up:
```
podman-compose up -d
```

Enter the Container Shell:
```
podman exec -it hailodfc-docker /bin/bash
```
