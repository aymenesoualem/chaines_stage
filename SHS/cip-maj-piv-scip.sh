#                                                        
. ./INITenvironnement.sh                                 
echo                                                     
echo "*** cip-maj-piv-scip.sh ***"                       
echo "    -----------    "                               
echo "MISE à JOUR DES TABLES PIVOT, SCIP, SCIP2 ET SCIP3"
echo                                                     
FF1=$FIC/CIP_JJ.TXT          ; export FF1                        
FF10=$FIC/WFPIVOT            ; export FF10
FF11=$FIC/FSCIP              ; export FF11                       
FF12=$FIC/FSCIP2             ; export FF12
FF13=$FIC/FSCIP3             ; export FF13
FF14=$FIC/CIP_JJ_FREJET      ; export FF14
cobrun +Q $EXE/cip-maj-piv-scip.gnt                      
#                                                        
unset FF1                                                
unset FF11
unset FF12
unset FF13                                               
unset FF14
#                                                        