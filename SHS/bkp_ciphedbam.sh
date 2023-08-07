# 
. ./INITenvironnement.sh
export i=`date '+%y%m%d_%H%M%S'`
echo
echo "*** bkp_ciphedbam.sh ***" 
echo "    -----------    "
echo "ARCHIVAGE HEADER CIP_HEDBAM AVANT TRAITEMENT "                                                                     
cp $FIC/CIP_HEDBAM       $ARC/CIP_HEDBAM_$i
echo "LUS HEADER  :" `wc -l $FIC/CIP_HEDBAM`
echo "ARCHIVE     :" `wc -l $ARC/CIP_HEDBAM_$i`