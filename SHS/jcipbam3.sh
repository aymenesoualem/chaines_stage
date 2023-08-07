#-----------------------------------------------------------------------#
#    SCRIPT  DES INCIDENTS DE PAIEMENT : jcipbam3.sh                    #
#                                                                       #
#   MAJ FCIPBAM        : PAR FCIPLOC   ET CONFRERES                     #  
#   MAJ CIPDEC_HISTBAM : HISTORIQUE DES DECLARATIONS ENVOYEES A BAM     #
#   $FIC/DATWRCIP.dat   POUR DWH NOUVEAU FIC   
#   LE 11-09-2012 GENERATION FIC/INTERDIT_CIP  A PARTIR DE FCIPBAM      #
#       
#       doubles ide catego 3 : cause RC SUP 9 POSITIONS                 #
#-----------------------------------------------------------------------#
#
. ./INITenvironnement.sh
#
export k=`date '+%d%m%y'`
export i=`date '+%y%m%d_%H%M%S'`
export x=`date '+%y%m%d'`
#
#--------------------------------------------------------------#
#  LIBELLE DU TITRE JCL INCIDENTS
#
$SHS/tit_cip3.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i
#
#  
#----------------------------------------------------------------------#
# VERIF BONNE DATE DE TRAITEMENT : date saisie par console dans jy2fuca.sh
#  PGM : verifdate.gnt
#
$SHS/verifdate.sh
#
#   ENTREE : FIC/DATCONSOLE
#
echo 'verifdate.sh APRES AFFICHAGE DATE TRAIT ---> ENTER POUR CONTINUER '
read a
#
#-------------------------------------------------------------------------#
#
echo "bkpintrd_cip : ARCHIVAGE INTERDIT "
$SHS/bkpintrd_cip.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i 
# 
# "ARCHIVAGE INTERDIT_CIP  
echo 'FIN bkpintrd_cip.sh      ---> ENTER POUR CONTINUER '
read a
# 
#-----------------------------------------------------------------------# 
# "ARCHIVAGE CIPDEC_HISTBAM  AVANT TRAITEMENT "
#
echo "bkphistb : ARCHIVAGE HISTORIQUE DECL A BAM "
#
$SHS/bkp_cipdec_hist.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i 
# 
#   ENTREE : $FIC/CIPDEC_HISTBAM     ------------> CUMUL ARCHIVAGE VEILLE DECLARATIONS ENVOYEES A BAM
#   SORTIE : $ARC/CIPDEC_HISTBAM_$i
# 
#   ENTREE : $FIC/CIPDEC_HISTBAM_JJ  ------------>  ARCHIVAGE DECLARATIONS ENVOYEES A BAM CE JOUR
#   SORTIE : $ARC/CIPDEC_HISTBAM_JJ_$i
# 
echo 'FIN bkp_cipdec_hist.sh RELEVER COMPTEURS ET   ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
#
#    "ARCHIVAGE FCIPBAM AVANT TRAITEMENT "
#
$SHS/bkp_fcipbam.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i                                             
#                                                                                 
#    ENTREE : $FIC/FCIPBAM
#    SORTIE : $ARC/FCIPBAM_AAMMJJ_HHMMSS
#
echo 'bkp_fcipbam.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '
read a
#
#--------------------------------------------------------------#    
#  
echo   "DEBUT   :  MISE A JOUR FCIPBAM = FCIPCONF + FCIPLOC "
echo
#
#-------------------------------------------------------------------------#
#                                                                                      
#    "ARCHIVAGE FCIPCONF : CONFRERES                                          
#                                                                                      
$SHS/bkp_fcipconf.sh > log.tmp                                                          
cat log.tmp                                                                            
cat log.tmp >> $LOG/JCIPBAM3_prt_$i                                              
#                                                                                      
#    ENTREE : $FIC/FCIPCONF                                                           
#    SORTIE : $ARC/FCIPCONF_AAMMJJ_HHMMSS                                               
#                                                                                      
echo 'bkp_fcipconf.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '         
read a                                                                                 
#                                                                                      
#--------------------------------------------------------------#      
## "TRI FCIPLOC (BMCE) POUR MAJ FCIPBAM (HISTO BMCE ET CONFRERES)"     
##  plus untilise               
##                                                                                    
#$SHS/tri_cip501.sh > log.tmp                                                           
#cat log.tmp                                                                          
#cat log.tmp >> $LOG/JCIPBAM3_prt_$i                                                
##                                                                                    
##          ENTREE : $FIC/FCIPLOC                                                     
##          SORTIE : $FIC/tem_ciploc_maj `                                            
##                                                                                    
#echo 'FIN tri_cip501.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '            
##                                                                                    
#read a                                                                               
##                                                                                     
#-----------------------------------------------------------------------#   
#   PGM   cipbam066.gnt
#   
#   PREPARATION MAJ FCIPBAM PAR LES INCIDENTS CONFRERES ET BMCE APRES TRAIT JOURNEE
#   $FIC/FCIPCONF  + FCIPLOC = FCIPBAM
#   PLUS DE TRI MAJ PAR FCIPLOC VSAM POUR NE PAS RECONDUIRE LES ENRS SUPPRIMES PAR DELETE
#  
#
echo " MAJ FCIPBAM  PAR FCIPLOC  EN COURS "
echo
#
$SHS/cipbam066.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i
#
#        ENTREE : FF0=$FIC/DATCONSOLE
#        ENTREE : FF1=$FIC/FCIPLOC
#
#        I-O    : FF2=$FIC/FCIPCONF 
# 
#        SORTIE : FF3=CIP_MAJDEC_FCIPBAM 
#
echo 'FIN cipbam066.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#  
# 
echo "DELETE FCIPBAM" 
rm $FIC/FCIPBAM 
rm $FIC/FCIPBAM.idx                                                              
echo "FIN DELETE FCIPBAM"   
#
read a                                                      
#----------------------------------------------------------------------# 
echo  "SAVE  HISTORIQUE INCIDENTS BMCE et CONFRERES  VERS FICH FCIPBAM "  
#     PGM  : cipbam016.eco                                    
#                                                                                               
$SHS/cipbam016.sh > log.tmp                                                                       
cat log.tmp                                                                                     
cat log.tmp >> $LOG/JCIPBAM3_prt_$i                                                           
#  
#      ENTREE : FF1=$FIC/FCIPCONF 
#      SORTIE : FF2=$FIC/FCIPBAM  
#                                                                                               
echo 'FIN cipbam016.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '                         
read a                                                                                          
#  
#-----------------------------------------------------------------------#
echo "COMPTEUR APRES INDEXATION FCIPBAM INCIDENTS NON ECHUS "                         
echo  
#                                                                                
$SHS/ctr_fcipbam.sh  > log.tmp                                                        
cat log.tmp                                                                           
cat log.tmp >> $LOG/JCIPBAM3_prt_$i                                                      
#                                                                                     
#                                                                                     
# "COMPTEUR FCIPBAM POUR CONTROLE   "                                                 
#                                                                                     
echo 'FIN ctr_fcipbam.sh  RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '         
read a                                                                                
echo                                                                                  
#-----------------------------------------------------------------------------#                                                                                     
#  
echo
echo   "FIN  :  MISE A JOUR FCIPBAM PAR LES DECLARATIONS BMCE"
echo
#
#-------------------------------------------------------------------------#
#                                                                                                                  
#    MISE A JOUR  FIC/CIPDEC_HISTBAM PAR  $FIC/CIPDEC_HISTBAM_JJ                                                         
#                                                                                                                  
#-----------------------------------------------------------------------#                                          
# "MAJ FIC/CIPDEC_HISTBAM : HISTORIQUE DES DECLARATIONS INCIDENTS ENVOYEES A BAM"                                             
#  PGM  cipbam070.eco                                                                                              
#                                                                                                                  
$SHS/cipbam070.sh > log.tmp                                                                                        
cat log.tmp                                                                                                        
cat log.tmp >> $LOG/JCIPBAM3_prt_$i                                                                              
# 
#    ENTREE  : FF2= $FIC/CIPDEC_HISTBAM_JJ          :ARCHIVAGE HISTO DECLARATIONS JJ  TRIES                                                                                                                  
#    I/O     : FF1= $FIC/CIPDEC_HISTBAM   :HISTORIQUE DECL INCIDENTS ENVOYEES A BAM                                  
#                                                                                                                  
echo 'FIN cipbam070.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '                                         
#                                                                                                                  
read a                                                                                                             
#                                                                                                                  
#-----------------------------------------------------------------------#                                          
#                                  
# "TRANSFERT ETATS ALIMENTATION  INCIDENTS DE PAIEMENT  "     
#                                                                  
#    VERS  GEDBQ-SY ,PROD_SHARE7                                                                             
#                                                                                                                  
$SHS/ftp_cip_dtv1.sh  > log.tmp                                                                                    
cat log.tmp                                                                                                        
cat log.tmp >> $LOG/JCIPBAM3_prt_$i                                                                              
#                                                                                                                  
# "TRANSFERT ETATS  INCIDENTS DE PAIEMENT  "                                                                       
#   CIP_ANO_DEC     ---->  CIPDEC_ANO_$i                                                                              
#   CIP_LST_DEC     ---->  CIPDEC_LST_$i                                                                              
#   CIP_TRSF_CPTE   ---->  CIPDEC_TRSF_CPTE_$i                                                                       
#                                                                                                                  
#                                                                                                                  
echo 'FIN ftp_cip_dtv1.sh  RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER'                                       
read a                                                                                                             
#                                                                                                                  
#-----------------------------------------------------------------------# 
##### desactiver par hakim le 20/09/2012
#####     EX : datawr16.sh    
##### "RECUPERATION FCIPBAM  -----> DATWRCIP.dat  
#####    PGM : datawrcip.eco                      
#####             
####$SHS/datawrcip.sh  > log.tmp  
####cat log.tmp
####cat log.tmp >> $LOG/JCIPBAM3_prt_$i 
#####
##### 
#####      ENTREE : FF1=$FIC/FCIPBAM        
#####      SORTIE : FF2=$FIC/DATWRCIP.dat   
#####
####echo 'FIN datawrcip.sh   RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER'
####read a
#####
#-----------------------------------------------------------------------#   
#       
# "GENERATION INTERDITS BANCAIRES A PARTIR DE FCIPBAM 
#    PGM : cipbam190.eco                      
#             
$SHS/cipbam190.sh  > log.tmp  
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i 
#
#      ENTREE : FF0=$FIC/DATCONSOLE 
#      ENTREE : FF1=$FIC/FCIPBAM        
#      SORTIE : FF2=$TMP/INTERDIT_CIP   
#
echo 'FIN cipbam190.sh   RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER'
read a
#
#-----------------------------------------------------------------------#  
#       
# "TRI INTERDITS BANCAIRES POUR GENERATION INDEX
#                     
#             
$SHS/tri_cip203.sh  > log.tmp  
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i 
#
#      ENTREE : $TMP/INTERDIT_CIP
#         
#      SORTIE : FF2= $FIC/cip_interdit  
#
echo 'FIN tri_cip203.sh   RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER'
read a
#
#-----------------------------------------------------------------------#  
# 
echo "DELETE FIC/INTERDIT_CIP POUR REGENERATION INDEX"
#
rm $FIC/INTERDIT_CIP 
rm $FIC/INTERDIT_CIP.idx 
#-----------------------------------------------------------------------#  
#       
# "GENERATION INDEX  INTERDITS BANCAIRES 
#    PGM : cipbam130.eco                      
#             
$SHS/cipbam130.sh  > log.tmp  
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i 
#
# 
#      ENTREE : FF1=$FIC/cip_interdit      
#      SORTIE : FF2=$FIC/INTERDIT_CIP   
#
echo 'FIN cipbam130.sh   RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER'
read a
#
#------------------------------------------------------------------#
#     TRANSFER FTP DES DECLARATIONS CIP vers SERVEUR CFT
#     MACHINE bam-sy
#
echo  " FORMATAGE POUR ENVOI A BAM "
#
$SHS/ftp_cipbam.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i
#
#    ENTREE : $FIC/FCLIENT_CIPJJ
#             $FIC/FCOMPTE_CIPJJ
#             $FIC/FIPS_CIPJJ
#    SORTIE : $FIC/CIP_CLI_011_001_${wdatlot}_${wnumlot}
#             $FIC/CIP_CPT_011_001_${wdatlot}_${wnumlot}
#             $FIC/CIP_IPS_011_001_${wdatlot}_${wnumlot}
#
echo 'FIN ftp_cipbam.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
read a
#
#-----MMA01  LE 20-09-2017----------------------------------------------#
$SHS/trt_trame_declar_infract.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i
echo 'FIN trt_trame_declar_infract.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
#-----------------------------------------------------------------------#
$SHS/ftp_infractions_cre.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM3_prt_$i
echo 'FIN ftp_infractions_cre.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
#-----MMA01  FIN--------------------------------------------------------#
read a
#-----------------------------------------------------------------------#                                                            
#                                                                                                               
unset i                                                                                                            
unset k                                                                                                            
#----------------------------------------------------------------------#                                           
##      COMPRESS MIS DANS ftp_ctr_hamid.sh
#gzip -f -9 $ARC/*$i
#echo 'COMPRESSION DES FICHIERS ARCHIVES ---> ENTER POUR CONTINUER'
#read a
##
#-------------------------------------------------------------------------#
##
echo 'FIN TRAITEMENT jcipbam3.sh    ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------------#
