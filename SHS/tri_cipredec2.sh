. ./INITenvironnement.sh
#
echo "   tri_cipredec2.sh   "
echo "   -------------"
echo "TRI INCIDENTS REJETES"  
echo
#
#
mfsort SORT FIELDS \(15,24,CH,A,41,16,CH,A,59,1,CH,A\) USE $FIC/REDECLARATION_MOUHCINE  ORG LS RECORD F,59 GIVE $FIC/REJET_CTR_INC ORG LS RECORD F,59
#
echo  
echo "LUS         :" `wc -l $FIC/REDECLARATION_MOUHCINE` 
echo "SORTIE TRI  :" `wc -l $FIC/REJET_CTR_INC`
echo
#----------------------------------------------------------------#
                                                                                                                                                                                                                                                                                                                                               