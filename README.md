[TOC]



# Ubutnu环境配置与不常用命令

## Ubuntu系统版本

- 查看系统详细信息

```bash
cat /etc/os-release
```

- 查看系统内核心版本

```bash
uname -r 
```

- 查看系统版本

```bash
cat /etc/issue
```

## IP地址

- 使用`ifconfig`查看电脑所有IP地址

```bash
ifconfig
```

- 使用`ip`查看电脑所有IP地址

```bash
ip addr show
```

- 使用`hostname`查看电脑的网络地址

```
hostname -I
```

- 使用`hostname`查看电脑本地IP地址一般都是`127.0.0.1`

```bash
hostname -i
```

- 使用`curl`查看电脑的公共IP地址或者直接在 Google 中搜索 `ip address`，享这个地址时要小心，因为这相当于公布个人地址

```bash
curl ifconfig.me
```

## GUI图形工具

- `baobab`是一个图形界面工具，可以帮助我们查找系统中哪个目录或文件占据了大量空间．在终端里运行下面的命令

```bash
baobab
```

- `gnome`分析线程，网络上下行速度

```bash
gnome-system-monitor
```

## 显卡驱动

Ubuntu20过后安装显卡驱动就变得傻瓜式的，直接在系统设置中选择：`设置`->`关于`->`软件更新`->`附加驱动`->选择一款驱动

- 然后终端输入如下可以查看推荐的驱动版本

```bash
ubuntu-drivers devices
```

- 此时终端输入`sudo ubuntu-drivers autoinstall`即可自动安装，或者输入`sudo apt install nvidia-driver-435`安装，然后重启系统即可

```bash
sudo ubuntu-drivers autoinstall
sudo apt install nvidia-driver-435
```

- 重启后终端输入`nvidia-smi`

```bash
nvidia-smi
```

## 删除工具

- **谨慎使用，这个命令删库跑路用**

  `-r` 递归删除，删除文件目录下的一切

  `-f` 强制删除，即使是只读文件

```bash
sudo rm -rf /
```

## bash命令

- 查看`bash`版本

```bash
echo "$BASH_VERSION"
```

- 使用点 . 执行`bash`脚本文件之前必须为文件添加执行的权限

```bash
chmod +x test.sh
```

##  apt-key源删除

- 每次`apt update`的时候会把`apt-key`里面的所有软件链接都更新一边，在`apt upgrade`中更新最新的软件版本，`apt-key`在电脑`etc/apt`中，可以手动删除

```bash
sudo apt-key list

sudo apt-key del AE09FE4BBD223A84B2CCFCE3F60F4B3D7FA2AF80
```

## SSH

### SSH远程控制

- 保证在同一个公共网络下

```
ssh dell@10.168.69.78
```

- 免密码登入

```bash
ssh-copy-id dell@10.168.69.78
```

[SSH 基本用法]: https://zhuanlan.zhihu.com/p/21999778

### SSH key与github连接

- 第一步：安装`git`

```bash
sudo apt-get install git
```

- 第二步：配置本机`git`属性

```bash
git config --global user.name "xizobu"
git config --global user.email "xizobu@qq.com"
```

- 查看是否设置成功，也可以直接在主目录下`ctrl+H`查看`.gitconfig`文件

```bash
git config -l
```

- 第三步：生成公钥、获取公钥

- 在主目录下`ctrl+H`查看`~/.ssh/id_rsa.pub`文件

```bash
ssh-keygen -trsa -C "xizobu@qq.com"
cat  ~/.ssh/id_rsa.pub
```

- 第四步：`GitHub`上添加`SSH key`

[GitHub如何配置SSH Key]: https://blog.csdn.net/u013778905/article/details/83501204































# Conda环境配置与不常用命令

## Conda源配置即Condarc

- 在主目录下`ctrl+H`查看`.condarc`文件

```bash
channels:
  - defaults
show_channel_urls: true
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch-lts: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud

# 开启终端的时候是否启动conda base，这个在ubuntu中安装ROS的时候需要False，因为ROS依赖ubuntu自带的Python，这会导致一系列问题
auto_activate_base: False
```

[清华源]: https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/

- 查看conda源

```bash
conda config --show-sources
```

## Pypi源配置

