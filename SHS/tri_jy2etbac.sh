. ./INITenvironnement.sh
echo "*** tri_jy2etbac.sh ***" 
echo "    ---------------"
echo " - TRI RELEVES CLIENTELE ETBAC" 
#mfsort SORT FIELDS \(12,5,CH,A,22,3,CH,A,27,5,CH,A,25,2,CH,A,1,2,CH,A\) USE $FIC/tem_ftelrel01 ORG LS RECORD F,120 GIVE $FIC/tem_ftelrel02 ORG LS RECORD F,120
#ce tri a été ajouter dans le cadre de l'evolution ajout des comptes en devise 
#mfsort SORT FIELDS \(12,5,CH,A,22,3,CH,A,27,5,CH,A,25,2,CH,A,17,3,CH,A,1,2,CH,A\) USE $FIC/tem_ftelrel01 ORG LS RECORD F,120 GIVE $FIC/tem_ftelrel02 ORG LS RECORD F,120
mfsort SORT FIELDS \(12,5,CH,A,22,3,CH,A,27,5,CH,A,25,2,CH,A,17,3,CH,A,1,2,CH,A,105,8,CH,A\) USE $FIC/tem_ftelrel01 ORG LS RECORD F,120 GIVE $FIC/tem_ftelrel02 ORG LS RECORD F,120
wcoderr=$?
#
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : tri_jy2etbac.sh, TRI terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
#-----------------------------------------------------------------------#
echo
echo " NBR ENTREE TRI :RELEVE ETBAC : " `wc -l $FIC/tem_ftelrel01`
echo " NBR SORTIE TRI :             : " `wc -l $FIC/tem_ftelrel02`
