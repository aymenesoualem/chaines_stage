#
. ./INITenvironnement.sh
echo
echo "*** cipbam130.sh ***" 
echo "    -----------    "
echo "REMISE EN PLACE FICH INTERDIT APRES MAJ PAR LES RETOURS BAM " 
FF1=$FIC/cip_interdit          ; export FF1
FF2=$FIC/INTERDIT_CIP          ; export FF2
#
cobrun +Q $EXE/cipbam130.gnt
#
unset FF1
unset FF2
#