# 
. ./INITenvironnement.sh
export i=`date '+%y%m%d_%H%M%S'`
echo
echo "*** bkp_cip_saisie.sh ***" 
echo "    -----------    "
echo "ARCHIVAGE SAISIE CIP JOURNEE VEILLE"                                                                     
cp $FIC/cip_decinc_pxx         $ARC/cip_decinc_pxx_$i
echo "LUS      :" `wc -l $FIC/cip_decinc_pxx`
echo "ARCHIVES :" `wc -l $ARC/cip_decinc_pxx_$i`
echo