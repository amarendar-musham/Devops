cd ~
wget "http://redrockdigimark.com/apachemirror/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.zip"
unzip apache-maven-3.5.2-bin.zip
rm apache-maven-3.5.2-bin.zip
export M2_HOME=~/apache-maven-3.5.2/
export PATH=$PATH:${M2_HOME}/bin

// AND need to give the maven home path to configure system in jenkins
// Global tool conf --- maven home && java jdk [mvn -v]
// Maven integration plugin
// clean install/package
echo 
echo 
echo "export PATH=$PATH:~/apache-maven-3.5.2/bin \n if this isn't working then add it to ur bashrc file in ~/.bashrc"
echo 
echo 
