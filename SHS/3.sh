#-------------------------------------------------------------#
# RELEVES CLIENTELE ETBAC DU JOUR                             #
# ENTREE : Y3SOLCL ET MOUVEMENTS DU JOUR                      #
# ENTREE :FTELCMP  TABLE CLIENTELE ETBAC                                    
#                                                             #
#   jy2etbac.sh
#-------------------------------------------------------------#
. ./INITenvironnement.sh
export k=`date '+%d%m%y'`
export i=`date '+%y%m%d%H%M%S'`
export x=`date '+%y%m%d'`
####chmod 755 $SHS/*
#
###############################
   echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
   echo "     VERIFIER DATCONSOLE et DATVEILLE AVANT DE CONTINUER"
   echo "  AU BESOIN PASSER LES SCRIPTS datcons.sh ET/OU datveille.sh"
   echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

wdtconsaf=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,1,8) }' $FIC/DATCONSOLE)
wdtcons=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,5,4) substr($0,3,2) substr($0,1,2) }' $FIC/DATCONSOLE)
echo " !!! DATE JOUR   : " ${wdtconsaf}

wdtveilaf=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,1,8) }' $FIC/DATVEILLE)
wdtveil=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,5,4) substr($0,3,2) substr($0,1,2) }' $FIC/DATVEILLE)
echo " !!! DATE VEILLE : " ${wdtveilaf}

if (( $wdtcons <= $wdtveil ))
then
   echo "<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>"
   echo " INF : DATE CONSOLE INFERIEUR à la DATE VEILLE "
   echo "     - MERCI DE MODIFIER UNE DATE POUR CONTINUER "
   echo "     VERIFIER DATCONSOLE et DATVEILLE avant de continuer"
   echo "     PASSER les scripts datcons.sh et datveille.sh  "
   echo "<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>"
   exit 0
