. ./INITenvironnement.sh
#
echo "   tri_cipredec1.sh   "
echo "   -------------"
echo "TRI NOUVELLE BASE"  
echo
#
#
mfsort SORT FIELDS \(1,36,CH,A\) USE $TMP/CIPBAM_REDEC  ORG LS RECORD F,479 GIVE $TMP/CIPBAM_REDEC_TRI ORG LS RECORD F,479
#
echo  
echo "LUS         :" `wc -l $TMP/CIPBAM_REDEC` 
echo "SORTIE TRI  :" `wc -l $TMP/CIPBAM_REDEC_TRI`
echo
#----------------------------------------------------------------#
rebuild $TMP/CIPBAM_REDEC_TRI,$FIC/CIPBAM_REDEC -o:lseq,ind -t:c-isam -r:f479 -k:1+36                                                                                                                                                                                                                                                                                                                                                   