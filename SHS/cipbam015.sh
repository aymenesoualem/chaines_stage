#
. ./INITenvironnement.sh
#
echo "*** cipbam015.sh ***" 
echo "------------------"
echo "GENERATION FINCLOC INDEXE "
echo
FF1=$TMP/FCIPLOC_TRI          ; export FF1
FF2=$FIC/FCIPLOC              ; export FF2
FF3=$TMP/FCIPLOC_DOUBLE       ; export FF3
echo
#
cobrun +Q $EXE/cipbam015.gnt
echo
unset FF1
unset FF2
unset FF3