fi
###############################
#-------------------------------------------------------------#
#
$SHS/tit_jy2etbac.sh >  log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
#  LIBELLE DU TITRE JCL  : CREATION RELEVES CLIENTELE ETBAC
#
#-------------------------------------------------------------------#
#
echo "DELETE FIC/prm_soldes_etbac  FTELREL"
> $FIC/prm_soldes_etbac
rm $FIC/FTELREL
#--------------------------------------------------------------#
echo "DELETE FTELCMP AVANT CHARGEMENT  "
rm -f $FIC/FTELCMP
rm -f $FIC/FTELCMP.idx
#
#--------------------------------------------------------------#
echo 
echo "REMISE EN PLACE FTELCMP A PARTIR DE ftelcmp.txt "
#
$SHS/idxtelcmp.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
# "SELECTION DES SOLDES CLIENTEL ETBAC"
#
#  ENTREE : /central/ftelcmp.txt
#
#  SORTIE : $FIC/FTELCMP   
#
echo 'FIN idxtelcmp.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#
echo 
echo "SELECTION SOLDES CLIENTELE ETBAC"
echo "PRIERE DE PATIENTER LORS DE LA RECHERCHE DES SOLDES ETBAC"
#
$SHS/y3telb25.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
# "SELECTION DES SOLDES CLIENTEL ETBAC"
#
#  ENTREE : $FIC/Y3SOLCL  SOLDES CLIENTELE  
#  ENTREE : $FIC/prm_ycg030_cg25 MVTS CG25     
#  ENTREE : $FIC/FTELCMP  TABLE CLIENTELE ETBAC         
#  ENTREE : $FIC/YCATEGO  TABLE CAT/CG         
#  SORTIE : $FIC/prm_soldes_etbac    
#
echo 'FIN y3telb25.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#
##!!!!echo "ATTENTION  SAISIR UNIQUEMENT LA DATE VEILLE"
##!!!!#    SORTIE  FIC/DATVEILLE
##!!!!
##!!!!$SHS/datveille.sh
##!!!!
##!!!!echo 'fin datveille.sh APRES AFFICHAGE DATE TRAIT ---> ENTER POUR CONTINUER '       
##!!!!read a                                                                              
#                                                                                   
#-----------------------------------------------------------------------#
echo " ATTENTION, AFFICHER LA DATE VEILLE"
#
cat $FIC/DATVEILLE
#                                                                                   
echo ' AFFICHAGE DATE VEILLE ---> ENTER POUR CONTINUER '
read a                                                                              
#
#--------------------------------------------------------------#                    
#   "DATE VEILLE TRAITEE POUR SOLDE VEILLE CODE 01  " $FIC/DATVEILLE                                  
#   "DATE JOUR           POUR SOLDE JOUR   CODE 07  " $FIC/DATCONSOLE   
#    
echo "CREATION RELEVE ETBAC"
#
$SHS/y3telb26.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
# "SELECTION DES SOLDES CLIENTEL ETBAC"
#
#  ENTREE : $FIC/prm_soldes_etbac 
#  ENTREE : $FIC/prm_ycg030_cg25      
#  ENTREE : $FIC/FTELCMP  TABLE CLIENTELE ETBAC         
#  ENTREE : $FIC/YCATEGO  TABLE CAT/CG  
#  ENTREE : $FIC/DATCONSOLE   
#  ENTREE : $FIC/DATVEILLE
# 
#  SORTIE : $FIC/tem_ftelrel01
#  SORTIE : $LOG/JY2ETBAC_010_dsp  (DISPLAY)
#
echo 'FIN y3telb26.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#
echo "TRI RELEVE SUR NO DE COMPTE ET CLE"
#
$SHS/tri_jy2etbac.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
#  ENTREE : $FIC/tem_ftelrel01
#  SORTIE : $FIC/tem_ftelrel02
#
echo 'FIN tri_jy2etbac.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#
echo "SEQUENCE RELEVE FINAL ETBAC TRIE :FTELREL"
#
$SHS/y3telb27.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
# "SEQUENCE RELEVE FINAL ETBAC TRIE :FTELREL"
#
#  ENTREE : $FIC/tem_ftelrel02
#  SORTIE : $FIC/FTELREL
#
echo 'FIN y3telb27.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#
echo "ARCHIVAGE FICHIERS"
#
$SHS/bkp_jy2etbac.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
#  ENTREE : $FIC/prm_soldes_etbac VERS $ARC/prm_soldes_etbac_$i`
#  ENTREE : $FIC/FTELREL          VERS $ARC/FTELREL_$i`
#
echo 'FIN bkp_jy2etbac.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#
echo "TRANSFERT FTELREL "
#
$SHS/ftp_jy2etbac.sh > log.tmp
cat log.tmp
cat log.tmp >> $LOG/JY2ETBAC_prt_$i
#
#     ftp -n -i -v etebac-sy << END
#        
#     ftp -n -i -v 144.146.61.85 << END
#
echo 'FIN ftp_jy2etbac.sh RELEVER LES COMPTEURS   ---> ENTER POUR CONTINUER '
#
read a
#
#-----------------------------------------------------------------------#
#
unset i
unset k
#----- AJOUT 160329, HAKIM : REMPLACE DATEVEILLE PAR DATCONSOLE---------#
echo " !!! ------------- A LA FIN de jy2etbac -------------------"
echo " !!! MISE A JOUR DATE VEILLE PAR LA DATE DU JOUR TRAITE !!!"
#    ENTRE   FIC/DATCONSOLE
#    SORTIE  FIC/DATVEILLE
#
wdatjma=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,1,8) }' $FIC/DATVEILLE)
echo " !!! ANCIENENE DATE VEILLE : " ${wdatjma}
cat $FIC/DATVEILLE

cat $FIC/DATCONSOLE > $FIC/DATVEILLE
#                                                                                   
wdatjma=$(awk 'BEGIN { FS="" } NR==1 { print substr($0,1,8) }' $FIC/DATVEILLE)
echo " !!! PROCHAINE DATE VEILLE : " ${wdatjma}
#                                                                                   
echo
echo " AFFICHAGE PROCHAINE DATE VEILLE ---> ENTER POUR CONTINUER "
read a                                                                              
#                                                                                   
#-----------------------------------------------------------------#
#
echo 'FIN TRAITEMENT jy2etbac.sh.sh    ---> ENTER POUR CONTINUER '
read a
#
#----------------------------------------------------------------#
