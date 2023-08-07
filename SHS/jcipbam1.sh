#    jcipbam1.sh     ex jincident2.sh
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
#  LE 27-07-2012 : PURGE DES ECHUS A CUMULER DANS FIC/FCIPBAM_ECHU
#  LE 15-01-2013 : SIGNATURE HMA1
#                : ANNULATION DE LA PURGE (DEMANDE DU 27-07-2012)
#
#----------------------------------------------------------------#
#
. ./INITenvironnement.sh
export k=`date '+%d%m%y'`
export i=`date '+%y%m%d_%H%M%S'`
#----------------------------------------------------------------#
#  LIBELLE DU TITRE JCL INCIDENTS
$SHS/tit_cip1.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i
#
# 
#----------------------------------------------------------------#
$SHS/verifdate.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i 
#
# VERIF  SAISIE DATE DE TRAITEMENT DANS jy2fuca.sh
#
echo 'verifdate.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
#
rm -f $TMP/FCIPBAM_NECHU                                                                           
rm -f $TMP/FCIPBAM_ECHU
rm -f $TMP/FCIPBAM_NECHU_TRI
#
# 
#----------------------------------------------------------------#
#
#    "ARCHIVAGE FCIPBAM AVANT TRAITEMENT "
#
$SHS/bkp_fcipbam.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                             
#                                                                                 
#    ENTREE : $FIC/FCIPBAM
#    SORTIE : $ARC/FCIPBAM_AAMMJJ_HHMMSS
#
echo 'bkp_fcipbam.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
#
#    "ARCHIVAGE FCIPLOC AVANT TRAITEMENT "
#
$SHS/bkp_fciploc.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i
#
#    ENTREE : $FIC/FCIPLOC
#    SORTIE : $ARC/FCIPLOC_AAMMJJ_HHMMSS
#
echo 'bkp_fciploc.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
#    "ARCHIVAGE HEADER CIP_HEDBAM AVANT TRAITEMENT "
#
$SHS/bkp_ciphedbam.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i
#
#    ENTREE : $FIC/CIP_HEDBAM
#    SORTIE : $ARC/CIP_HEDBAM_AAMMJJ_HHMMSS
#
echo 'bkp_ciphedbam.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '  
read a
#
#----------------------------------------------------------------#
#    "ARCHIVAGE SAISIE CIP JOURNEE VEILLE "
#
$SHS/bkp_cip_saisie.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i
#
#    ENTREE : $FIC/cip_decinc_pxx 
#    SORTIE : $ARC/cip_decinc_pxx_AAMMJJ_HHMMSS
#
echo 'bkp_cip_saisie.sh APRES VERIF BONNE  DATE TRAIT ---> ENTER POUR CONTINUER '  
read a
#
#----------------------------------------------------------------#
#   "MAJ HEADER FIC/CIP_HEDBAM : COMPTEURS DE DEMARRAGE ET NO DE LOT  
#      PGM  : cipbam200.eco
#
$SHS/cipbam200.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i
#                                                                                                 
#      ENTREE : FF0=$FIC/DATCONSOLE
#      I-O    : FF1=$FIC/CIP_HEDBAM
#      SORTIE : FF2=$LST/CIP_HEADER_DEC
#
#
echo 'FIN cipbam200.sh  RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '                         
read a                                                                                            
#                                                                                                 
#----------------------------------------------------------------#
#    MAJ DES SIGNATAIRES REFONTE CIP 05-06-2012
#    SCRIPT SEUL : jcipsignat2.sh 
#
echo 
echo "MISE A JOUR DES SIGNATAIRES REFONTE CIP "
echo
#-----------------------------------------------------------------#
#   ARCHIVAGE FSIGNAT_AG  VERS ARC
echo "ARCHIVAGE FSIGNAT "
#
$SHS/bkp_fsignat_ag.sh  > log.tmp                                                                      
cat log.tmp                                                                                     
cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                                              
#                                                                                               
# "TRI "                                     
# 
#    ENTREE : $FIC/FSIGNAT_AG          
#    SORTIE : $ARC/FSIGNAT_AG_$i             
#                                                                                               
echo 'FIN bkp_fsignat_ag.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '                         
read a                                                                                          
#                                                                                       
#---------------------------------------------------------------# 
# "TRI DES PXX RECUS PAR TRANSMISSION POUR MAJ DES SIGNATAIRES"
#
$SHS/cipsigna_tri03.sh  > log.tmp                      
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i   
echo
#
#            ENTREE : $FIC/sem_inc020_incpxx`
#            SORTIE : $TMP/pbx_fsignat01`
#
echo 'FIN cipsigna_tri03.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a  
#
#-----------------------------------------------------------------------#                                                    
#   
# "TRI, SELECTION  DES PB RECUS PAR TRANSMISSION POUR MAJ DES SIGNATAIRES"   
#        PGM  : cipsigna02.eco        
#                                                                        
$SHS/cipsigna02.sh  > log.tmp                                    
cat log.tmp                                                             
cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                  
echo                                                                    
#
#        ENTREE : FF1=$TMP/pbx_fsignat01
#
#        SORTIE : FF2=$TMP/pbx_fsignat02 
#        SORTIE : FF3=$LST/CIPSIGNA02_PB_DOUBLE
#
echo 'FIN cipsigna02.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '
read a
#
#-----------------------------------------------------------------------#
#   TRI SUR NO DE COMPTE ET CODE TRAME  
#
$SHS/cipsigna_tri04.sh > log.tmp                                                                      
cat log.tmp                                                                                     
cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                                              
#                                                                                               
# 
#    ENTREE : $TMP/pbx_fsignat02       
#    SORTIE : $TMP/pbx_fsignat03         
#                                                                                               
echo 'FIN cipsigna_tri04.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '                         
read a                                                                                          
#                                                                                       
#---------------------------------------------------------------# 
#       AJOUT DES NOUVEAUX SIGNATAIRES ET CREATION RANG 00   
#                                       
$SHS/cipsigna03.sh > log.tmp
echo                                                                     
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i    
#
#    ENTREE : FF0=$FIC/DATCONSOLE      
#    ENTREE : FF1=$TMP/pbx_fsignat03   
#    ENTREE : FF2=$FIC/FSIGNAT_AG      
#    ENTREE : FF3=$FIC/WFPIVOT         
#    ENTREE : FF4=$FIC/FSCIP   
#        
#    SORTIE : FF5=$FIC/fsignat_maj_jj  
#    SORTIE : FF6=$LST/CIPSIGNA03_ANO  
#   
echo 'FIN cipsigna03 RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
read a
#-----------------------------------------------------------------------#   
#    MAJ FSIGNAT_AG PAR LES NOUVEAUX SIGNATAIRES DE LA JOURNEE
#                              
$SHS/cipsigna04.sh  > log.tmp                                                                      
cat log.tmp                                                                                     
cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                                              
#                                                                                              
# 
#     ENTREE : FF1=$FIC/fsignat_maj_jj      
#             
#     I/O    : FF2=$FIC/FSIGNAT_AG      
#                                                                                               
echo 'FIN cipsigna04.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '                         
read a                                                                                          
#                                                                                               
#-----------------------------------------------------------------# 
echo  
echo                                                                    
echo "FSIGNAT_AG APRES  MAJ   :" `wc -l $FIC/FSIGNAT_AG` 
echo
echo 'FIN TRAIT  VERIFIER LES COMPTEURS  ---> ENTER POUR TERMINER '                         
read a   
#        
#-----------------------------------------------------------------# 
$SHS/unload_cip_jj.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JCIPBAM1_prt_$i
#                                                                                  
#      ENTREE : BASE DONNEES CENTRAL (INCIDENT_PAIEMENT_TRANS)
#                                     
#      SORTIE : $FIC/CIP_JJ
#                                                                                  
echo 'FIN unload_cip_jj.sh    RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '         
read a                      
#-----------------------------------------------------------------#
$SHS/cip-maj-piv-scip.sh > log.tmp                                                  
cat log.tmp                                                                  
cat log.tmp >> $LOG/JCIPBAM1_prt_$i
#                                                                            
#      ENTREE        : FF1=$FIC/CIP_JJ  
#      ENTREE-SORTIE : FF2=$FIC/FPIVOT
#      ENTREE-SORTIE : FF2=$FIC/FSCIP
#      ENTREE-SORTIE : FF2=$FIC/FSCIP2
#      ENTREE-SORTIE : FF2=$FIC/FSCIP3                                         
#                                         
#      SORTIE : FF3=$FIC/CIP_JJ_FREJET 
#                                                                            
#                                                                            
echo 'FIN cip-maj-piv-scip RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '    
read a                                                                      
#                                                                            
#--------------------------------------------------------------#   


