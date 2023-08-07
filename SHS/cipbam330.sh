#---------------------------------------------------------------------#
# LE 11-12-2014                                                       #
# SCRIPT : cipbam330.sh                                               #
#                                                                     #
#---------------------------------------------------------------------#
. ./INITenvironnement.sh
#
FF1=$FIC/cip_decinc_pxx_let                      ; export FF1
FF2=$FIC/ADR_GRC                                 ; export FF2
FF3=$FIC/FNEWCFR                                 ; export FF3
FF4=$FIC/FSCIP                                   ; export FF4
FF5=$FIC/YCATEGO                                 ; export FF5
FF6=$FIC/FCIPLOC                                 ; export FF6
FF7=$TMP/POSTE_EDITION_01_LETTRE                 ; export FF7
FF8=$FIC/REJET_CIPBAM022                         ; export FF8

#
cobrun +Q $EXE/cipbam330_min.gnt
#
unset FF1
unset FF2
unset FF3
unset FF4
unset FF5
unset FF6
unset FF7
#
rm p_xeros_133_lettre_inj*
if test -s $TMP/POSTE_EDITION_01_LETTRE
then

echo "EDITION DES AVIS SOUSCRIPTION BDC POUR DOCUPRINT"

FF1=$TMP/POSTE_EDITION_01_LETTRE         ; export FF1
FF2=$FIC/FSCIP2                          ; export FF2
FF3=$FIC/p_xeros_133_lettre_inj_maroc    ; export FF3
FF4=$FIC/p_xeros_133_lettre_inj_agarder   ; export FF4
FF5=$FIC/p_xeros_133_lettre_inj_etrg     ; export FF5

cobrun +Q $EXE/edit-cpt-dormant-docuprint.gnt

unset FF1
unset FF2
unset FF3
unset FF4
unset FF5

echo "EDITION DES AVIS SOUSCRIPTION BDC DOCUBASE"
awk '{ FS="" } {print substr($0,48,133)}' $TMP/POSTE_EDITION_01_LETTRE > $FIC/archive_docubase_133_lettre_inj
else
echo " !!! FICHIER VIDE NON TRAITER " $TMP/POSTE_EDITION_01_LETTRE
fi