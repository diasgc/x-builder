#!/bin/bash

#
# envman install:
# sudo su curl -fL https://github.com/bitrise-io/envman/releases/download/2.3.0/envman-$(uname -s)-$(uname -m) > /usr/bin/envman && chmod a+x /usr/bin/envman
#

function checkUrl {
  wget -S --spider $1 2>&1 | grep -q "HTTP/1.[0-9] 200 OK" && echo SUCCESS || echo FAIL
}

downloadP(){
  local url=$1
  echo -n "    "
  wget --progress=dot $url 2>&1 | grep --line-buffered "%" | sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
  echo -ne "\b\b\b\b"
  echo " DONE"
}

download(){
  # bsdtar from stdin doesn't extract file +x permission
  # wget -qO- $1 | bsdtar -xvf- >/dev/null 2>&1
  wget $1 -O tmp.zip
  bsdtar -xvf tmp.zip
  rm tmp.zip
}

installJava(){
  read -p "Install OpenJDK? " jdk
  if [ "y" == "$jdk" ];then
    echo Installing OpenJDK
    sudo apt-get -qq install -y lib32z1 openjdk-8-jdk >/dev/null 2>&1
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export PATH=$JAVA_HOME:$PATH
    printf "\n\nexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
  fi
}

instalCmdlineTools(){
  read -p "Install commandline tools ?" cmdl
  if [ "y" == "$cmdl" ];then
    echo -ne "\e[35mCommand-line Tools\e[0m "
    download https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip || exit 1
    mkdir cmdline-tools && mv tools cmdline-tools
    cd cmdline-tools/tools/bin
    echo -ne "\e[35mPlatform Tools, Platform android 29, Build-Tools, CMake\e[0m "
    ./sdkmanager "platform-tools" "platforms;android-29" "build-tools;26.0.3" "cmake;3.10.2.4988404"
    export PATH=$ANDROID_HOME/cmdline-tools/tools/bin:$PATH
    export PATH=$ANDROID_HOME/tools:$PATH
    export PATH=$ANDROID_HOME/platform-tools:$PATH
    printf "\n\nexport ANDROID_HOME=$ANDROID_HOME" >> ~/.bashrc
    echo "done "
  fi
}

aptUpdate(){
  sudo apt udpate
  sudo apt upgrade -y
  sudo apt dist-upgrade -y
  sudo apt autoremove -y
  sudo apt autoclean -y
  sudo apt install locate
  sudo updatedb
}

aptInstall(){
  while [ "$1" != "" ];do
    echo -ne "\e[34mInstall $1.\e[0m"
    sudo apt install $1 >/dev/null 2>&1 || break
    echo -ne " done "
    shift
  done
  echo
}

# update apt
read -p 'Update system (recomended)? ' updSys
[ "y" == $updSys ] && aptUpdate

# install gcc
read -p 'Install Gnu Compiler Collection (GCC)(120-150MB)? ' ins
[ "y" == $ins ] && aptInstall gcc

# install compiler tools
read -p 'Install Gnu Tools (gcc-multilib make autoconf automake libtool flex bison gdb gcc-9-multilib)(120-150MB)? ' ins
[ "y" == $ins ] && aptInstall gcc-multilib make autoconf automake libtool flex bison gdb

# install mingw-w64
read -p 'Install MinGW-W64 (800-900MB)? ' ins
[ "y" == $ins ] && aptInstall mingw-w64

# install cmake & ccmake
read -p 'Install cmake ccmake (28-35MB)? ' ins
[ "y" == $ins ] && aptInstall cmake cmake-curses-gui

export ANDROID_HOME=~/android
[ ! -d $ANDROID_HOME ] && mkdir -p $ANDROID_HOME
cd $ANDROID_HOME

# set env vars
installNew=0
[ -z "$ANDROID_NDK_HOME" ] && installNew=1

NDK_URL=
while [ -z $NDK_URL ];do
  read -p "Select NDK version to install (eg. r21b): " ANDROID_NDK_VERSION
  NDK_URL="https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip"
  ST=$(checkUrl $NDK_URL)
  [ "FAIL" == "$ST" ] && echo "version $ANDROID_NDK_VERSION does not exists. " && NDK_URL=
done

export ANDROID_NDK_HOME=$ANDROID_HOME/android-ndk
# expose for subsequent steps 
# envman add --key ANDROID_NDK_HOME --value "$ANDROID_NDK_HOME"
# clean up if a previous version is already installed
[ -d $ANDROID_NDK_HOME ] && mv $ANDROID_NDK_HOME "${ANDROID_NDK_HOME}_OLD"
[ -d "~/android" ] && mkdir -p ~/android
cd ~/android || exit 1

[ -z $(which bsdtar) ] && aptInstall libarchive-tools

# download
echo -ne "\nDownloading and extracting android-ndk-${ANDROID_NDK_VERSION}, please wait... "
download $NDK_URL
echo -e "done "

# move to its final location
mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME}
[ -d "${ANDROID_NDK_HOME}_OLD" ] && rm -rf "${ANDROID_NDK_HOME}_OLD"

export PATH="$ANDROID_NDK_HOME:$PATH"
printf "\n\nexport ANDROID_NDK_HOME=$ANDROID_NDK_HOME" >> ~/.bashrc

# expose for subsequent steps
#envman add --key PATH --value "$PATH"

[ -z $(which java) ] && installJava
[ ! -d "~/android/cmdline-tools" ] && instalCmdlineTools

# export path to user environment
printf "\n\nexport PATH=$PATH" >> ~/.bashrc

#printf "\n\nexport ANDROID_HOME=$ANDROID_HOME\nexport ANDROID_NDK_HOME=$ANDROID_NDK_HOME\nexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\nexport PATH=\$JAVA_HOME/bin:\$ANDROID_NDK_HOME:\$ANDROID_HOME:\$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:\$PATH" >> ~/.bashrc