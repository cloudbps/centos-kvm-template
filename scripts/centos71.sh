#!/bin/sh

if [ `whoami` != root ]; then
   echo "ERROR: This script must be run as root" 1>&2
   exit 1
fi

# check for image name
if [ -z "$1" ]; then
	echo "ERROR: No argument supplied. Please provide the image name."
	exit 1
fi

# name of the image
IMGNAME=$1

# location url
REPO_URL=""
# default kickstart file
KICKSTART="centos7u1-cloud.cfg"

# VM image file extension
EXT="qcow2"

BRI="virbr0"

P="/var/lib/libvirt/images"

echo "Generating VM ..."

# create image file
/usr/bin/virt-install \
--name $IMGNAME \
--ram 2048 \
--cpu host \
--vcpus 1 \
--nographics \
--os-type=linux \
--os-variant=rhel7 \
--location=$REPO_URL \
--initrd-inject=../kickstarts/$KICKSTART \
--extra-args="ks=file:/$KICKSTART text console=tty0 utf8 console=ttyS0,115200" \
--network bridge=$BRI \
--disk path=${P}/$IMGNAME.$EXT,size=20,bus=virtio,format=qcow2 \
--force \
--noreboot

# reset, unconfigure a virtual machine so clones can be made
virt-sysprep --no-selinux-relabel -d $IMGNAME
qemu-img convert -o compat=0.10 -f qcow2 -O qcow2 -c -p /var/lib/libvirt/images/$IMGNAME.$EXT ~/$IMGNAME.$EXT


echo "Process Completed. Use the 'virt start $IMGNAME' command to start the newly created VM."

#==============================================================================+
# END OF FILE
#==============================================================================+
