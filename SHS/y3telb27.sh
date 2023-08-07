. ./INITenvironnement.sh
echo
echo "*** y3telb27.sh ***" 
echo "    -----------    "
echo " - FTELREL : FICHIER FINAL RELEVE ETBAC "
echo
FF1=$FIC/tem_ftelrel02      ; export FF1
FF2=$FIC/FTELREL            ; export FF2
cobrun +Q $EXE/y3telb27.gnt
wcoderr=$?
#
unset FF1
unset FF2
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : y3telb27.sh, PRG terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
