#
#  
. ./INITenvironnement.sh  
echo "   tri_cip403.sh   "
echo "   -------------"
#    "TRAMES SAISIE DTV "
#
echo
#
mfsort SORT FIELDS \(4,19,CH,A,23,7,CH,A,1,3,CH,A,110,2,CH,A\) USE $MVT/MAJ_IDP_CIP_ORA.TXT ORG LS RECORD F,128 GIVE  $FIC/cipredec_dtv_px ORG LS RECORD F,128
echo "ENTREE TRI    : " `wc -l $MVT/MAJ_IDP_CIP_ORA.TXT`
echo "SORTIE        : " `wc -l $FIC/cipredec_dtv_px`
echo
echo 'VERIFIER LE NOMBRE AVANT DE CONTINUER SVP  ---> ENTER POUR CONTINUER '
#
