
# 
. ./INITenvironnement.sh
export i=`date '+%y%m%d_%H%M%S'`
echo
echo "*** bkp_fsignat_ag.sh ***" 
echo "    -----------    "
echo "ARCHIVAGE FSIGNAT_AG   AVANT TRAITEMENT MAJ"                                                                     
cp $FIC/FSIGNAT_AG        $ARC/FSIGNAT_AG_$i
echo "FSIGNAT  LU   :" `wc -l $FIC/FSIGNAT_AG`
echo "ARCHIVES      :" `wc -l $ARC/FSIGNAT_AG_$i`