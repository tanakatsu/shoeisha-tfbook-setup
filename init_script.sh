#!/bin/bash
echo "Update"
apt-get update
apt-get -y install git vim htop less unzip
apt-get -y upgrade
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub

echo "Checking for CUDA and installing."
# Check for CUDA and try to install.
if ! sudo dpkg-query -W cuda-9-0; then
  curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
  dpkg -i ./cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
  apt-get -y update
  apt-get -y install cuda
  rm cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
fi

echo "install docker"
apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# set up the Docker stable repository.
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
# update the apt package index:
apt-get update
# finally, install docker
apt-get -y install docker-ce

echo "install nvidia-docker"
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
dpkg -i nvidia-docker*.deb
rm nvidia-docker_1.0.1-1_amd64.deb
reboot
