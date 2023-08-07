. ./INITenvironnement.sh
#
#
vdatjour=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,5,4) substr($0,3,2) substr($0,1,2) }' $FIC/DATCONSOLE)
#
echo
echo "---------------------------------------------------"
echo "--- DEBUT DECHARGEMENT DES CIP_JJ DE LA JOURNEE    ---" $vdatjour
echo "---------------------------------------------------"
echo
sqlplus -s centrale/vse@VSEDB @$ORA/unload_cip_jj.sql $vdatjour
wretsql=$?
if [ $wretsql -ne 0 ]
then
   echo " !!! ERREUR, extraction cip_jj "
   exit 1
fi
#-------------------------------
chmod 777 $FIC/CIP_JJ.TXT
echo
echo "NOMBRE DE CIP genere"
wc -l $FIC/CIP_JJ.TXT
echo
echo
echo "DATE FIN DECHARGEMENT : " `date '+%y%m%d%H%M%S'`
 
