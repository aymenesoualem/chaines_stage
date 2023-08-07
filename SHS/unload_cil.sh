. ./INITenvironnement.sh
#
##export NLS_LANG=FRENCH_FRANCE.WE8ISO8859P1
#
vdatjour=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,5,4) substr($0,3,2) substr($0,1,2) }' $FIC/DATCONSOLE)

echo
echo "--- EXTRACTION SAISIE DTV DE LA JOURNEE DU : " $vdatjour
echo
echo "---------------------------------------------------"
echo "--- DEBUT DECHARGEMENT DES IDP DE LA JOURNEE    ---" `date '+%y%m%d_%H%M%S'`
echo "---------------------------------------------------"

echo
echo "  - INITIALISATION FICHIER (DELETE) "
rm -f $MVT/MAJ_CIL_ORA_PXX.TXT

echo
echo "  - DECHARGEMENT DES IDP DECLARATIONS (PXX)"
sqlplus -s centrale/vse@VSEDB @$ORA/unload_cil_jour_pxx.sql
wretsql=$?
if [ $wretsql -ne 0 ]
then
   echo " !!! ERREUR, extraction PXX "
   exit 1
fi
echo
wnbr=`wc -l $MVT/MAJ_CIL_ORA_PXX.TXT` 
echo "   - NOMBRE IDP SAISI LE JOUR (PXX)    : " $wnbr
echo
echo "---------------------------------------------------"
echo "--- FIN   DECHARGEMENT DES IDP DE LA JOURNEE    ---" `date '+%y%m%d_%H%M%S'`
echo "---------------------------------------------------"
echo