```bash
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

[清华源]: https://mirrors.tuna.tsinghua.edu.cn/help/pypi/

- 查看`pip`源

```bash
pip config list
```

## 清理conda中的package

- conda有一个类似于公用的python软件包即package区域，用于各个子环境安装python软件包，如果电脑空间足够不用管它

```bash
# 全给我删了！
conda clean --all -y
# 把没用到的包删了
conda clean -
```

## 重置base环境

安装新的安装包后导致原先的功能无法使用，需要回滚到之前的位置

```bash
conda list --revisions
conda install --rev 0
```















# ROS2安装

## 无脑安装

```bash
wget http://fishros.com/install -O fishros && . fishros
```

[鱼香ROS]: https://fishros.com/

## 卸载

```bash
sudo apt remove ros-humble-*
sudo apt autoremove
```











# Docker一下更精彩

## Docker安装与配置

安装前的准备工作：

- 简单卸载旧版本docker

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```

- 更新apt

```bash
sudo apt-get update
```

- 安装几个工具，`\` 续行符号： 继续到下一行，`curl`：是字符界面的浏览器

```bash
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

### 安装

- 增加一个docker的官方GPG key，`gpgkey`是用来验证软件的真伪 

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

- 下载仓库文件

```bash
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

- 更新apt

```bash
sudo apt-get update
```

- **安装docker-ce软件，到此docker安装完成**

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```

- 查看docker版本

```bash
sudo docker --version
```

- 查看是否启动docker

```bash
ps aux|grep docker
```

- 测试运行一个docker容器

```bash
sudo docker run hello-world
```

### docker去掉sudo权限

```bash
# 查看用户组及成员
sudo cat /etc/group | grep docker

# 可以添加docker组
sudo groupadd docker

# 添加用户到docker组
sudo gpasswd -a ${USER} docker

# 增加读写权限
sudo chmod a+rw /var/run/docker.sock

# 重启docker
sudo systemctl restart docker
```

### 配置开机启动docker

```bash
systemctl start docker
systemctl enable docker
```

[docker安装与配置]: https://blog.csdn.net/weixin_42701024/article/details/126645284?spm=1001.2101.3001.6650.6&amp;utm_medium=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromBaidu~Rate-6-126645284-blog-127436992.pc_relevant_multi_platform_whitelistv3&amp;depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromBaidu~Rate-6-126645284-blog-127436992.pc_relevant_multi_platform_whitelistv3&amp;utm_relevant_index=9

### NVIDIA Container Runtime 安装

简单来说就是如果docker需要用gpu，就需要安装类似于这个插件NVIDIA Container Toolkit

- 设置包存储库和 GPG 密钥

```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

- 更新并下载安装 nvidia-docker2

```bash
sudo apt-get update
sudo apt-get install -y nvidia-docker2
```

- 重启 Docker 守护进程

```bash
sudo systemctl restart docker
```

- 测试

```bash
sudo docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi
```

[docker使用GPU配置]: https://bbs.huaweicloud.com/blogs/388285

### 把docker彻底卸载

```bash
# 运行下面的命令停止所有正在运行的容器，并且移除所有的 docker 对象：
docker container stop $(docker container ls -aq)
docker system prune -a --volumes
# 现在你可以使用apt像卸载其他软件包一样来卸载 Docker：
sudo apt purge docker-ce
sudo apt autoremove
# 删完之后可以再查看下docker rpm源
rpm -qa |grep docker
# 删除 docer 文件夹
sudo rm -rf /var/lib/docker

# 删除所有未被 tag 标记和未被容器使用的镜像
docker image prune
# 删除所有未被容器使用的镜像:
docker image prune -a
# 删除所有停止运行的容器
docker container prune
# 删除所有未被挂载的卷
docker volume prune
# 删除所有网络
docker network prune
# 删除 docker 所有资源
docker system prune
```

## Docker基本命令

有关Docker的学习网络的教程已经很充分了，本脚本只是为了简单的列举一些常用的命令，简单来说跑一个容器有两种方法`docker run`和`dockerfile`

- 个人开发比较成熟的Docker run 脚本为`xizobu.bash`，在第一次运行时需要给脚本添加权限`chmod +x xizobu.sh`，而后直接`./xizobu.bash`

```bash
TAG="xizobu/galactic:base"

