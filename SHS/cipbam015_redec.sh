#
. ./INITenvironnement.sh
#
echo "*** cipbam015_redec.sh ***" 
echo "------------------"
echo "GENERATION FCIPLOC_REDECC INDEXE "
echo "BASE INTERMEDIAIRE POUR ENLEVER LES IC REJETES"
echo
FF1=$TMP/FCIPLOC_TRI                ; export FF1
FF2=$FIC/FCIPLOC_REDEC              ; export FF2
FF3=$TMP/FCIPLOC_REDEC_DOUBLE       ; export FF3
echo
#
cobrun +Q $EXE/cipbam015.gnt
echo
unset FF1
unset FF2
unset FF3
