#
#  
. ./INITenvironnement.sh  
#
echo "*** y2selcip.sh ***" 
echo "    -----------    "
echo
echo "SELECT PXX  VENANT DES AGENCES"
FF1=$FIC/sem_inc020_incpxx   ; export FF1
FF2=$FIC/FSCIP               ; export FF2
FF3=$FIC/inc_dec_agence      ; export FF3
FF4=$LST/CIP_TRAME_IGNORE       ; export FF4
#
cobrun +Q $EXE/y2selcip.gnt
#
unset FF1
unset FF2
unset FF3
unset FF4
#
echo

