. ./INITenvironnement.sh
#
rm $FIC/CIPBAM_TOUT
rm $FIC/CIPBAM_TOUT.idx
#
echo "   tri_cipmajx3.sh   "
echo "   -------------"
echo "TRI INC NON REGULARISES"  
echo
#
#
mfsort SORT FIELDS \(1,29,CH,A\) USE $TMP/CIPBAM_TRAIT  ORG LS RECORD F,470 GIVE $TMP/CIPBAM_TRAIT2 ORG LS RECORD F,470
#
echo  
echo "LUS         :" `wc -l $TMP/CIPBAM_TRAIT` 
echo "SORTIE TRI  :" `wc -l $TMP/CIPBAM_TRAIT2`
echo
#----------------------------------------------------------------#
rebuild $TMP/CIPBAM_TRAIT2,$FIC/CIPBAM_TOUT  -o:lseq,ind -t:c-isam -r:f470 -k:1+29                                                                                                                                                                                                                                                                                                                                                   