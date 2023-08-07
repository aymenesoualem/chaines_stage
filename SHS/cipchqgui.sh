#
. ./INITenvironnement.sh 
echo
echo " *** cipchqgui.sh ***" 
echo "    -------------"
echo " --- EXTRACTION MOUVEMENT RETRAIT CHQ GUICHET "
export FFI1=$FIC/prm_ycg030_cg25
export FFO1=$TMP/fluxcip_chqgui
#
cobrun +Q $EXE/cipchqgui01.gnt
unset FFI1
unset FFO1
echo
echo " TRI FICHIER MOUVEMENT RETRAIT CHQ GUICHET, (ENTRER/CTRL+C) - CONTINER/ QUITTER "
##read a
mfsort SORT FIELDS \(15,19,CH,A,61,10,CH,A,57,3,CH,D,72,12,CH,A,71,1,CH,A\) USE $TMP/fluxcip_chqgui ORG RL RECORD F,128 GIVE $TMP/fluxcip_chqgui_t ORG RL RECORD F,128
echo " NOMBRE ENTREE TRI   : " `wc -l $TMP/fluxcip_chqgui`
echo " NOMBRE SORTIE TRI   : " `wc -l $TMP/fluxcip_chqgui_t`
echo
echo " SUPPRIMER LES MOUVEMENT EN DOUBLE GUICHET, (ENTRER/CTRL+C) - CONTINER/ QUITTER "
##read a
export FFI1=$TMP/fluxcip_chqgui_t
export FFO1=$MVT/fluxcip_chqgui
#
cobrun +Q $EXE/cipchqgui02.gnt
echo
