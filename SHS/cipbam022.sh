. ./INITenvironnement.sh
echo
echo "*** cipbam022.sh ***" 
echo "    -----------    "
echo
echo "DECLARATION INCIDENTS DE PAIEMENT   A ENVOYER A BAM"
echo
FF0=$FIC/DATCONSOLE                ; export FF0
FF1=$FIC/cip_decinc_pxx            ; export FF1
FF2=$FIC/WFPIVOT                   ; export FF2
FF3=$FIC/FSCIP                     ; export FF3
FF4=$FIC/FSCIP2                    ; export FF4
FF5=$FIC/FSCIP3                    ; export FF5
FF6=$FIC/FSIGNAT_AG                ; export FF6
FF7=$FIC/param_ycodpays            ; export FF7
FF8=$FIC/FVIL_TRIBUNAL             ; export FF8
FF9=$FIC/param_socioprofes.txt     ; export FF9
FF10=$FIC/param_sect_activite.txt  ; export FF10
FF11=$FIC/FCIPBAM                  ; export FF11
FF12=$FIC/TIERS_BURO               ; export FF12
FF13=$FIC/interdit_judiciaire.txt  ; export FF13
#   INPUT / OUTPUT                 
FF14=$FIC/CIP_HEDBAM               ; export FF14
FF15=$FIC/FCIPLOC                  ; export FF15
#   OUTPUT                         
FF16=$FIC/FCLIENT_CIPJJ            ; export FF16
FF17=$FIC/FCOMPTE_CIPJJ            ; export FF17
FF18=$FIC/FIPS_CIPJJ               ; export FF18
FF19=$LST/CIP_ANO_DEC              ; export FF19
FF20=$TMP/HISTBAM_CIPJJ            ; export FF20
#
#   INPUT / OUTPUT                                             
FF21=$FIC/FTABPM                  ; export FF21             
#
cobrun +Q $EXE/cipbam022.gnt
#
unset FF0
unset FF1
unset FF2
unset FF3
unset FF4
unset FF5
unset FF6
unset FF7
unset FF8
unset FF9
unset FF10
unset FF11
unset FF12
unset FF13
unset FF14
unset FF15
unset FF16
unset FF17
unset FF18
unset FF19
unset FF20 
unset FF21 
