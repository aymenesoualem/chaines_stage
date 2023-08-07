. ./INITenvironnement.sh              
echo                                  
echo "*** cipbamsips.sh ***"   
echo "    ------------ "            
echo " Elimination des infractions générerées en double"
cp $FIC/FIPS_CIPJJ $TMP/FIPS_CIPJJ_ORI
wcodret=$?
if [ $wcodret != 0 ]
then
	   echo " - INF, copie $FIC/FIPS_CIPJJ vers $TMP/FIPS_CIPJJ_ORI ," $wcodret
     exit 0
fi

FF1=$TMP/FIPS_CIPJJ_ORI ;export FF1
FF2=$FIC/FIPS_CIPJJ      ;export FF2
cobrun +Q $EXE/cipbamsips.gnt
unset FF1
unset FF2
