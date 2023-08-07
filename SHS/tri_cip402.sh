#
. ./INITenvironnement.sh
echo   "     tri_cip402.sh  "
echo   "     -------------  "
echo   "TRI FUSION DE TOUTES LES DECLARATIONS PXX"
echo
#
cat /dev/null/ > $TMP/cip_inc_pxx
#mma le 09/04/2015 : ne pas traiter le transfert de compte 7800036248001056142 , analyse en cours
#awk '{ FS="" } {if (substr($0,04,19)!= "7800036248001056142" &&  substr($0,04,19)!= "7930068248001056101")   print $0}' $FIC/inc_trsf_cpte  > $FIC/cip_decinc_pxx_redec
#
cat  $FIC/inc_dec_agence       >> $TMP/cip_inc_pxx
cat  $FIC/inc_trsf_cpte        >> $TMP/cip_inc_pxx
cat  $FIC/incp46_chqrecu       >> $TMP/cip_inc_pxx
cat  $MVT/MAJ_IDP_CIP_ORA.TXT  >> $TMP/cip_inc_pxx
cat  $FIC/cip_decinc_pxx_redec >> $TMP/cip_inc_pxx
#-------------------------------------------------------
echo
echo "*** tri_cip402.sh ***"
echo "    -----------    "
echo
echo "TRI APRES TRANSFERT DE COMPTE P12 ET P18  "
mfsort SORT FIELDS \(4,19,CH,A,23,7,CH,A,1,3,CH,A,110,2,CH,A\) USE $TMP/cip_inc_pxx ORG LS RECORD F,128 GIVE $FIC/cip_decinc_pxx  ORG LS RECORD F,128
#-----------------------------------------------------------------------#                                                                                                                                                                                                                                             
echo "ENTREE TRI    : " `wc -l $FIC/cip_decinc_pxx_redec`
echo "ENTREE TRI    : " `wc -l $FIC/inc_dec_agence`
echo "ENTREE TRI    : " `wc -l $FIC/inc_trsf_cpte`
echo "ENTREE TRI    : " `wc -l $FIC/incp46_chqrecu`
echo "ENTREE TRI    : " `wc -l $MVT/MAJ_IDP_CIP_ORA.TXT`
echo                                                                                                                                                                                                                                                              
echo "SORTIE TRI    : " `wc -l $FIC/cip_decinc_pxx`
echo
#
### initialiser fichier des redeclaration à la demande (secours)
### en cas d'oubli de trame
cat /dev/null/ > $FIC/cip_decinc_pxx_redec
#
