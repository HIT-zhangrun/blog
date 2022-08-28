### ROS环境配置
#### 一、ubuntu虚拟机和在树莓派上的安装
1. 目前ros版本更新到第2代，但目前学习来说用1代是很好的，所以安装第一代版本的ros
1. 硬件配置：虚拟机是自己的笔记本电脑，树莓派是4b，8G内存
1. ROS1的长期支持版本是Noetic，支持的ubuntu版本是20.04，所以版本一定注意，不然之后会安装不上。
1. 下载树莓派的官方烧录工具Pi imager，插入树莓派的系统内存卡到电脑上，选择other os中的ubuntu，进行烧录，这里选择的是20.04 64bit的server版本，之后再进行桌面UI的安装
1. 首次进入server系统需要使用默认的账号和密码：

账号：ubuntu
密码：ubuntu
之后系统会提示你进行修改密码

6. 树莓派可以使用有线网络连接并配置静态IP（方便后续用其他电脑进行SSH连接）
6. 这里使用的是树莓派的无线网络配置，sudo vi进入下图的文件进行编辑，这里对于缩进的格式很有讲究，都是4个空格，需要注意，编辑好之后，:wq保存退出![image.png](pic/netconfig.png)
6. 使用sudo netplan try，查看网络配置是否有问题，有问题需要对刚才的文件重新进行修改直到没有问题。
6. 没有问题直接sudo netplan apply，就可以连接网络了
6. 使用ifconfig（没安装需要安装这个工具包）查看当前wlan0的ip地址，看看是不是自己设置的静态ip
6. ping下百度，看看是否连接上外网
6. 安装openssh：sudo apt-get install openssh-server

开启ssh服务sudo service ssh start
检查是否成功开启服务ps -aux | grep ssh
查看ssh的服务处状态sudo service ssh status，如果出现以下错误，说明没有生成ssh的key
![IMG_20220622_111353.jpg](pic/ssh_status.jpg)
sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key进行生成
![IMG_20220622_111728.jpg](pic/generate_sshkey.jpg)
sudo service ssh restart重启服务
再次查看状态，无问题
![IMG_20220622_111906.jpg](pic/ssh_status_ok.jpg)

