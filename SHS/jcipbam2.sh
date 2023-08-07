#    jcipbam2.sh     ex jincident2.sh
#
#    ALIMENTATION CIP PAR LES DECLARATIONS SUIVANTES :
#
#    - TRAMES SAISIE AGENCE         :  P1X
#    - TRAMES SAISIE DTV            :  P3X
#    - TRAMES GENEREES EN CENTRAL   :  P4X
#         P48 : ANNULATION INCIDENT ANCIEN CPTE SI TRANSFERT DE COMPTE
#         P41 : REDECLARATION INCIDENT NOUVEAU COMPTE
#         P42 : REDECLARATION REGUL NOUVEAU COMPTE
#         P46 : ANNULATION INFRACTION TRANSFERT CPTE : ANCIEN COMPTE
#         P46 : DECLARATION INFRACTION SI CHEQUE REGLE CE JOUR ET
#               CLIENT AYANT DES INCIDENTS
#  DEMARRAGE LE 22-05-2012 AU SOIR
#  TRANSFERT DE COMPTE ACTIVE LE 08-06-2012
#  TEST UNICITE CLI LE 09-07-2012
#
#  SCRIPT  MODIFIE EN ATTENTE REDECLARATION REJET INC,REGUL,ANNULAION CODE C
#  -HMA1 : 26/07/2013 declaration infraction en double
#     elimination des infraction en double (type N) du fichier IPS
#*************************************************************
#
#*************************************************************
# DATE       ! AUTEUR  !      NATURE MODIFICATION            *
#*************************************************************
# 14/09/2015 !  MMA00  !  MISE EN PLACE EVOLUTION LETTRE     *
#                      !  INJONCTION + AJOUT RA              *
#*************************************************************
#
. ./INITenvironnement.sh
export k=`date '+%d%m%y'`
export i=`date '+%y%m%d_%H%M%S'`
#-----------------------------------------------------------------#
#  LIBELLE DU TITRE JCL INCIDENTS
$SHS/tit_cip2.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#
#----------------------------------------------------------------------#
$SHS/verifdate.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
# VERIF  SAISIE DATE DE TRAITEMENT DANS jy2fuca.sh
#
echo 'verifdate.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '
read a
#
#-----  HAKIM -----------------------------------------------------#
#    EXTRACTION  (TRAME DECLARATION DTV) P31,P32,P36,P38
#
$SHS/unload_cip.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#      ENTREE : BASE DONNEES CENTRAL (INCIDENT_PAIEMENT_TRANS)
#
#      SORTIE : $MVT/MAJ_IDP_CIP_ORA.TXT
#
echo 'FIN unload_cip.sh    RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#--------------------------------------------------------------#
#  SELECTION DES P11,P12,P18  --->  DE LA TRANSMISSION AGENCE
#  IGNORER PA , PB
#  IGNORER P11  RANG > ZERO DES CO-TITULAIRES POUR CATG 3 PERS MORALE
#  IGNORER P16 : INFRACTION AGENCE GENEREE  LORS DE L' ALIMENTAION
#     PGM  : y2selcip.eco
#
$SHS/y2selcip.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#      ENTREE : FF1=$FIC/sem_inc020_incpxx
#      ENTREE : FF2=$FIC/FSCIP
#
#      SORTIE : FF3=$FIC/inc_dec_agence
#      SORTIE : FF4=$LST/CIP_TRAME_IGNORE
#
#
echo 'FIN y2selcip RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#--------------------------------------------------------------#
#### info : MAj Mme ZAHIR le 09/07/2012 : ?????
####    A GARDER SVP IMPORTANT POUR CHARGER JUSTE LE CLI DE LA JOURNEE
####  POUR DELETER LA TABLE AVANT CHARGEMENT DU CLI DE LA JOURNEE
###
###
echo " DELETE FTABPM AVANT CHARGEMENT CLI DE LA JOURNEE "
rm  $FIC/FTABPM
rm  $FIC/FTABPM.idx
echo " FIN DELETE FTABPM "
echo
#-----------------------------------------------------------------#
echo "CREATION 1ER ENRG FTABPM "
rebuild $FIC/FTABPM_VIDE,$FIC/FTABPM -o:lseq,ind -t:c-isam -r:f53 -k:1+12
echo "FIN CREATION INDEX FTABPM "
echo
#
#    EXTRACTION MOUVEMENT RETRAIT CHQ GUICHET "
#    PGM : cipchqgui01.eco   EXTRACTION
#    PGM : cipchqgui02.eco   SUPPRESSION DES DOUBLONS
#
$SHS/cipchqgui.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#      ENTREE : FF1=$FIC/prm_ycg030_cg25
#
#      SORTIE : FF2=$MVT/fluxcip_chqgui
#
#
echo 'FIN cipchqgui.sh    RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#-----  HAKIM -----------------------------------------------------#
# A DESCATIVER APRES (AGENCE ENVOIT LE FICHIER SUR TSM-SRV-SY /vse/MVT)
#    RECUPERATION MOUVEMENT RETRAIT CHQ COMPENSE
#    SCRIPT : ftp_cipchq01.sh
echo " MISE EN PLACE FICHIER CHQ COMPENSE TRANSFERER PAR L AGENCE "
echo "   ftp_cipchq01.sh   "
echo "-------------------"
$SHS/ftp_cipchq01.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
echo 'FIN ftp_cipchq01.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
#      TRI FUSION CHEQ RECUS GUICHET ET COMPENS
#
$SHS/tri_cipchq01.sh  > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#      ENTREE : $MVT/fluxcip_chqgui
#      ENTREE : $MVT/fluxcip_chqcompens
#
#      SORTIE : $FIC/FCHQRECU
#
echo 'FIN tri_cipchq01.sh  RELEVER LES COMPTEURS ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
#
#    "CREATION P46 SI CHQRECU GUICHET OU COMPENS ET PRESENCE INCIDENT  "
#    CODE STATUT '0' DECLARATION INFR
#    PGM : cipbam018.gnt
#
$SHS/cipbam018.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$FIC/FCIPLOC
#    ENTREE : FF2=$FIC/FCHQRECU
#
#    SORTIE : FF3=$FIC/incp46_chqrecu
#
echo 'FIN cipbam018.sh RELEVER LES COMPTEURS ---> ENTER POUR CONTINUER '
read a
#
#--------------------------------------------------------------#
##   CHANGEMENT POUR REDECLARATION LE 03-09-2012 EN ATTENTE MISE EN PROD
#
echo "DELETE FCIPCONF avant trait jj "
rm $FIC/FCIPCONF
rm $FIC/FCIPCONF.idx
#
#--------------------------------------------------------------#
echo  "SAVE  HISTORIQUE INCIDENTS BMCE ---> PREPARATION  FICH FCIPLOC "
#     PGM  : cipbam014.eco
#
$SHS/cipbam014.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#      ENTREE : FF1=$FIC/FCIPBAM
#      SORTIE : FF2=$FIC/FCIPCONF
#      SORTIE : FF3=$TMP/FCIPLOC
#
#
echo 'FIN cipbam014.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
#read a
#
#--------------------------------------------------------------#
echo  "TRI INCIDENTS BMCE EN COURS ..."
#
$SHS/tri_cip201.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$TMP/FCIPLOC
#    SORTIE : FF2=$TMP/FCIPLOC_TRI
#
echo 'FIN tri_cip201.sh RELEVER LES COMPTEURS ---> ENTER POUR CONTINUER '
#read a
#
#--------------------------------------------------------------#
rm $FIC/FCIPLOC_REDEC
rm $FIC/FCIPLOC_REDEC.idx
#
#--------------------------------------------------------------#
echo  "GENERATION FCIPLOC INDEXE (INCIDENTS BMCE UNIQUEMENT ) "
#     PGM  : cipbam015.eco
#
$SHS/cipbam015_redec.sh  > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$TMP/FCIPLOC_TRI
#
#    SORTIE :  FF2=$FIC/FCIPLOC_REDEC
#    SORTIEE : FF3=$TMP/FCIPLOC_DOUBLE
#
echo 'FIN cipbam015_redec.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#---------------------------------------------------------------#
#    "TRAMES DTV "
#
echo  "TRI INCIDENTS BMCE EN COURS ..."
#
$SHS/tri_cip403.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$MVT/MAJ_IDP_CIP_ORA.TXT
#    SORTIE : FF2=$FIC/cipredec_dtv_px
#
echo 'FIN tri_cip403.sh RELEVER LES COMPTEURS ---> ENTER POUR CONTINUER '
read a
#
#--------------------------------------------------------------#
echo  "MAJ FCIPLOC_REDEC PAR LES TRAMES REDEC POUR CORRECTION "
#     PGM  : cipbam019.eco
#
$SHS/cipbam019.sh  > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$FIC/cipredec_dtv_px
#
#    I/O    :  FF2=$FIC/FCIPLOC_REDEC
#
echo 'FIN cipbam019.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#---------------------------------------------------------------#
echo  "GENERATION FCIPLOC INDEXE (INCIDENTS BMCE UNIQUEMENT ) "
#     PGM  : cipbam020.eco
#
$SHS/cipbam020.sh  > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE :  FF1=$FIC/FCIPLOC_REDEC
#
#    SORTIE :  FF2=$TMP/FCIPLOC
#
echo 'FIN cipbam020.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#---------------------------------------------------------------#
echo  "TRI INCIDENTS BMCE EN COURS ..."
#
$SHS/tri_cip201.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$TMP/FCIPLOC
#    SORTIE : FF2=$TMP/FCIPLOC_TRI
#
echo 'FIN tri_cip201.sh RELEVER LES COMPTEURS ---> ENTER POUR CONTINUER '
#read a
#
#--------------------------------------------------------------#
rm $FIC/FCIPLOC
rm $FIC/FCIPLOC.idx
#
#--------------------------------------------------------------#
echo  "GENERATION FCIPLOC INDEXE (INCIDENTS BMCE UNIQUEMENT ) "
#     PGM  : cipbam015.eco
#
$SHS/cipbam015.sh  > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$TMP/FCIPLOC_TRI
#
#    SORTIE :  FF2=$FIC/FCIPLOC
#    SORTIEE : FF3=$TMP/FCIPLOC_DOUBLE
#
echo 'FIN cipbam015 RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#---------------------------------------------------------------#
# "TRANSFERT DE COMPTE INCIDENTS BMCE + REGUL  "
# "ANNULATION SI INFRACTION CPTE TRANSFERE"
#    TRAMES P48, P41,P42, P46
#
#    PGM : ciptrsf01.eco
#
echo "TRANSFERT DE COMPTE INCIDENTS  EN COURS "
#
$SHS/ciptrsf01.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#     ENTREE : FF0=$FIC/DATCONSOLE
#     ENTREE : FF1=$FIC/FSCIP
#     ENTREE : FF2=$FIC/FCIPBAM
#     ENTREE : FF3=$FIC/FCIPLOC
#     ENTREE : FF4=$FIC/MATRDWH
#
#     SORTIE : FF5=$LST/CIP_TRSF_CPTE
#     SORTIE : FF6=$FIC/inc_trsf_cpte
#
#
echo 'FIN ciptrsf01.sh    RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#--------------------------------------------------------------#
#
#
######
#    TRI FUSIONS DES DECLARATIONS A ENVOYER A BAM
#    - TRAMES SAISIE AGENCE                      :  P10, P11, P12, P18 (P16 IGNOREE)
#
#    - TRAMES SAISIE DTV  NOUVELLE APPLICATIF     :       P31, P32, P36, P38
#
#    - TRAMES GENEREES EN CENTRAL                :  P4X
#         P48 : ANNULATION INCIDENT ANCIEN CPTE SI TRANSFERT DE COMPTE
#         P41 : REDECLARATION INCIDENT NOUVEAU COMPTE
#         P42 : REDECLARATION REGUL NOUVEAU COMPTE
#         P46 : ANNULATION INFRACTION ANCIEN COMPTE
#         P16 : DECLARATION INFRACTION SI CHEQUE REGLE CE JOUR ET
#               CLIENT AYANT DES INCIDENTS
#
$SHS/tri_cip402.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#        ENTREE : $FIC/inc_dec_agence
#        ENTREE : $FIC/inc_trsf_cpte
#        ENTREE : $FIC/incp46_chqrecu
#        ENTREE : $MVT/MAJ_IDP_CIP_ORA.TXT
#
#        SORTIE : $FIC/cip_decinc_pxx
#
echo 'FIN tri_cip402.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#-----MMA00  LE 14-06-2015----------------------------------------------#
$SHS/cipbam340.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
echo 'FIN cipbam340.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#-----------------------------------------------------------------------#
#   PREPARATION FICHIERS DECLARATIONS INCIDENTS POUR ALIMENTATION CIP
#   version cipbam022.eco
#
$SHS/cipbam022.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#       INPUT
#    FF0=$FIC/DATCONSOLE
#    FF1=$FIC/cip_decinc_pxx
#    FF2=$FIC/WFPIVOT
#    FF3=$FIC/FSCIP
#    FF4=$FIC/FSCIP2
#    FF5=$FIC/FSCIP3
#    FF6=$FIC/FSIGNAT_AG
#    FF7=$FIC/param_ycodpays
#    FF8=$FIC/FVIL_TRIBUNAL
#    FF9=$FIC/param_socioprofes.txt
#    FF10=$FIC/param_sect_activite.txt
#    FF11=$FIC/FCIPBAM
#    FF12=$FIC/TIERS_BURO
#    FF13=$FIC/interdit_judiciaire.txt
#
#      INPUT / OUTPUT
#    FF14=$FIC/CIP_HEDBAM
#    FF15=$FIC/FCIPLOC
#
#     OUTPUT
#    FF16=$FIC/FCLIENT_CIPJJ
#    FF17=$FIC/FCOMPTE_CIPJJ
#    FF18=$FIC/FIPS_CIPJJ
#    FF19=$LST/CIP_ANO_DEC
#    FF20=$TMP/HISTBAM_CIPJJ
#      INPUT / OUTPUT
#    FF21=$FIC/FTABPM
#
echo 'FIN cipbam022.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
read a
#-----------------------------------------------------------------------
#--HMA1 : elimination des doublans (infraction) du fichier IPS
#  infraction en doubles declaré dans le fichier IPS
#
$SHS/cipbamsips.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
# - copier ($FIC/FIPS_CIPJJ)  vers ($TMP/FIPS_CIPJJ_ORI) avant execution
#    ENTREE : FF1=$TMP/FIPS_CIPJJ_ORI
#    SORTIE : FF2=$FIC/FIPS_CIPJJ
#
echo 'FIN cipbamsips.sh RELEVER LES COMPTEURS ---> ENTER POUR CONTINUER '
read a
#
#-----------------------------------------------------------------------
#  TRI ARCHI ALIMENTATION DU JOUR SUR NO COMPTE/FIC/NO CHQ
#
$SHS/tri_cipjj1.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$TMP/HISTBAM_CIPJJ
#    SORTIE : FF2=$FIC/CIPDEC_HISTBAM_JJ
#
echo 'FIN tri_cipjj1.sh RELEVER LES COMPTEURS ---> ENTER POUR CONTINUER '
read a
#
#--------------------------------------------------------------#
#     LISTE DECLARATION INCIDENTS DE PAIEMENT A ENVOYER A BAM"
#     PGM : cipbam042.eco
#
$SHS/cipbam042.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
#
#    ENTREE : FF1=$FIC/CIPDEC_HISTBAM_JJ
#
#    SORTIE : FF2=$LST/CIP_LST_DEC
#
echo 'FIN cipbam042.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
read a
#
#-----MMA00  LE 14-06-2015----------------------------------------------#
$SHS/cipbam310.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
echo 'FIN cipbam310.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#-----------------------------------------------------------------------#
$SHS/cipbam320.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
echo 'FIN cipbam320.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#-----------------------------------------------------------------------#
$SHS/cipbam330.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
echo 'FIN cipbam330.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#-----------------------------------------------------------------------#
$SHS/ftp_lettre_inj_docubase.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
echo 'FIN ftp_lettre_inj_docubase.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#-----------------------------------------------------------------------#
$SHS/ftp_lettre_inj_docuprint.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM2_prt_$i
echo 'FIN ftp_lettre_inj_docuprint.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#-----MMA00  FIN--------------------------------------------------------#
unset i
unset k
#----------------------------------------------------------------------#
#
echo 'FIN TRAITEMENT jcipbam2.sh    ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------------#
