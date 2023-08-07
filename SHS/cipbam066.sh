#
. ./INITenvironnement.sh
echo
echo
echo "*** cipbam066.sh ***"
echo "    -----------    "
echo "MAJ FCIPBAM PAR FCIPLOC "
echo
#
FF0=$FIC/DATCONSOLE           ; export FF0
FF1=$FIC/FCIPLOC              ; export FF1
FF2=$FIC/FCIPCONF             ; export FF2
#
cobrun +Q $EXE/cipbam066.gnt
#
unset FF0
unset FF1
unset FF2
echo
#----------------------------------------------------------------------#