13. 使用window命令行对树莓派进行ssh连接：ssh ubuntu@192.168.31.102，按照提示输入yes和密码，就进入了树莓派的终端环境
13. 换源，这里使用的是中科大源[https://mirrors.ustc.edu.cn/help/ubuntu.html](https://mirrors.ustc.edu.cn/help/ubuntu.html)

将下面的复制粘贴到/etc/apt/sources.list
```c
# 默认注释了源码仓库，如有需要可自行取消注释
deb https://mirrors.ustc.edu.cn/ubuntu-ports/ focal main restricted universe multiverse
# deb-src https://mirrors.ustc.edu.cn/ubuntu-ports/ focal main main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-security main restricted universe multiverse
# deb-src https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.ustc.edu.cn/ubuntu-ports/ focal-proposed main restricted universe multiverse
```
一定要看好自己的系统是什么版本
![image.png](pic/system_info.png)

15. 安装桌面环境 apt-get install ubuntu-desktop
15. 安装windows远程桌面依赖

sudo apt-get install tightvncserver xrdp
连接时使用windows的远程桌面连接，输入ubuntu的ip地址，session选择Xorg，账号和密码选择ubuntu的账号和密码，连接就可以。
![image.png](pic/ubuntu_remote_desktop.png)
#### 二、安装ros1
可以参考官方的安装教程：
[http://wiki.ros.org/cn/noetic/Installation/Ubuntu](http://wiki.ros.org/cn/noetic/Installation/Ubuntu)

1. 设置软件源，这里使用中科大软件源

sudo sh -c '. /etc/lsb-release && echo "deb [http://mirrors.ustc.edu.cn/ros/ubuntu/](http://mirrors.ustc.edu.cn/ros/ubuntu/) `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'sudo sh -c './etc/lsb-release && echo "deb [http://mirrors.ustc.edu.cn/ros/ubuntu/](http://mirrors.ustc.edu.cn/ros/ubuntu/) `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'

2. 设置秘钥

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
![image.png](pic/set_key.png)

3. sudo apt update

![image.png](pic/update.png)

4. sudo apt install ros-noetic-desktop-full

![image.png](pic/install_ros.png)

5. 虚拟机和树莓派的两个系统都要安装ros

![image.png](pic/install_ros_ok.png)
安装成功的页面

6. source /opt/ros/noetic/setup.bash
6. 安装依赖sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
#### 三、配置工作环境

1. 创建工作区域

下面的命令可以创建一个空白的ros包工作空间：
mkdir -p ~/catkin_ws/src 
cd ~/catkin_ws/ 
catkin_make
空白工作空间的目录如下：
```c
.
├── build
│   ├── CATKIN_IGNORE
│   ├── CMakeCache.txt
│   ├── CMakeFiles
│   │   ├── 3.16.3
│   │   │   ├── CMakeCCompiler.cmake
│   │   │   ├── CMakeCXXCompiler.cmake
│   │   │   ├── CMakeDetermineCompilerABI_C.bin
│   │   │   ├── CMakeDetermineCompilerABI_CXX.bin
│   │   │   ├── CMakeSystem.cmake
│   │   │   ├── CompilerIdC
│   │   │   │   ├── CMakeCCompilerId.c
│   │   │   │   ├── a.out
│   │   │   │   └── tmp
│   │   │   └── CompilerIdCXX
│   │   │       ├── CMakeCXXCompilerId.cpp
│   │   │       ├── a.out
│   │   │       └── tmp
│   │   ├── CMakeDirectoryInformation.cmake
│   │   ├── CMakeError.log
│   │   ├── CMakeOutput.log
│   │   ├── CMakeRuleHashes.txt
│   │   ├── CMakeTmp
│   │   ├── Makefile.cmake
│   │   ├── Makefile2
│   │   ├── TargetDirectories.txt
│   │   ├── clean_test_results.dir
│   │   │   ├── DependInfo.cmake
│   │   │   ├── build.make
│   │   │   ├── cmake_clean.cmake
│   │   │   └── progress.make
│   │   ├── cmake.check_cache
│   │   ├── download_extra_data.dir
│   │   │   ├── DependInfo.cmake
│   │   │   ├── build.make
│   │   │   ├── cmake_clean.cmake
│   │   │   └── progress.make
│   │   ├── doxygen.dir
│   │   │   ├── DependInfo.cmake
│   │   │   ├── build.make
│   │   │   ├── cmake_clean.cmake
│   │   │   └── progress.make
│   │   ├── progress.marks
│   │   ├── run_tests.dir
│   │   │   ├── DependInfo.cmake
│   │   │   ├── build.make
│   │   │   ├── cmake_clean.cmake
│   │   │   └── progress.make
│   │   └── tests.dir
│   │       ├── DependInfo.cmake
│   │       ├── build.make
│   │       ├── cmake_clean.cmake
│   │       └── progress.make
│   ├── CTestConfiguration.ini
│   ├── CTestCustom.cmake
│   ├── CTestTestfile.cmake
│   ├── Makefile
│   ├── atomic_configure
│   │   ├── _setup_util.py
│   │   ├── env.sh
│   │   ├── local_setup.bash
│   │   ├── local_setup.sh
│   │   ├── local_setup.zsh
│   │   ├── setup.bash
│   │   ├── setup.sh
│   │   └── setup.zsh
│   ├── bin
│   ├── catkin
│   │   └── catkin_generated
│   │       └── version
│   │           └── package.cmake
│   ├── catkin_generated
│   │   ├── env_cached.sh
│   │   ├── generate_cached_setup.py
│   │   ├── installspace
│   │   │   ├── _setup_util.py
│   │   │   ├── env.sh
│   │   │   ├── local_setup.bash
│   │   │   ├── local_setup.sh
│   │   │   ├── local_setup.zsh
│   │   │   ├── setup.bash
│   │   │   ├── setup.sh
│   │   │   └── setup.zsh
│   │   ├── order_packages.cmake
│   │   ├── order_packages.py
│   │   ├── setup_cached.sh
│   │   └── stamps
│   │       └── Project
│   │           ├── _setup_util.py.stamp
│   │           ├── interrogate_setup_dot_py.py.stamp
│   │           ├── order_packages.cmake.em.stamp
│   │           └── package.xml.stamp
│   ├── catkin_make.cache
│   ├── cmake_install.cmake
│   ├── gtest
│   │   ├── CMakeFiles
│   │   │   ├── CMakeDirectoryInformation.cmake
│   │   │   └── progress.marks
│   │   ├── CTestTestfile.cmake
│   │   ├── Makefile
│   │   ├── cmake_install.cmake
│   │   ├── googlemock
│   │   │   ├── CMakeFiles
│   │   │   │   ├── CMakeDirectoryInformation.cmake
│   │   │   │   ├── gmock.dir
│   │   │   │   │   ├── DependInfo.cmake
│   │   │   │   │   ├── build.make
│   │   │   │   │   ├── cmake_clean.cmake
│   │   │   │   │   ├── depend.make
│   │   │   │   │   ├── flags.make
│   │   │   │   │   ├── link.txt
│   │   │   │   │   ├── progress.make
│   │   │   │   │   └── src
│   │   │   │   ├── gmock_main.dir
│   │   │   │   │   ├── DependInfo.cmake
│   │   │   │   │   ├── build.make
│   │   │   │   │   ├── cmake_clean.cmake
│   │   │   │   │   ├── depend.make
│   │   │   │   │   ├── flags.make
│   │   │   │   │   ├── link.txt
│   │   │   │   │   ├── progress.make
│   │   │   │   │   └── src
│   │   │   │   └── progress.marks
│   │   │   ├── CTestTestfile.cmake
│   │   │   ├── Makefile
│   │   │   └── cmake_install.cmake
│   │   ├── googletest
│   │   │   ├── CMakeFiles
│   │   │   │   ├── CMakeDirectoryInformation.cmake
│   │   │   │   ├── gtest.dir
│   │   │   │   │   ├── DependInfo.cmake
│   │   │   │   │   ├── build.make
│   │   │   │   │   ├── cmake_clean.cmake
│   │   │   │   │   ├── depend.make
│   │   │   │   │   ├── flags.make
│   │   │   │   │   ├── link.txt
│   │   │   │   │   ├── progress.make
│   │   │   │   │   └── src
│   │   │   │   ├── gtest_main.dir
│   │   │   │   │   ├── DependInfo.cmake
│   │   │   │   │   ├── build.make
│   │   │   │   │   ├── cmake_clean.cmake
│   │   │   │   │   ├── depend.make
│   │   │   │   │   ├── flags.make
│   │   │   │   │   ├── link.txt
│   │   │   │   │   ├── progress.make
│   │   │   │   │   └── src
│   │   │   │   └── progress.marks
│   │   │   ├── CTestTestfile.cmake
│   │   │   ├── Makefile
│   │   │   └── cmake_install.cmake
│   │   └── lib
│   └── test_results
├── devel
│   ├── _setup_util.py
│   ├── cmake.lock
│   ├── env.sh
│   ├── lib
│   ├── local_setup.bash
│   ├── local_setup.sh
│   ├── local_setup.zsh
│   ├── setup.bash
│   ├── setup.sh
│   └── setup.zsh
└── src
    └── CMakeLists.txt -> /opt/ros/noetic/share/catkin/cmake/toplevel.cmake
```
