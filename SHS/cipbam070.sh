#
. ./INITenvironnement.sh
export i=`date '+%y%m%d_%H%M%S'`                                        
#
echo
echo "MISE A JOUR CIPDEC_HISTBAM : HISTORIQUE DECLARATIONS "
echo
echo "*** cipbam070.sh ***" 
echo "    -----------    "
echo
# 
echo "LUS HISTORIQUE DECLARATIONS VEILLE :" `wc -l $FIC/CIPDEC_HISTBAM` 
echo "LUS HISTORIQUE DECLARATIONS jj     :" `wc -l $FIC/CIPDEC_HISTBAM_JJ` 
echo
FF1=$FIC/CIPDEC_HISTBAM             ; export FF1  
FF2=$FIC/CIPDEC_HISTBAM_JJ          ; export FF2
#
cobrun +Q $EXE/cipbam070.gnt
#
unset FF1
unset FF2  
echo
echo "ARCHIVAGE DECLARATIONS APRES MAJ :" `wc -l $FIC/CIPDEC_HISTBAM`
echo
