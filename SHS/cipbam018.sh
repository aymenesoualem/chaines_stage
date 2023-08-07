#
. ./INITenvironnement.sh 
#
echo
echo "*** cipbam018.sh ***" 
echo "    -----------    "
echo "CREATION P16 SI CHQ REGLE ET PRESENCE INCIDENT "
#
FF1=$FIC/FCIPLOC              ; export FF1
FF2=$FIC/FCHQRECU             ; export FF2 
FF3=$FIC/incp46_chqrecu       ; export FF3  
FF4=$FIC/DATCONSOLE           ; export FF4
#
cobrun +Q $EXE/cipbam018.gnt
unset FF1
unset FF2
unset FF3
unset FF4
echo
