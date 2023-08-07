#
. ./INITenvironnement.sh
echo
echo "*** cipbam190.sh ***" 
echo "    -----------    "
echo "CHARGEMENT INTERDITS BANCAIRES A PARTIR DE FCIPBAM" 
echo
FF0=$FIC/DATCONSOLE            ; export FF0
FF1=$FIC/FCIPBAM               ; export FF1
FF2=$TMP/INTERDIT_CIP          ; export FF2
#
cobrun +Q $EXE/cipbam190.gnt
#
unset FF0
unset FF1
unset FF2

#