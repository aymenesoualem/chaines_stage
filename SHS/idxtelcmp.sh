. ./INITenvironnement.sh
echo
echo "*** idxtelcmp ***"
echo "    ---------    "
echo " - REMISE EN PLACE FTELCMP A PARTIR DE ftelcmp.txt"
echo
FF1=/central/ftelcmp.txt ; export FF1
FF2=$FIC/FTELCMP         ; export FF2
#
cobrun +Q $EXE/idxtelcmp.gnt
wcoderr=$?
#
unset FF1
unset FF2
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : idxtelcmp.sh, INDEX terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
