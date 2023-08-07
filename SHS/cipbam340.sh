. ./INITenvironnement.sh
i=`date '+%y%m%d%H%M%S'`
echo
echo "*** cipbam340.sh ***" 
echo "    -----------    "
echo "RECUPERATRION RANG POUR CORRECTION ET REDECLARAION"
FF01=$FIC/cip_decinc_pxx       ; export FF01
FF11=$FIC/FCIPLOC              ; export FF11
FF12=$FIC/cip_decinc_pxx_let   ; export FF12
FF13=$FIC/FREJET_CIPBAM340     ; export FF13
#
cobrun +Q $EXE/cipbam340.gnt
unset FF01
unset FF11
unset FF12
unset FF13
