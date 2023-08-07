#
#
. ./INITenvironnement.sh
echo "    tri_cip501.sh  "                                                                                                                                                                                                                                                                                                                                                                       
echo "    -------------  "                                                                                                                                                                                                                                                                                                                                                                       
echo                                                                                                                                                                                                                                                                                                                                                                                           
echo "TRI FCIPLOC  (BMCE) POUR MAJ FCIPBAM (HISTO BMCE ET CONFRERES) "  
#                                                                                                                                                                                                                                                                                                                       
mfsort SORT FIELDS \(34,52,CH,A\) USE $FIC/FCIPLOC ORG LS RECORD F,473  GIVE $TMP/tem_ciploc_maj ORG LS RECORD F,473                                                                                                                                                                                                                                                   
#-----------------------------------------------------------------------#                                                                                                                                                                                                                                                                                                                      
#                                                                                                                                                                                                                                                                                                                                                                                              
echo "ENTREE FCIPLOC : " `wc -l $FIC/FCIPLOC`                                                                                                                                                                                                                                                                                                                                                 
echo "SORTIE TRI     : " `wc -l $TMP/tem_ciploc_maj`    
read a                                                                                                                                                                                                                                                                                                                                      
#-----------------------------------------------------------------------#   






