# 
. ./INITenvironnement.sh
export i=`date '+%y%m%d_%H%M%S'`
echo
echo "*** bkp_fciploc.sh ***" 
echo "    -----------    "
echo "ARCHIVAGE FCIPLOC  AVANT TRAITEMENT "                                                                     
cp $FIC/FCIPLOC          $ARC/FCIPLOC_$i
echo "LUS      :" `wc -l $FIC/FCIPLOC`
echo "ARCHIVES :" `wc -l $ARC/FCIPLOC_$i`
echo