## Forward custom volumes and environment variables
CUSTOM_VOLUMES=()
CUSTOM_ENVS=()
while getopts ":v:e:" opt; do
    case "${opt}" in
        v) CUSTOM_VOLUMES+=("${OPTARG}") ;;
        e) CUSTOM_ENVS+=("${OPTARG}") ;;
        *)
            echo >&2 "Usage: ${0} [-v VOLUME] [-e ENV] [TAG] [CMD]"
            exit 2
            ;;
    esac
done
shift "$((OPTIND - 1))"

## Determine TAG and CMD positional arguments
if [ "${#}" -gt "0" ]; then
    if [[ $(docker images --format "{{.Tag}}" "${TAG}") =~ (^|[[:space:]])${1}($|[[:space:]]) || $(wget -q https://registry.hub.docker.com/v2/repositories/${TAG}/tags -O - | grep -Poe '(?<=(\"name\":\")).*?(?=\")') =~ (^|[[:space:]])${1}($|[[:space:]]) ]]; then
        # Use the first argument as a tag is such tag exists either locally or on the remote registry
        TAG="${TAG}:${1}"
        CMD=${*:2}
    else
        CMD=${*:1}
    fi
fi

## GPU，用于容器可以使用本地电脑的显卡
# Enable GPU either via NVIDIA Container Toolkit or NVIDIA Docker (depending on Docker version)
if dpkg --compare-versions "$(docker version --format '{{.Server.Version}}')" gt "19.3"; then
    GPU_OPT="--gpus all"
else
    GPU_OPT="--runtime nvidia"
fi

## GUI，用于容器可以启动GUI界面
# To enable GUI, make sure processes in the container can connect to the x server
XAUTH=/tmp/.docker.xauth
if [ ! -f ${XAUTH} ]; then
    touch ${XAUTH}
    chmod a+r ${XAUTH}

    XAUTH_LIST=$(xauth nlist "${DISPLAY}")
    if [ -n "${XAUTH_LIST}" ]; then
        # shellcheck disable=SC2001
        XAUTH_LIST=$(sed -e 's/^..../ffff/' <<<"${XAUTH_LIST}")
        echo "${XAUTH_LIST}" | xauth -f ${XAUTH} nmerge -
    fi
fi

# GUI-enabling volumes
GUI_VOLUMES=(
    "${XAUTH}:${XAUTH}"
    "/tmp/.X11-unix:/tmp/.X11-unix"
    "/dev/input:/dev/input"
)
# GUI-enabling environment variables
GUI_ENVS=(
    XAUTHORITY="${XAUTH}"
    QT_X11_NO_MITSHM=1
    DISPLAY="${DISPLAY}"
)

## Additional volumes
# Synchronize timezone with host
CUSTOM_VOLUMES+=("/etc/localtime:/etc/localtime:ro")
# 工作目录
CUSTOM_VOLUMES+=("/home/xizobu/Docker_RoboLearn:/root/Docker_RoboLearn")
# USB热插拔，用于docker容器内可以连接外设USB设备
CUSTOM_VOLUMES+=("/dev/bus/usb:/dev/bus/usb")

## Additional environment variables
# Synchronize ROS_DOMAIN_ID with host
if [ -n "${ROS_DOMAIN_ID}" ]; then
    CUSTOM_ENVS+=("ROS_DOMAIN_ID=${ROS_DOMAIN_ID}")
fi
# Synchronize IGN_PARTITION with host
if [ -n "${IGN_PARTITION}" ]; then
    CUSTOM_ENVS+=("IGN_PARTITION=${IGN_PARTITION}")
fi


# Docker Run 主要命令
DOCKER_RUN_CMD=(
    docker run  
    --interactive
    --tty
    --detach
    --network host
    --ipc host
    --privileged
    --restart "always"
    --name "galactic-robolearn-base"
    --security-opt "seccomp=unconfined"
    "${GUI_VOLUMES[@]/#/"--volume "}"
    "${GUI_ENVS[@]/#/"--env "}"
    "${GPU_OPT}"
    "${CUSTOM_VOLUMES[@]/#/"--volume "}"
    "${CUSTOM_ENVS[@]/#/"--env "}"
    "${TAG}"
    "${CMD}"
)

echo -e "\033[1;30m${DOCKER_RUN_CMD[*]}\033[0m" | xargs

# shellcheck disable=SC2048
exec ${DOCKER_RUN_CMD[*]}

```

[Xizobu Docker Run Scripts]: https://github.com/XizoB/docker_run_scripts



### 镜像

- 搜索官方仓库镜像

```bash
docker search <镜像名字>
```

- 根据镜像名称拉取镜像

```bash
docker pull <镜像名字>
# 拉第三方镜像方法
docker pull index.tenxcloud.com/tenxcloud/httpd
```

- 查看当前主机镜像列表

```bash
docker image list
docker images
```

- 导出镜像

```bash
docker image save centos > docker-centos.tar.gz
```

- 删除镜像

```bash
docker image rm(rmi) centos:latest
```

- 导入镜像

```bash
docker image load -i docker-centos.tar.gz
```

- 查看镜像的详细信息

```bash
docker image inspect centos
```

### 容器

```bash
docker run -it centos /bin/bash
```

- 新建容器并启动

```bash
docer run [可选参数] image

# 参数说明
--name="Name"		容器名字，用来区分容器
-d 					后台方式运行，进入容器查看内容
-p  				指定容器端口 -p 8080:8080 
		-p 主机端口：容器端口
		-p 容器端口
		容器端口
		-p ip:主机端口：容器端口
-P  				随机指定端口
```

- 退出容器、删除容器

```bash
# 退出容器
exit				# 直接退出容器并停止
Ctrl + P + Q		# 容器不停止退出

# 删除容器
docker rm 容器id
docker rm  -f $(docker ps -aq)
```

- 启动和停止容器

```bash
docker start
docker restart
docker stop
docker kill
```

### 常用其他命令

- 查看日志

```bash
docker logs -tf -tail 10 容器id
--tf			# 显示日志
--tail			# 要显示的日志条数
```

- 查看容器中进程信息 ps

```bash
docker top 容器id
```

- 查看容器信息

```bash
docker inspect
```

- 列出所有的容器、进入当前正在运行的容器

```bash
dcoker exec -it 容器id bashShell  # 进入容器后开启一个新的终端

dcoker attach 容器id  # 进入容器后正在执行终端
```

### Commit镜像

```bash
# docker commit 提交容器成为一个新的副本

# 命令与Git相似
docker commit -m="提交的描述信息" -a="作者" 容器id 目标镜像名: [TAG]
```

- 实战测试

```bash
# 1、启动一个默认的tomcat
docker run -d -p 3355:8080 --name tomcat01 tomcat

# 2、发现问题：1、linux命令少了。2、没有webapps。默认是最小的镜像，所有不必要的都剔除。保证最小可运行环境
# 这个默认的tomcat 是没有webapps应用，镜像的原因，官方的镜像默认webapps下面是没有文件的

# 3、进入容器 自己拷贝进去基本的文件
docker exec -it tomcat01 /bin/bash
docker cp -r webapps/* webapps

# 4、将我们操作过的容器通过commit提交为一个镜像，以后就直接使用我们修改过后的镜像即可，这就是我们自己的一个修改的镜像
# 保存当前容器的状态，就可以commit来提交，获得一个镜像

```

### 容器数据卷

#### 使用数据卷

- 方式一：直接使用命令来挂载 -v

```bash
docker run -it -v /home/xizobu/ceshi:/home centos /bin/bash

# 
"Mounts": [
    {
        "Type": "bind",
        "Source": "/home/xizobu/ceshi",
        "Destination": "/home",
        "Mode": "",
        "RW": true,
        "Propagation": "rprivate"
    }
],

docker inspect 容器id
```

- 方式二：dockfile

```bash
创建一个dockerfile文件

文件中的内容 指令（大写）参数

FROM centos

VOLUME ["volume01", "volume02"]  # 匿名挂载

CMD echo "----end----"
CMD /bin/bash

这里面的每个命令，就是镜像的一层

docker build -f /home/xizobu/docker-test-volume/dockerfile1 -t dododo/centos .
-f 指的是dockfile的文件路径
-t 指的是创建镜像的目标名字
```

#### 具名与匿名挂载

```bash
# 匿名挂载
-v 容器内路径
docker run -d -P --name nginx01 -v /etc/nginx nginx

# 查看所有的volume的情况
docker volume ls


# 具名挂载
docker run -d -P --name nginx02 -v juming-nginx:/etc/nginx nginx


-v 容器内路径					# 匿名挂载
-v 卷名：容器内路径				  # 具名挂载
-v /宿主机路径：容器内路径			# 指定路径挂载

# 通过 -v 容器内路径： ro rw 改变读写权限
ro		readonly	# 说明这个路径只能通过宿主机来操作，容器内部是无法操作
rw		readwrite
# 一旦这个设置了容器权限，容器对我们挂载出来的内容就有限定了
docker run -d -P --name nginx03 -v juming-nginx:etc/nginx:ro nginx
docker run -d -P --name nginx03 -v juming-nginx:etc/nginx:rw nginx
```

#### 容器间数据间共享

```bash
docker run -it --volumes-from 容器id

--volumes-from 容器id
```

- 用在集群分布，容器之间配置信息的传递，数据卷容器的生命周期一直持续到没有容器使用位置（像病毒一样传播，一种双向copy继承）。一旦持久化到本地，这个时候，本地的数据是不会删除的

### DockerFile

Dockerfile 就是用来构建 docker 镜像的构建文件，命令脚本

通过这个脚本可以生成镜像，镜像是一层一层的，脚本是一个一个的命令，每个命令都是一层

构建步骤：

1. 编写一个dockerfile文件
2. docker build 构建成为一个镜像
3. docker run 运行镜像
4. docker push 发布镜像（DockerHub）

![七、Docker-Dockerfile_沐雨金鳞-CSDN博客](https://img-blog.csdnimg.cn/20200826113041394.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4MjYyMjY2,size_16,color_FFFFFF,t_70)

步骤：部署、开发、运维

- DockerFile：构建文件，定义一切的步骤，源代码
- DockerImages：通过DockerFile构建生成的镜像，最终发布和运行的产品
- Docker容器：容器就是镜像运行起来提供服务的

#### Dockerfile命令

![Docker入门总结 | Gitlib](https://ts1.cn.mm.bing.net/th/id/R-C.7e554c8e9afda05e73075785c958c3b1?rik=pVLDhGgoiug4pQ&riu=http%3a%2f%2fstatic.gitlib.com%2fblog%2f2017%2f10%2f27%2fdocker2.jpg&ehk=rX%2fmx8o28le1zNp8NyBbI9liiVAlptu%2btk4SJQp84kw%3d&risl=&pid=ImgRaw&r=0)



```bash
FROM				# 基础镜像，一切从这个开始后建
MAINTAINER			# 镜像是谁写的，姓名+邮箱
RUN					# 镜像构建的时候需要运行的命令
ADD					# 步骤：tomcat镜像，这个tomcat压缩包，添加内容
WORKDIR				# 镜像的工作目录
VOLUME				# 挂载的目录
EXPOSE				# 保留端口配置
CMD 				# 指定这个容器启动的时候要运行的命令，只有最有一个会生效，可被替代
ENTRYOINT 			# 指定这个容器启动的时候要运行的命令，可以追加命令
ONBUILD				# 当构建一个被继承 DockerFile 这个时候就会运行 ONBUILD 的指令。触发指令
COPY				# 类似ADD， 将我们文件拷贝到镜像中
ENV 				# 构建的时候设置环境变量

```

- DockerHub中99%的镜像都是从这个基础镜像过来的FROM scratch ，然后配置需要的软件和配置来进行构建

```bash
FROM scratch
ADD centos-7-x86_64-docker.tar.xz /

LABEL \
    org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20201113" \
    org.opencontainers.image.title="CentOS Base Image" \
    org.opencontainers.image.vendor="CentOS" \
    org.opencontainers.image.licenses="GPL-2.0-only" \
    org.opencontainers.image.created="2020-11-13 00:00:00+00:00"

CMD ["/bin/bash"]
```

- 创建一个自己的centos

```bash
# 1、编写Dcokerfile的文件
FROM centos
MAINTAINER xizobu<dododod@qq.com>

ENV MYPATH /usr/local
WORKDIR $MYPATH

RUN yum -y install vim
RUN yum -y install net-tools

EXPOSE 80

CMD echo $MYPATH
CMD echo "----end----"
CMD /bin/bash

# 2、通过这个文件构建镜像
docker build -f dockerfile文件路径 -t 镜像名:[tag]

# 3、测试运行
docker run -it mycentos:0.1
# pwd
# ifconfig
# vim test

# 查看别人镜像怎么制作的
docker history image[id]
docker history --no-trunc=true image > image1-dockerfile


```

### Docker网络

从机器人的角度思考，看一看用于部署集群式机器人之间的通信，可以把一个个容器就看作一台台电脑，容器间的通信啥的

[Docker网络通信学习]: https://zhuanlan.zhihu.com/p/212772001
