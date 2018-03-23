# ! /bin/bash
scrapyd_config = "~/scrapyd.conf"
python_require = "~/requirement.txt"

# obtain username
cd ~ && users > username.txt
usernamefile = "~/username.txt"
for i in `cat $usernamefile`
do 
		username = $i
done


echo "Begin to extablish Python IDLE server"

# install some tools we need
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install chromium-browser gcc screen vim-gnome unzip mailutils

mkdir ~/Python ~/Download

# download Anaconda3 and chromedriver
cd ~/Download && wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-5.1.0-Linux-x86_64.sh && wget http://npm.taobao.org/mirrors/chromedriver/2.35/chromedriver_linux64.zip

# install Anaconda3
echo "Please don't change the location of Anaconda3, just use its default config."
cd ~/Download && bash Anaconda3-5.1.0-Linux-x86_64.sh 
echo "export PATH=/home/${username}/anaconda3/bin:$PATH" >> ~/.bashrc && source ~/.bashrc


# mv chromedriver
cd ~/Download && unzip chromedriver_linux64.zip && chmod 777 chromedriver && sudo mv chromedriver /usr/local/bin/

# install python extansion package
if [-e "$python_require"]; then
		echo "Install python extension packages."
		cd ~ && pip install -r $python_require
else
		echo "Requirement.txt missed, python extension packages have not been installed yet."
		echo "Please install by yourself"
fi

# config scrapyd
if [-e "$scrapyd_config"]; then
		echo "config scrapyd"
		sudo mkdir /etc/scrapyd
		sudo mv ~/$scrapyd_config /etc/scrapyd/
		echo "If you want scrapyd start as the system does, you need set ti by yourself"
else
		echo "$scrapyd_config file missed"
fi

echo "Finished yet"

