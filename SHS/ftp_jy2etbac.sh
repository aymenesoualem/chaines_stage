. ./INITenvironnement.sh
PathBatch="/central/SHS"
echo
echo "*** ftp_jy2etbac.sh ***" 
echo "    ---------------"
echo " - TRANSFERT FTELREL : etebac-sy"

ftp -n -i -v etebac-sy << END
user Financecom  bmcetest                           
lcd /central/FIC                                
cd out                                
put FTELREL FTELREL
put FTELREL PROD_FTELREL 
END

ftp -n -i -v 172.21.10.154 << END
user EtebacUser  etebac19
lcd /central/FIC
cd out
put FTELREL PROD_FTELREL
END

$PathBatch/Prodsftp.sh  172.21.10.170  B54C1A14 807F3C30E802B2ED "/central/FIC/FTELREL" "/home/prod/EAI-APP/repository/PROD_FTELREL.DAT"

wcoderr=$?
if [ $wcoderr != 0 ]
then
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	   echo " ERREUR : ftp_jy2etbac.sh, FTP terminer en erreur " $wcoderr
	   echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
     exit $wcoderr
fi
