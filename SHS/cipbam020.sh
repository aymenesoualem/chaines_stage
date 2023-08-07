#
. ./INITenvironnement.sh
#
echo "*** cipbam020.sh ***" 
echo "------------------"
echo "MAJ FCIPLOC POUR REDECLARATION"
echo "TYPE AC ET RC EN IC POUR REDEC REGUL"
echo
FF1=$FIC/FCIPLOC_REDEC       ; export FF1
FF2=$TMP/FCIPLOC        ; export FF2

echo
#
cobrun +Q $EXE/cipbam020.gnt
echo
unset FF1
unset FF2
unset FF3
