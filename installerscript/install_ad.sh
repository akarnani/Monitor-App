
# Bash script to install AppDaemon 4.x to a Raspberry Pi 3/4
# Recommended OS: Latest Raspbian downloaded from raspberrypi.org
# Run: bash -c "$(curl -sL https://raw.githubusercontent.com/Odianosen25/Monitor-App/master/installerscript/install_ad.sh)"

clear
echo -e "\e[0m"
echo -e "\e[96m______  ___            __________                    _______                 \e[90m"
echo -e "\e[96m___   |/  /_______________(_)_  /______________      ___    |_______________ \e[90m"
echo -e "\e[96m__  /|_/ /_  __ \_  __ \_  /_  __/  __ \_  ___/________  /| |__  __ \__  __ \ \e[90m"
echo -e "\e[96m_  /  / / / /_/ /  / / /  / / /_ / /_/ /  /   _/_____/  ___ |_  /_/ /_  /_/ / \e[90m"
echo -e "\e[96m/_/  /_/  \____//_/ /_//_/  \__/ \____//_/           /_/  |_|  .___/_  .___/  \e[90m"
echo -e "\e[96m                                                            /_/     /_/    \e[90m"
echo -e "\e[0m"
echo -e "\e[0m"
echo -e "\e[0m"
cd ~
echo -e "\e[96m  Preparing system for AppDaemon 4.x & Monitor-App...\e[90m"
echo -e "\e[0m"

# Prepare system
echo -e "\e[96m[STEP 1/10] Updating system...\e[90m"
if sudo apt-get update -y;
then
    echo -e "\e[32m Updating | Done\e[0m"
else
    echo -e "\e[31m Updating | Failed\e[0m"
    exit;
 fi
echo -e "\e[0m"

if sudo apt-get upgrade -y;
then
    echo -e "\e[32m[STEP 1/10] Update & Upgrading | Done\e[0m"
else
    echo -e "\e[31m[STEP 1/10] Update & Upgrading | Failed\e[0m"
    exit;
fi
echo -e "\e[0m"


# Installing packages
echo -e "\e[96m[STEP 2/10] Installing Python & Dependencies...\e[90m"
if sudo apt install python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev git -y;
then
    echo -e "\e[32m Installing Python & Dependencies | Done\e[0m"
else
    echo -e "\e[31m Installing Python & Dependencies | Failed\e[0m"
    exit;
fi
echo -e "\e[0m"

if git clone https://github.com/Odianosen25/Monitor-App.git;
then
    echo -e "\e[32m[STEP 2/10] Cloning Monitor-App | Done\e[0m"
else
    echo -e "\e[31m[STEP 2/10] Cloning Monitor-App | Failed\e[0m"
    exit;
fi
echo -e "\e[0m"

#Create User appdaemon
echo -e "\e[96m[STEP 3/10] Creating users...\e[90m"
if sudo useradd -rm appdaemon;
then
    echo -e "\e[32m Creating user | Done\e[0m"
else
    echo -e "\e[31m Creating user | Failed\e[0m"
    exit;
fi
echo -e "\e[0m"

if sudo mkdir /srv/appdaemon;
then
    echo -e "\e[32m Creating AppDaemon folder | Done\e[0m"
else
    echo -e "\e[31m Creating AppDaemon folder | Failed\e[0m"
    exit;
fi
echo -e "\e[0m"


if sudo chown appdaemon:appdaemon /srv/appdaemon;
then
    echo -e "\e[32m[STEP 3/10] Creating users | Done\e[0m"
else
    echo -e "\e[31m[STEP 3/10] Creating users | Failed\e[0m"
    exit;
fi


# Copy service to run AppDaemon as Service
echo -e "\e[96m[STEP 4/10] Copying service to run AppDaemon as Service...\e[90m"
if sudo cp ~/Monitor-App/installerscript/appdaemon@appdaemon.service /etc/systemd/system/appdaemon@appdaemon.service;
then
    echo -e "\e[32m[STEP 4/10] Copy service | Done\e[0m"
else
    echo -e "\e[31m[STEP 4/10] Copy service | Failed\e[0m"
    exit;
fi


# Make the service ready for autostart
#echo -e "\e[96m[STEP 7/10] Enable and run the AppDaemon service...\e[90m"
#if sudo systemctl enable appdaemon@appdaemon.service;
#then
#    echo -e "\e[32m[STEP 7/10] AppDaemon service enabled and running | Done\e[0m"
#else
#    echo -e "\e[31m[STEP 7/10] AppDaemon service enabled and running | Failed\e[0m"
#    exit;
#fi

# Prepare installation part 2 file
if sudo cp ~/Monitor-App/installerscript/install_ad_part2.sh ~/install_ad_part2.sh;
then
    echo -e "\e[32mPreparation of installation part 2 | Done\e[0m"
else
    echo -e "\e[31mPreparation of installation part 2 | Failed\e[0m"
    exit;
fi

if sudo chmod +x ~/install_ad_part2.sh;
then
    echo -e "\e[32mDone\e[0m"
else
    echo -e "\e[31mFailed\e[0m"
    exit;
fi

echo " "
echo " "
echo " "
echo -e "\e[32mTo continue installation, type: \e[96mbash install_ad_part2.sh\e[0m"
echo " "
echo " "
echo " "

sudo -u appdaemon -H -s

if sudo systemctl enable appdaemon@appdaemon.service --now;
then
    echo -e "\e[32mAutostart Service | Done\e[0m"
else
    echo -e "\e[31mAutostart Service | Failed\e[0m"
    exit;
fi

echo -e "\e[0m"
echo -e "\e[0m"
echo -e "\e[0m"
echo -e "\e[0m"
echo -e "\e[96mThe final step now are to fill in information about your own\e[90m"
echo -e "\e[96menvironment, like IP address, username and password ++ for your\e[90m"
echo -e "\e[96mMQTT broker in appdaemon.conf...\e[90m"
echo -e "\e[96mYou will find the file here:\e[90m"
echo -e "\e[32msudo nano /home/appdaemon/.appdaemon/conf/appdaemon.conf\e[0m"
echo -e "\e[96mFinish the edit with ctrl+o & ctrl+x\e[90m"
echo -e "\e[0m"
echo -e "\e[96mThen you need to edit and complete missing information in\e[90m"
echo -e "\e[96mapps.yaml that you will find here:\e[90m"
echo -e "\e[32msudo nano /home/appdaemon/.appdaemon/conf/apps.yaml\e[0m"
echo -e "\e[96mFinish the edit with ctrl+o & ctrl+x\e[90m"
echo -e "\e[0m"
echo -e "\e[96mWhen all above is done, \e[32msudo reboot now\e[96m your device.\e[90m"
echo -e "\e[96mIf all went well, you should see new entities in HA\e[90m"
echo -e "\e[0m"
