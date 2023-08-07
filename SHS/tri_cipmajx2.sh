#
. ./INITenvironnement.sh
#
echo
echo "    tri_cipmajx2.sh  "
echo "    -------------  "
echo
echo "TRI FCIPLOC  (BMCE) POUR MAJ FCIPBAM (HISTO BMCE ET CONFRERES) "
#
mfsort SORT FIELDS \(34,52,CH,A\) USE $FIC/FCIPLOC ORG LS RECORD F,473  GIVE $TMP/ciploc_majx ORG LS RECORD F,473
#-----------------------------------------------------------------------#
#
echo "ENTREE FCIPLOC : " `wc -l $FIC/FCIPLOC`
echo "SORTIE TRI     : " `wc -l $TMP/ciploc_majx`
read a
#
echo
