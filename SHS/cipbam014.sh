#
. ./INITenvironnement.sh
#
echo "*** cipbam014.sh ***" 
echo "------------------"
echo "HISTORIQUE INCIDENTS BMCE   ---> FCIPCLOC "
echo "HISTORIQUE INCID. CONFRERES ---> FCIPCONF "
echo
#
FF1=$FIC/FCIPBAM            ; export FF1
FF2=$FIC/FCIPCONF           ; export FF2
FF3=$TMP/FCIPLOC            ; export FF3
echo
#
cobrun +Q $EXE/cipbam014.gnt
echo
unset FF1
unset FF2
unset FF3
echo

