#
. ./INITenvironnement.sh  
echo
echo "*** cipsigna04.sh ***" 
echo "    -----------    "  
echo "MAJ FSIGNAT_AG PAR LES PB "
echo 
# 
FF1=$FIC/fsignat_maj_jj      ; export FF1
FF2=$FIC/FSIGNAT_AG          ; export FF2
#
cobrun +Q $EXE/cipsigna04.gnt
unset FF1
unset FF2
echo
#
