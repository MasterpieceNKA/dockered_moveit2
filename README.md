# dockered_humble_moveit
Docker setup for MoveIt2 with ROS2 Humble for use in Windows

## Requirements
- [Visual Studio Code](https://code.visualstudio.com/) (tested)
- [Remote Development extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) in Visual Studio Code Marketplace.


### Note
This example setup has been tested on Windows 11. The official MoveIT2 Docker image works on Linux but not Windows. Thus, working with Windows OS requires building MoveIT2 from source code as done in this example. This example does not mount any volumes or GPUs.

## Getting Started

1. Clone the repository
    ```sh
    mkdir -p dockered_moveit2
    cd dockered_moveit2
    git clone https://github.com/MasterpieceNKA/dockered_moveit2.git
    ```

2. Reopen in Container



https://github.com/user-attachments/assets/8d09056a-3790-4e9a-9226-dc3e4273d62a



3. Test using MoveIT Tutorial Demos

a) Motion Planning Demo

    ```sh
    source ~/ws_moveit2/install/setup.bash \
        && ros2 launch moveit2_tutorials demo.launch.py
    ```
<img src="figures/fig_1.png" alt="Motion Planning Demo" style="width:900px;"/>



b) MoveIT Task Planner Pick and Place Demo

```sh
source ~/ws_moveit2/install/setup.bash && \
    ros2 launch moveit_task_constructor_demo demo.launch.py
```
Open new Terminal

```sh
source ~/ws_moveit2/install/setup.bash && \
    ros2 launch moveit_task_constructor_demo run.launch.py exe:=pick_place_demo
```

<img src="figures/fig_2.png" alt="MoveIT Task Planner Pick and Place Demo" style="width:900px;"/>


## Setup YouTube video guide

[![Setup YouTube video guide](http://i.ytimg.com/vi/Tmkmt4SZ_t8/hqdefault.jpg)](https://www.youtube.com/watch?v=Tmkmt4SZ_t8) 



4. Give the project a star :star_struck: :smiley: . Then Code away! Add your ROS2 source code in the ```/src``` folder, build, and run.
  



https://github.com/user-attachments/assets/10c6214d-6727-4a09-b441-4f1374dd469e






