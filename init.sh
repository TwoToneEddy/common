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
dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
dpkg -i ~/Downloads/VMware-Player-15.5.1-15018445.x86_64.bundle
dpkg -i ~/Downloads/betaflight-configurator_10.6.0_amd64.deb
tar -C /opt/ -xzfv ~/Downloads/BLHeliSuite32xl.tar.gz
tar -C /opt/ -xzfv ~/Downloads/ultimaker.tar.gz
tar -C /opt/ -xzfv ~/Downloads/jetbrains-toolbox-1.16.6319.tar.gz


