# Cron JOB Setup Program ( )
# DjAmol Group Pvt Ltd.
# WWW.DjAmol.Com
# djamolpatil@gmail.com


date +"%r" >> $BUILD;echo "FFMPEG STARTED Installation" >> $BUILD
cd $SCRIPTPATH/src
yum -y install wget unzip;wget --no-check-certificate -O ffmpeginstaller.zip https://github.com/djamol/FFMPEG-CENTOS/archive/master.zip; unzip ffmpeginstaller.zip; cd FFMPEG-CENTOS-master;cd SharedFFMPEG;chmod +x *.sh; 
#Runable
./start.sh 
#BAckground install and output store in file
#./start.sh > FFMPEG-output.log 2>&1 &

date +"%r" >> $BUILD;echo "FFMPEG DONE Installation" >> $BUILD
