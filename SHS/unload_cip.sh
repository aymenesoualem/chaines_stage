#!/bin/ksh
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
rm -f $MVT/MAJ_IDP_CIP_ORA_P31.TXT
rm -f $MVT/MAJ_IDP_CIP_ORA_P32.TXT
rm -f $MVT/MAJ_IDP_CIP_ORA_P36.TXT
rm -f $MVT/MAJ_IDP_CIP_ORA_P38.TXT

echo
echo "  - DECHARGEMENT DES IDP DECLARATIONS (P31)"
sqlplus -s centrale/vse@VSEDB @$ORA/unload_cip_jour_p31.sql $vdatjour
wretsql=$?
if [ $wretsql -ne 0 ]
then
   echo " !!! ERREUR, extraction P31 "
   exit 1
fi

echo
echo "  - DECHARGEMENT DES IDP REGLEMENTS (P32)"
sqlplus -s centrale/vse@VSEDB @$ORA/unload_cip_jour_p32.sql $vdatjour
wretsql=$?
if [ $wretsql -ne 0 ]
then
   echo " !!! ERREUR, extraction P32 "
   exit 1
fi

echo
echo "  - DECHARGEMENT DES IDP ANNULATIONS (P36)"
sqlplus -s centrale/vse@VSEDB @$ORA/unload_cip_jour_p36.sql $vdatjour
wretsql=$?
if [ $wretsql -ne 0 ]
then
   echo " !!! ERREUR, extraction P36 "
   exit 1
fi

echo
echo "  - DECHARGEMENT DES IDP INFRACTIONS (P38)"
sqlplus -s centrale/vse@VSEDB @$ORA/unload_cip_jour_p38.sql $vdatjour
wretsql=$?
if [ $wretsql -ne 0 ]
then
   echo " !!! ERREUR, extraction P38 "
   exit 1
fi

echo
wnbr=`wc -l $MVT/MAJ_IDP_CIP_ORA_P31.TXT` 
echo "   - NOMBRE IDP SAISI LE JOUR (P31)    : " $wnbr
wnbr=`wc -l $MVT/MAJ_IDP_CIP_ORA_P32.TXT` 
echo "   - NOMBRE IDP SAISI LE JOUR (P32)    : " $wnbr
wnbr=`wc -l $MVT/MAJ_IDP_CIP_ORA_P36.TXT` 
echo "   - NOMBRE IDP SAISI LE JOUR (P36)    : " $wnbr
wnbr=`wc -l $MVT/MAJ_IDP_CIP_ORA_P38.TXT` 
echo "   - NOMBRE IDP SAISI LE JOUR (P38)    : " $wnbr
echo

> $MVT/MAJ_IDP_CIP_ORA.TXT
cat $MVT/MAJ_IDP_CIP_ORA_P31.TXT >  $MVT/MAJ_IDP_CIP_ORA.TXT
cat $MVT/MAJ_IDP_CIP_ORA_P32.TXT >> $MVT/MAJ_IDP_CIP_ORA.TXT
cat $MVT/MAJ_IDP_CIP_ORA_P36.TXT >> $MVT/MAJ_IDP_CIP_ORA.TXT
cat $MVT/MAJ_IDP_CIP_ORA_P38.TXT >> $MVT/MAJ_IDP_CIP_ORA.TXT


wnbr=`wc -l $MVT/MAJ_IDP_CIP_ORA.TXT` 
echo "   - NOMBRE IDP SAISI LE JOUR (GLOBAL) : " $wnbr
echo
echo "---------------------------------------------------"
echo "--- FIN   DECHARGEMENT DES IDP DE LA JOURNEE    ---" `date '+%y%m%d_%H%M%S'`
echo "---------------------------------------------------"
echo
