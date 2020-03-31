#!/bin/bash
sudo add-apt-repository ppa:stebbins/handbrake-releases -y
sudo apt update
sudo apt install handbrake-cli python-pip

git clone https://github.com/Monzyy/AniConvert.git
cd AniConvert
pip install -r requirements.txt
sudo chmod +x aniconvert.py
