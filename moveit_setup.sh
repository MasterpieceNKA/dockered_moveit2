#!/bin/bash 

# Setup MoveIT
# https://moveit.picknik.ai/main/doc/tutorials/getting_started/getting_started.html
rosdep update
sudo apt update
sudo apt dist-upgrade

colcon mixin add default https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml
colcon mixin update default

export COLCON_WS=~/ws_moveit2
mkdir -p $COLCON_WS/src

# Setup MoveIT
cd $COLCON_WS/src
git clone --recursive https://github.com/moveit/moveit2.git -b $ROS_DISTRO
for repo in moveit2/moveit2.repos $(f="moveit2/moveit2_$ROS_DISTRO.repos"; test -r $f && echo $f); do vcs import < "$repo"; done
rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

cd $COLCON_WS
#colcon build --mixin release --event-handlers desktop_notification- status-  --executor sequential --cmake-args -DCMAKE_BUILD_TYPE=Release
colcon build --executor sequential --cmake-args -DCMAKE_BUILD_TYPE=Release

# Setup moveit task constructor
cd $COLCON_WS/src
git clone --recursive -b ros2 https://github.com/moveit/moveit_task_constructor.git
rosdep install -r --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y

cd $COLCON_WS
colcon build --executor sequential --cmake-args -DCMAKE_BUILD_TYPE=Release

echo "source $COLCON_WS/install/setup.bash" >> ~/.bashrc
