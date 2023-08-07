# 
. ./INITenvironnement.sh
export i=`date '+%y%m%d_%H%M%S'`
echo
echo "*** bkp_fcipbam.sh ***" 
echo "    -----------    "
echo "ARCHIVAGE FCIPBAM AVANT TRAITEMENT "                                                                     
cp $FIC/FCIPBAM         $ARC/FCIPBAM_$i
echo "LUS      :" `wc -l $FIC/FCIPBAM`
echo "ARCHIVES :" `wc -l $ARC/FCIPBAM_$i`
echo
gzip $ARC/FCIPBAM_$i