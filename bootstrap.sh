#!/usr/bin/env bash

ANDROID_SDK_FILENAME=android-sdk_r24.4.1-linux.tgz
ANDROID_SDK=http://dl.google.com/android/$ANDROID_SDK_FILENAME

apt-get update
apt-get install -y npm git openjdk-7-jdk ant expect
npm install -g n
n 5.11.0
curl -0 -L http://npmjs.org/install.sh | sh
rm /usr/bin/npm
ln -s /usr/local/lib/node_modules/npm/cli.js /usr/bin/npm

curl -O $ANDROID_SDK
tar -xzvf $ANDROID_SDK_FILENAME
chown -R vagrant android-sdk-linux/

echo "ANDROID_HOME=~/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> /home/vagrant/.bashrc
echo "PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/vagrant/.bashrc

npm install -g cordova
npm install -g ionic
expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all --filter platform-tool,android-22,build-tools-22.0.1
expect { 
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'