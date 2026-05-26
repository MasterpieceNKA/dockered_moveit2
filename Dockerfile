FROM osrf/ros:jazzy-desktop-full

# Add ubuntu user with same UID and GID as your host system, if it doesn't already exist
# Since Ubuntu 24.04, a non-root user is created by default with the name vscode and UID=1000
ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN if ! id -u $USER_UID >/dev/null 2>&1; then \
        groupadd --gid $USER_GID $USERNAME && \
        useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME; \
    fi
# Add sudo support for the non-root user
RUN apt-get update && \
    apt-get install -y sudo && \
    echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Switch from root to user
USER $USERNAME

# Add user to video group to allow access to webcam
RUN sudo usermod --append --groups video $USERNAME

# Update all packages
RUN sudo apt update && sudo apt dist-upgrade -y && sudo apt upgrade -y

# Install Git
RUN sudo apt install -y \
    nano \
    ntp \
    ros-jazzy-rmw-cyclonedds-cpp \
    wget    

# Update all packages
RUN sudo apt update && sudo apt upgrade -y

# Rosdep update
RUN rosdep update

# Source the ROS setup file
RUN echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> ~/.bashrc
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

# Install MoveIT
RUN sudo apt install -y \
    ros-jazzy-moveit \
    ros-jazzy-moveit-task-constructor-capabilities \
    ros-jazzy-moveit-task-constructor-core \
    ros-jazzy-moveit-task-constructor-demo \
    ros-jazzy-moveit-task-constructor-msgs \
    ros-jazzy-moveit-task-constructor-visualization

#ARG MTC_SETUP=./moveit2_task_constructor_setup.sh
#RUN sudo wget \
#    "https://gist.githubusercontent.com/MasterpieceNKA/1666e6cbc93732b2028fdccbbbc571e1/raw/0dd41d02f72af473b103101b19d37ffd7fcbd43b/setup_moveit2_task_constructor.sh" \
#    -O $MTC_SETUP
#RUN sudo chmod +x $MTC_SETUP
#RUN sudo chown $USERNAME $MTC_SETUP
#RUN $MTC_SETUP

################################
## ADD ANY CUSTOM SETUP BELOW ##
################################
#COPY entrypoint.sh /entrypoint.sh
RUN sudo wget \
    "https://gist.githubusercontent.com/MasterpieceNKA/1d8fd9ddc2e9d7bad3aa0102667fd7cd/raw/382864564948d72d81318173f614c31e2993183d/docker_ros2_entrypoint.sh" \
    -O /docker_ros2_entrypoint.sh
ENTRYPOINT ["/bin/bash", "/docker_ros2_entrypoint.sh"] 
CMD ["bash"] 

