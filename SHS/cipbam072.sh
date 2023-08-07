#-----------------------------------------------------------------------#
. ./INITenvironnement.sh
#
echo 'DELETE HISTBAM AVANT REMISE EN PLACE '
rm -f $FIC/CIPDEC_HISTBAM
rm -f $FIC/CIPDEC_HISTBAM.idx
#
echo 'FIN DELETE CIPDEC_HISTBAM  ---> ENTER POUR CONTINUER SI OK  '
#
read a
echo
echo "REMISE EN PLACE FIC/CIPDEC_HISTBAM INDEXE "
#
FF1=$FIC/cipdec_fus_histb      ; export FF1
FF2=$FIC/CIPDEC_HISTBAM                 ; export FF2
#
cobrun +Q $EXE/cipbam072.gnt
unset FF1
unset FF2
#-----------------------------------------------------------------------#  
