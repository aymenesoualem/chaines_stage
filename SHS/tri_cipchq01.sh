. ./INITenvironnement.sh
###HMA210602 : eliminer les lignes vide détecté sur la taile des enrigistrement (122 et non 123)
#
#
echo "   tri_cipchq01.sh   "
echo "-------------------"
echo "TRI FUSION CHEQ RECUS GUICHET ET COMPENS " 
#
###HMA210602
cat /dev/null/ > $TMP/FCHQRECU.ts0

###HMA210602 cat $MVT/fluxcip_chqgui        > $TMP/FCHQRECU
###HMA210602 cat $MVT/fluxcip_chqcompens   >> $TMP/FCHQRECU
cat $MVT/fluxcip_chqgui        > $TMP/FCHQRECU.ts0
cat $MVT/fluxcip_chqcompens   >> $TMP/FCHQRECU.ts0
# 
###HMA210602
awk '{ FS="" } {print substr($0,1,122)}' $TMP/FCHQRECU.ts0  > $TMP/FCHQRECU
#
mfsort SORT FIELDS \(16,24,CH,A,44,7,CH,A\) USE $TMP/FCHQRECU ORG LS RECORD F,122 GIVE $FIC/FCHQRECU ORG LS RECORD F,122
#
echo
echo "LUS CHQ RECUS GUICHET          : " `wc -l $MVT/fluxcip_chqgui`
echo "LUS CHQ RECUS COMPENSATION     : " `wc -l $MVT/fluxcip_chqcompens`
echo "SORTIE TRI                     : " `wc -l $FIC/FCHQRECU`
echo
