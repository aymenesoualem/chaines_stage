. ./INITenvironnement.sh
echo
echo "*** bkp_jy2etbac.sh ***" 
echo "    ---------------"
echo " - ARCHIVAGE FICHIERS SOLDES ETBAC"
cp -p $FIC/prm_soldes_etbac  $ARC/prm_soldes_etbac_$i
wcoderr=$?
echo " NBR LU       : " `wc -l   $FIC/prm_soldes_etbac`
echo " NBR ARCHIVE  : " `wc -l   $ARC/prm_soldes_etbac_$i`
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : bkp_jy2etbac.sh, BKP1 terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
#
echo " - ARCHIVAGE REVEVES ETBAC "   
cp -p $FIC/FTELREL            $ARC/FTELREL_$i
wcoderr=$?
echo " NBR LU       : " `wc -l   $FIC/FTELREL`
echo " NBR ARCHIVE  : " `wc -l   $ARC/FTELREL_$i`
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : bkp_jy2etbac.sh, BKP2 terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