#----------------------------------------------------------------#
###HMA1 #    
###HMA1 echo     "PURGE DES INCIDENTS ARRIVES A ECHEANCE "
###HMA1 #  
###HMA1 #----------------------------------------------------------------#                            
###HMA1 $SHS/cipbamechu.sh  > log.tmp                                                                      
###HMA1 cat log.tmp                                                                                     
###HMA1 cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                                           
###HMA1 #                                                                                              
###HMA1 # 
###HMA1 #        ENTREE :  FIC/DATCONSOLE                                     
###HMA1 #                  FIC/FCIPBAM                                     
###HMA1 #        SORTIE :  TMP/FCIPBAM_NECHU
###HMA1 #                  TMP/FCIPBAM_ECHU   
###HMA1 #                  LST/FCIPBAM_ECHU     
###HMA1 #                                                                                               
###HMA1 echo 'FIN cipbamechu.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '                         
###HMA1 read a 
###HMA1 #
###HMA1 #----------------------------------------------------------------------#
###HMA1 #     TRI FCIPBAM_NECHU 
###HMA1 echo "TRI FCIPBAM_NECHU EN COURS "
###HMA1 #
###HMA1 $SHS/tri_fcipbam_nechu.sh  > log.tmp                                                                      
###HMA1 cat log.tmp                                                                                     
###HMA1 cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                                           
###HMA1 #                                                                                              
###HMA1 # 
###HMA1 #        ENTREE :  $TMP/FCIPBAM_NECHU                                                                       
###HMA1 #        SORTIE :  $TMP/FCIPBAM_NECHU_TRI`
###HMA1 #                                                            
###HMA1 echo 'FIN tri_fcipbam_nechu.sh RELEVER LES COMPTEURS  ---> ENTER POUR CONTINUER '                         
###HMA1 read a 
###HMA1 #----------------------------------------------------------------#
###HMA1 #
###HMA1 echo "REBUILD NOUVEAU FICHIER FCIPBAM SANS LES ECHUS "
###HMA1 #
###HMA1 rebuild $TMP/FCIPBAM_NECHU_TRI,$FIC/FCIPBAM -o:lseq,ind -t:c-isam -r:f440 -k:1+52
###HMA1 #
###HMA1 echo 'FIN INDEXATION FCIPBAM'
###HMA1 read a
###HMA1 #
###HMA1 #----------------------------------------------------------------#
###HMA1 echo "COMPTEUR APRES INDEXATION FCIPBAM INCIDENTS NON ECHUS "                         
###HMA1 echo  
###HMA1 #                                                                                
###HMA1 $SHS/ctr_fcipbam.sh  > log.tmp                                                        
###HMA1 cat log.tmp                                                                           
###HMA1 cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                                   
###HMA1 #                                                                                     
###HMA1 #                                                                                     
###HMA1 # "COMPTEUR FCIPBAM POUR CONTROLE   "                                                 
###HMA1 #                                                                                     
###HMA1 echo 'FIN ctr_fcipbam.sh  RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '         
###HMA1 read a                                                                                
###HMA1 echo                                                                                  
###HMA1 #                                                                                     
###HMA1 #----------------------------------------------------------------#                    
###HMA1 echo "SAUVEGARDE ET CUMUL DES INCIDENTS ARRIVES A ECHEANCE"    
###HMA1 echo   
###HMA1 #                                                                               
###HMA1 $SHS/bkp_fcipbam_echu.sh  > log.tmp                                                   
###HMA1 cat log.tmp                                                                           
###HMA1 cat log.tmp >> $LOG/JCIPBAM1_prt_$i                                                   
###HMA1 #    "CUMUL DES ECHUS"                                                                
###HMA1 #                                                                                     
###HMA1 #                 ENTREE :$TMP/FCIPBAM_ECHU                                           
###HMA1 #                 SORTIE :$FIC/FCIPBAM_ECHU                                           
###HMA1 #                                                                                     
###HMA1 #    "ARCHIVAGE DES ECHUS"                                                            
###HMA1 #                                                                                     
###HMA1 #                 ENTREE  :$FIC/FCIPBAM_ECHU                                          
###HMA1 #                 SORTIE  :$ARC/FCIPBAM_ECHU_$i                                        
###HMA1 #                                                                                     
###HMA1 echo 'FIN bkp_fcipbam_echu.sh  RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '    
###HMA1 read a                                                                                
###HMA1 echo                                                                                  
###HMA1 #                                                                                     
#----------------------------------------------------------------#                    
unset i
unset k
#----------------------------------------------------------------#
#
echo 'FIN TRAITEMENT jcipbam1.sh    ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
