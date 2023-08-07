. ./INITenvironnement.sh
#
echo "   tri_cip201.sh   "
echo "-------------------"
echo "TRI DU FICHIER TEMP FINCLOC GENERE" 
#
mfsort SORT FIELDS \(1,33,CH,A,34,13,CH,A\) USE $TMP/FCIPLOC ORG LS RECORD F,473 GIVE $TMP/FCIPLOC_TRI ORG LS RECORD F,473
#
echo
echo "incidents bmce lus    :" `wc -l $TMP/FCIPLOC`
echo "incidents bmce tries  :" `wc -l $TMP/FCIPLOC_TRI`
echo
#----------------------------------------------------------------#
