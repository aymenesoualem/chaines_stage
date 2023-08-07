. ./INITenvironnement.sh 
echo
echo " *** ftp_cipchq01.sh ***" 
echo "    ----------------"
echo " --- RECUPERATION MOUVEMENT RETRAIT CHQ COMPENS "
echo " !!! MACHINE 100.2 vers 100.4"
##echo " !!! tapez ENTRE pour continuer, CTRL+C pour annuler "
##read a
wsuf=fluxcip
wfich=fluxcip_chqcompens
datjj=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,5,4) substr($0,3,2) substr($0,1,2)}' $FIC/DATCONSOLE)
echo " Journée du : " $datjj
#  
echo " --- CIP : flux CHEQUE COMPENSE DTV "

#####-- a activer si sur 100.2
###ftp -n -i -v DWHBQ-SY << END
###user central migvse 
###cd /central/MVT
###prompt
###ascii
###put ${wfil} fluxcip_chqcompens
###by
###END

#get ${wfil} $MVT/fluxcip_chqcompens
#####-- a activer si sur 100.4
ftp -n -i -v TSM-SRV-SY <<END_SCRIPT
user vse migvsmig 
cd /vse/MVT
lcd /central/MVT
ascii
prompt
mget fluxcip_${datjj}*
quit
END_SCRIPT
wcodret=$?
#
if [ $wcodret != 0 ]
then
	   echo " ERR : TRANSFER TERMINE EN ERREUR "
     exit 9
fi
#
j=0
for wfil in `ls -t $MVT/${wsuf}_${datjj}* 2>/dev/null`
do           
   let j=j+1
   echo ' -' ${wfil}
   if [ $j == 1 ] 
   then
       break 1
   fi 
done
#
if [ $j == 1 ] 
then
    cp ${wfil} $MVT/${wfich}
else
    cat /dev/null/ > $MVT/${wfich}
fi 
#
rm -f $MVT/${wsuf}_${datjj}*
