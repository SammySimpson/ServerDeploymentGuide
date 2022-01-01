#get python version from user
echo Enter Python version \(ex. - 3.10.0\)
read Version
echo Installing Python $Version

#updates
sudo apt update -y
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt clean -y

#install python
sudo apt-get update -y
sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y
wget https://www.python.org/ftp/python/$Version/Python-$Version.tar.xz
tar xf Python-$Version.tar.xz
cd Python-$Version
./configure
make -j 4
sudo make altinstall
cd ..
sudo rm -r Python-$Version
rm Python-$Version.tar.xz
sudo apt-get --purge remove build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev -y
sudo apt-get autoremove -y
sudo apt-get clean -y