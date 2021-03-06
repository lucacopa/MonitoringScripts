#!/bin/bash
location="/afs/cern.ch/user/c/cmst1/scratch0/MonitoringScripts/SR_View_SSB/WRDays/"
outputdir="/afs/cern.ch/user/c/cmst1/www/SST/"
cd $location

if [ -f scriptRunning.run ];
then
   echo "run_WaitingRoom_SumMetrics.sh is already running. Will send an email to the admin."
   # script to send simple email
   # email subject
   SUBJECT="[MonitoringScripts] WRDays running slowly"
   # Email To ?
   EMAIL="artiedaj@fnal.gov"
   # Email text/message
   if [ -f emailmessage.txt ];
   then
      rm emailmessage.txt
   fi
   touch emailmessage.txt
   EMAILMESSAGE="/tmp/emailmessage.txt"
   echo "run_WaitingRoom_SumMetrics.sh  is running slowly."> $EMAILMESSAGE
   echo $location >>$EMAILMESSAGE
   # send an email using /bin/mail
   /bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE

else
     echo "bash run_WaitingRoom_SumMetrics.sh started succesfully"
     touch scriptRunning.run
fi


#Run the script
txt="WaitingRoom_"  #postfix in code itself
echo "python waitingRoom_SummedMetrics.py $txt1"
python waitingRoom_SummedMetrics.py $txt &> sites_WaitingRoom_SummedMetrics.log

problem="$?"
echo "problem: $problem"

cp $txt*.txt $outputdir
echo "WaitingRoom_XMonthSum.txt files copied to: " $outputdir
rm scriptRunning.run