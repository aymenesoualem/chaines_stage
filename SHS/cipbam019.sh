#
. ./INITenvironnement.sh
#
echo "*** cipbam019.sh ***" 
echo "------------------"
echo "MAJ FCIPLOC_REDEC PAR LES TRAMES REDEC POUR CORRECTION"
echo
FF1=$FIC/cipredec_dtv_px           ; export FF1
FF2=$FIC/FCIPLOC_REDEC             ; export FF2
echo
#
cobrun +Q $EXE/cipbam019.gnt
echo
unset FF1
unset FF2
unset FF3
