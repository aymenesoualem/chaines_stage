#
. ./INITenvironnement.sh
echo
echo "*** cipbam200.sh ***" 
echo "    -----------    "
echo "MAJ HEADER CIP_HEDBAM COMPTEURS DE DEMARRAGE ET NO DE LOT "
echo
FF0=$FIC/DATCONSOLE           ; export FF0
FF1=$FIC/CIP_HEDBAM           ; export FF1
FF2=$LST/CIP_HEADER_DEC       ; export FF2
#
cobrun +Q $EXE/cipbam200.gnt

unset FF0
unset FF1
unset FF2
#