. ./INITenvironnement.sh
echo
echo "*** cipbam310.sh ***" 
echo "    -----------    "
echo "LISTE DES COMPTES INCIDENTE AVEC LEUR DERNIER NUMERO DE RANG"
###HMA190528 awk '{ FS="" } {if (substr($0,68,02)=="AC" || substr($0,68,02)=="IC" || substr($0,68,02)=="RC") print $0}' $FIC/FCIPLOC > $TMP/FCIPLOC.txt
###HMA190528 wc -l $TMP/FCIPLOC.txt
###HMA190528 mfsort SORT FIELDS \(01,19,CH,A,345,01,CH,A\) USE $TMP/FCIPLOC.txt ORG LS RECORD F,473 GIVE $TMP/FCIPLOC2.txt ORG LS RECORD F,473
###HMA190528 wc -l $TMP/FCIPLOC2.txt
###HMA190528 FF1=$TMP/FCIPLOC2.txt          ; export FF1
###HMA190528 FF2=$TMP/FCIPLOC_RANG          ; export FF2
###HMA190528 #
###HMA190528 cobrun +Q $EXE/cipbam310.gnt
###HMA190528 rebuild $TMP/FCIPLOC_RANG,$FIC/FCIPRANG -o:lseq,ind -t:c-isam -r:f20 -k:1+19
###HMA190528 unset FF1
###HMA190528 unset FF2

###HMA190528 nouvelle regéle implémenter pour corriger le rang
wdtj=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,5,4) substr($0,3,2) substr($0,1,2) }' $FIC/DATCONSOLE)
echo " !!! date console : " ${wdtj}
awk '{ FS="" } {if (substr($0,239,8)>"'"$wdtj"'") print $0}' $FIC/FCIPLOC > $TMP/FCIPLOC_IC.ts0
awk '{ FS="" } {if (substr($0,68,2)=="IC" && substr($0,345,1)!=" ") print $0}' $TMP/FCIPLOC_IC.ts0 > $TMP/FCIPLOC_IC.ts1
mfsort SORT FIELDS \(01,19,CH,A,345,01,CH,A\) USE $TMP/FCIPLOC_IC.ts1 ORG LS RECORD F,473 GIVE $TMP/FCIPLOC_IC.ts2 ORG LS RECORD F,473
echo
echo "     - FCIPLOC, Nombre ligne global     : " `wc -l $FIC/FCIPLOC`
echo "     - FCIPLOC, Nombre ligne IC non echu: " `wc -l $TMP/FCIPLOC_IC.ts0`
echo "     - FCIPLOC, Nombre ligne IC         : " `wc -l $TMP/FCIPLOC_IC.ts1`
echo "     - FCIPLOC, Nombre ligne IC (tri)   : " `wc -l $TMP/FCIPLOC_IC.ts2`

FF1=$TMP/FCIPLOC_IC.ts2        ; export FF1
FF2=$TMP/FCIPLOC_RANG          ; export FF2
cobrun +Q $EXE/cipbam310.gnt
unset FF1
unset FF2

rebuild $TMP/FCIPLOC_RANG,$FIC/FCIPRANG -o:lseq,ind -t:c-isam -r:f20 -k:1+19

rm -f $TMP/FCIPLOC_IC.ts0 $TMP/FCIPLOC_IC.ts1
