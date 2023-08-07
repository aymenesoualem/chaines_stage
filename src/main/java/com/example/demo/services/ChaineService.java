package com.example.demo.services;

import com.example.demo.entities.Chaine;
import com.example.demo.entities.Exec;
import com.example.demo.entities.Fichier;
import com.example.demo.entities.Script;
import com.example.demo.exceptions.ChaineAlreadyExistsException;
import com.example.demo.exceptions.ChaineNotFoundException;
import com.example.demo.exceptions.PathNotFoundException;

import java.io.IOException;
import java.util.List;

public interface ChaineService {

     Exec saveExec(String line);
     Fichier saveFichier(String line);
     Script saveScript(String line) throws ChaineNotFoundException, IOException;
     Exec findExec(String name);
     Fichier findFichier(String line);
     Script findScript(String line);
     Chaine saveChaine(String line) throws ChaineNotFoundException, IOException, ChaineAlreadyExistsException;
     Chaine findChaine(String line);
     List<Chaine> listchaines();
     List<Script> listScripts();
     void deleteChaine(Long id);
     List<Chaine> searchChaines(String name);
     public List<Script> searchScripts(String name);
     Chaine getChaine(Long id);

     Script getScript(Long id);

     void setPath(String path) throws PathNotFoundException;

     String getPath();
}
