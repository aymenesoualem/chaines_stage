#
. ./INITenvironnement.sh
echo
echo                                                                            
echo "*** cipbamechu.sh ***"                                                     
echo "    -----------    "                                                      
echo "PURGEMENT DES INCIDENTS ECHUS"                                                 
echo                                                                            
#                                                                               
##ORI FF0=$FIC/DATCONSOLE           ; export FF0                                      
FF0=$FIC/DATCONSOLE1          ; export FF0                                      
##ORI FF1=$FIC/FCIPBAM              ; export FF1                                      
##ORI FF2=$TMP/FCIPBAM_NECHU        ; export FF2  
##ORI FF3=$TMP/FCIPBAM_ECHU         ; export FF3
##ORI FF4=$LST/FCIPBAM_ECHU         ; export FF4                                    
FF1=$FIC/FCIPCONF              ; export FF1                                      
FF2=$TMP/FCIPCONF_NECHU        ; export FF2  
FF3=$TMP/FCIPCONF_ECHU         ; export FF3
FF4=$LST/FCIPCONF_ECHU         ; export FF4                                    
#                                                                               
cobrun +Q $EXE/cipbamechu.gnt                                                    
#                                                                               
unset FF0                                                                       
unset FF1                                                                       
unset FF2 
unset FF3
unset FF4                                                                      
echo                                                                        
#----------------------------------------------------------------------#        
