#
. ./INITenvironnement.sh
#
echo "*** cipbam016.sh ***" 
echo "------------------"
echo "HISTORIQUE INCIDENTS BMCE + CONF  ---> FCIPCBAM "
echo
#
FF1=$FIC/FCIPCONF             ; export FF1
FF2=$FIC/FCIPBAM              ; export FF2
echo
#
cobrun +Q $EXE/cipbam016.gnt
echo
unset FF1
unset FF2
echo

