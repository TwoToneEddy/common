#hdd is sdb1 ext4
#sudo mkdir /media/newhd
#sudo mount /dev/sdb1 /media/newhd
#df -H
cd ~/
rm .bashrc
ln -s ~/common/.bashrc .bashrc
sudo apt-get install git
sudo apt install gitk
git config --global user.email "lee.hudson1384@yahoo.co.uk"
ssh-keygen -t rsa -b 4096 -C "lee.hudson1384@yahoo.co.uk"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa 
sudo apt install python-pip 
pip install -U platformio
git clone git@github.com:TwoToneEddy/TH3D-Unified-U1.R2.git
git clone git@github.com:TwoToneEddy/quadSettings.git
cd ~/

mkdir work
cd work
git clone https://github.com/LeeHudsonDLS/FE10B.git
git clone https://github.com/LeeHudsonDLS/FE10B-CS-IOC-01.git

sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
sudo sh ~/Downloads/VMware-Player-15.5.1-15018445.x86_64.bundle
sudo dpkg -i ~/Downloads/betaflight-configurator_10.6.0_amd64.deb
sudo tar -C /opt/ -xzf ~/Downloads/BLHeliSuite32xl.tar.gz
sudo tar -C /opt/ -xzf ~/Downloads/ultimaker.tar.gz
sudo tar -C /opt/ -xzf ~/Downloads/jetbrains-toolbox-1.16.6319.tar.gz


