. ./INITenvironnement.sh
echo
echo "*** cipbam320.sh ***" 
echo "    -----------    "
echo "ATTRIBUTION DU RANG POUR LES DECLARATIONS DU JOUR "
export i=`date '+%y%m%d%H%M%S'`

cp $LST/CIP_ANO_DEC  $ARC/CIP_ANO_DEC_$i
awk '{ FS="" } {if (substr($0,01,03)=="P11") print $0}' $LST/CIP_ANO_DEC > $TMP/REJET_CIPBAM022
sort -u +0.8 -0.35 $TMP/REJET_CIPBAM022 > $TMP/REJET_CIPBAM022_tri
rebuild $TMP/REJET_CIPBAM022_tri,$FIC/REJET_CIPBAM022 -o:lseq,ind -t:c-isam -r:f250 -k:8+28
wc -l $FIC/FCIPRANG

FF1=$FIC/cip_decinc_pxx_let   ; export FF1
FF2=$FIC/FCIPRANG             ; export FF2
FF3=$FIC/FCIPLOC              ; export FF3
FF4=$FIC/FREJET_RANG          ; export FF4
FF5=$FIC/REJET_CIPBAM022      ; export FF5
#
cobrun +Q $EXE/cipbam320.gnt
unset FF1
unset FF2
unset FF3
unset FF4
unset FF5
