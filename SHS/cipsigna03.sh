#
. ./INITenvironnement.sh  
#
echo
echo "*** cipsigna03.sh ***" 
echo "    -----------    "  
echo "MISE A JOUR DES SIGNATAIRES PAR LES PB "
echo 
FF0=$FIC/DATCONSOLE          ; export FF0   
FF1=$TMP/pbx_fsignat03       ; export FF1
FF2=$FIC/FSIGNAT_AG          ; export FF2
FF3=$FIC/WFPIVOT             ; export FF3
FF4=$FIC/FSCIP               ; export FF4
FF5=$FIC/fsignat_maj_jj      ; export FF5
FF6=$LST/CIPSIGNA03_ANO   ; export FF6
#
cobrun +Q $EXE/cipsigna03.gnt
unset FF0
unset FF1
unset FF2
unset FF3
unset FF4
unset FF5
unset FF6
echo
#
