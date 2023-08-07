#
#  
. ./INITenvironnement.sh  
#
echo "*** cipsigna02.sh ***" 
echo "    -----------    "
echo
echo "SELECT TRAMES PB SANS DOUBLE"
FF1=$TMP/pbx_fsignat01           ; export FF1
FF2=$TMP/pbx_fsignat02           ; export FF2
FF3=$LST/CIPSIGNA02_PB_DOUBLE    ; export FF3
#
cobrun +Q $EXE/cipsigna02.gnt
#
unset FF1
unset FF2
unset FF3
#
echo

