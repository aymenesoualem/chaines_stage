package com.example.demo.services;

import com.example.demo.config.PathConfig;
import com.example.demo.entities.Chaine;
import com.example.demo.entities.Exec;
import com.example.demo.entities.Fichier;
import com.example.demo.entities.Script;
import com.example.demo.enums.ScriptStatus;
import com.example.demo.exceptions.ChaineAlreadyExistsException;
import com.example.demo.exceptions.ChaineNotFoundException;
import com.example.demo.exceptions.PathNotFoundException;
import com.example.demo.repositories.ChaineRepository;
import com.example.demo.repositories.ExecRepository;
import com.example.demo.repositories.FichierRepository;
import com.example.demo.repositories.ScriptRepository;
import lombok.AllArgsConstructor;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;


@Service
@Transactional
@AllArgsConstructor
public class ChaineServiceImpl implements ChaineService{
    ChaineRepository chaineRepository;
    ExecRepository execRepository;
    FichierRepository fichierRepository;
    ScriptRepository scriptRepository;
    PathConfig pathConfig;
     String  filePath;






    @Override
    public Exec saveExec(String line) {
        Exec exec=new Exec();
        exec.setName(line);
        return execRepository.save(exec);

    }

    @Override
    public Fichier saveFichier(String line) {
        Fichier fichier= new Fichier();
        fichier.setName(line);
        return fichierRepository.save(fichier);
    }


    @Override
    public Script saveScript(String line) throws  IOException {

            Script script = new Script();
            script.setScripts(new ArrayList<>());
            script.setExecs(new ArrayList<>());
            script.setFichiers(new ArrayList<>());
            script.setName(line);
            Script script2;
            Fichier fichier;
            Exec exec;
            File file = new File(line);
            if (file.exists()) {


                BufferedReader reader = new BufferedReader(new FileReader(file));
                String fileLine;
                while ((fileLine = reader.readLine()) != null) {

                    if (fileLine.startsWith("$shs")) {
                        StringTokenizer words = new StringTokenizer(fileLine);
                        String word = words.nextToken();
                        word = word.substring(5);

                        if ((script2 = findScript(filePath + word)) == null) {
                            script2 = saveScript(filePath + word);
                        }
                        script.getScripts().add(script2);
                    }
                    if (fileLine.startsWith("FF")) {
                        if ((fichier = findFichier(fileLine)) == null) {
                            fichier = saveFichier(fileLine);
                        }
                        script.getFichiers().add(fichier);

                    }
                    if (fileLine.startsWith("cobrun")) {
                        if ((exec = findExec(fileLine)) == null) {
                            exec = saveExec(fileLine);
                        }
                        script.getExecs().add(exec);

                    }


                }
                script.setStatus(ScriptStatus.FOUND);
            }
            else {
                script.setStatus(ScriptStatus.NOTFOUND);

            }
            return scriptRepository.save(script);



    }

    @Override
    public Exec findExec(String name) {
        return execRepository.findByName(name);
    }

    @Override
    public Fichier findFichier(String line) {
        return fichierRepository.findByName(line);
    }

    @Override
    public Script findScript(String line) {
        return scriptRepository.findByName(line);
    }

   @Override
    public Chaine saveChaine(String line) throws ChaineNotFoundException, ChaineAlreadyExistsException {


            Chaine chaine = new Chaine();
            chaine.setScripts(new ArrayList<>());
            chaine.setFichiers(new ArrayList<>());
            chaine.setExecs(new ArrayList<>());
            chaine.setName(filePath+line);
            Script script;
            Fichier fichier;
            Exec exec;
            File file = new File(filePath+line);
            if(!(chaineRepository.findByName(filePath+line) == null))
                throw new ChaineAlreadyExistsException("Chaine "+filePath+line+" deja existante");

           try {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String fileLine;
                while((fileLine=reader.readLine())!=null){

                    if(fileLine.startsWith("$SHS"))
                    {
                        StringTokenizer words= new StringTokenizer(fileLine);

                        String word= words.nextToken();
                        word =word.substring(5);

                        if((script=findScript(filePath+word))==null)
                        {
                            script=saveScript(filePath+word);
                        }
                        chaine.getScripts().add(script);
                    }
                    if(fileLine.startsWith("FF"))
                    {
                        if((fichier=findFichier(fileLine))==null)
                        {
                            fichier=saveFichier(fileLine);
                        }
                        chaine.getFichiers().add(fichier);

                    }
                    if(fileLine.contains("cobrun"))
                    {
                        if((exec=findExec(fileLine))==null)
                        {
                            exec=saveExec(fileLine);

                        }
                        chaine.getExecs().add(exec);

                    }


                }
                return chaineRepository.save(chaine);
            }catch (IOException e)
            {
                throw new ChaineNotFoundException("Chaine "+filePath+line+" introuvable");
            }
    }

    @Override
    public Chaine findChaine(String line) {
        return chaineRepository.findByName(line);
    }

    @Override
    public List<Chaine> listchaines() {
        return chaineRepository.findAll();
    }

    @Override
    public List<Script> listScripts() {

        return scriptRepository.findAll();
    }



    @Override
    public void deleteChaine(Long id) {
        chaineRepository.deleteById(id);
    }

    @Override
    public List<Chaine> searchChaines(String name) {
        return chaineRepository.searchChaine(name);
    }
    @Override
    public List<Script> searchScripts(String name) {
        return scriptRepository.searchScript(name);
    }

    @Override
    public Chaine getChaine(Long id) {
        return chaineRepository.findById(id).orElse(null);
    }

    @Override
    public Script getScript(Long id) {
        return scriptRepository.findById(id).orElse(null);
    }
    @Override
    public void setPath(String path) throws PathNotFoundException {
        File file = new File(path);
        if(file.isDirectory()){
            filePath=path;
        }
        else {
            throw new PathNotFoundException("Repertoire "+path+" introuvable");
        }
    }
    @Override
    public String getPath()
    {

        return filePath;
    }

}
