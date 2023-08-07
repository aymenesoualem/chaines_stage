. ./INITenvironnement.sh
#
echo "   tri_cipredec3.sh   "
echo "   -------------"
#    "TRAMES CREEES DANS jcipredec1.sh"
#
echo
#
mfsort SORT FIELDS \(4,19,CH,A,23,7,CH,A,1,3,CH,A,110,2,CH,A\) USE $FIC/cipredec_rejet_px ORG LS RECORD F,128 GIVE $FIC/cip_decinc_pxx  ORG LS RECORD F,128
echo "ENTREE TRI    : " `wc -l $FIC/cipredec_rejet_px`
echo "SORTIE        : " `wc -l $FIC/cip_decinc_pxx`
echo
echo 'VERIFIER LE NOMBRE AVANT DE CONTINUER SVP  ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#                                                                                    