# centos-kvm-template


## 运行环境
1、ubuntu14.04
2、依赖软件包
    - libguestfs-tools
    - virt-sysprep

## 使用说明：

1、在scripts/centos71.sh中定义REPO_URL的源，最好使用内网启动源.例如：http://mirrors.163.com/centos/7.1.1503/os/x86_64/
2、在kickstarts/centos7u1-cloud.cfg 修改--url地址，最好使用内网地址
3、执行sh scripts/centos71.sh  centos71

