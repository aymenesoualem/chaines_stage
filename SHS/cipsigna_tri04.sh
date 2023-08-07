#
. ./INITenvironnement.sh    
echo
echo "*** cipsigna_tri04.sh ***" 
echo "    ------------    "
echo "TRI PXX   POUR MAJ SIGNATAIRES" 
mfsort SORT FIELDS \(4,21,CH,A,1,3,CH,A\) USE $TMP/pbx_fsignat02 ORG LS RECORD F,128 GIVE $TMP/pbx_fsignat03 ORG LS RECORD F,128
#-----------------------------------------------------------------------#
echo "Nombre PB LUS   :" `wc -l $TMP/pbx_fsignat02`
echo "NB SORTIE TRI   :" `wc -l $TMP/pbx_fsignat03`
echo
#