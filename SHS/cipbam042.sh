#
. ./INITenvironnement.sh
echo
#echo "LISTE DECLARATION INCIDENTS DE PAIEMENT JJ "
echo
echo "*** cipbam042.sh ***" 
echo "    -----------    "
echo
#
FF1=$FIC/CIPDEC_HISTBAM_JJ   ; export FF1  
FF2=$LST/CIP_LST_DEC         ; export FF2
#
cobrun +Q $EXE/cipbam042.gnt
#
unset FF1
unset FF2  