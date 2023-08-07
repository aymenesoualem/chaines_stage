. ./INITenvironnement.sh
#
echo "   tri_cip203.sh   "
echo "-------------------"
echo "TRI TEMP INTERDIT_CIP" 
#
mfsort SORT FIELDS \(1,16,CH,A\) USE $TMP/INTERDIT_CIP ORG LS RECORD F,280 GIVE $FIC/cip_interdit ORG LS RECORD F,280
#
echo
echo "INTERDITS BANCAIRES   :" `wc -l $TMP/INTERDIT_CIP`
echo "SORTIE TRI            :" `wc -l $FIC/cip_interdit`
echo
#----------------------------------------------------------------#
