. ./INITenvironnement.sh
echo
echo " ==> D: y3telb25    ...  $(date)"
echo "*** y3telb25.sh ***" 
echo "    --------------"
echo " - SELECTION SOLDES ETBAC "
echo
FF1=$FIC/Y3SOLCL            ; export FF1
FF2=$FIC/FTELCMP            ; export FF2
FF3=$FIC/YCATEGO            ; export FF3  
FF4=$TMP/prm_soldes_etbac   ; export FF4 
FF5=$TMP/tmp_ftelcmp-cpt-u  ; export FF5 
cobrun +Q $EXE/y3telb25.gnt
wcoderr=$?
#
unset FF1
unset FF2
unset FF3
unset FF4
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : y3telb25.sh, PRG terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi

mfsort SORT FIELDS \(1,29,CH,A\) USE $TMP/prm_soldes_etbac ORG LS RECORD F,90 GIVE $FIC/prm_soldes_etbac ORG RL RECORD F,90
##sort -u +0.1 -0.90 $TMP/prm_soldes_etbac > $FIC/prm_soldes_etbac
wcoderr=$?
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : y3telb25.sh, TRI terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
echo " NBR ENTREE TRI : " `wc -l $TMP/prm_soldes_etbac`
echo " NBR SORTIE TRI : " `wc -l $FIC/prm_soldes_etbac`

rm -f $TMP/prm_soldes_etbac
rm -f $TMP/tmp_ftelcmp-cpt-u
echo " ==> F: y3telb25    ...  $(date)"
