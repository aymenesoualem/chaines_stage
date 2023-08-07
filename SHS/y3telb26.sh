. ./INITenvironnement.sh
echo
echo "*** y3telb26.sh ***" 
echo "    -----------    "
echo " - CREATION RELEVES ETBAC "
echo
FF1=$FIC/prm_soldes_etbac   ; export FF1
FF2=$FIC/prm_ycg030_cg25    ; export FF2
FF3=$FIC/FTELCMP            ; export FF3
FF4=$FIC/tem_ftelrel01      ; export FF4
FF5=$FIC/YCATEGO            ; export FF5  
FF6=$FIC/DATCONSOLE         ; export FF6  
FF7=$LOG/JY2ETBAC_010_dsp   ; export FF7 
FF8=$FIC/DATVEILLE          ; export FF8 
FF9=$FIC/FLIBDEV            ; export FF9
cobrun +Q $EXE/y3telb26.gnt
wcoderr=$?
#
unset FF1
unset FF2
unset FF3
unset FF4
unset FF5
unset FF6
unset FF7
unset FF8
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : y3telb26.sh, PRG terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
