#
. ./INITenvironnement.sh    
echo
echo "*** cipsigna_tri03.sh ***" 
echo "    ------------    "
echo "TRI PXX   POUR MAJ SIGNATAIRES" 
mfsort SORT FIELDS \(1,3,CH,A,4,21,CH,A\) USE $FIC/sem_inc020_incpxx ORG LS RECORD F,128 GIVE $TMP/pbx_fsignat01 ORG LS RECORD F,128
#-----------------------------------------------------------------------#
echo "Nombre PB LUS   :" `wc -l $FIC/sem_inc020_incpxx`
echo "NB SORTIE TRI   :" `wc -l $TMP/pbx_fsignat01`
echo
#