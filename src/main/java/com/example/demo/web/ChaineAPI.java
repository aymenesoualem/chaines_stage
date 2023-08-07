package com.example.demo.web;

import com.example.demo.config.ErrorResponse;
import com.example.demo.entities.Chaine;
import com.example.demo.entities.Script;
import com.example.demo.exceptions.ChaineAlreadyExistsException;
import com.example.demo.exceptions.ChaineNotFoundException;
import com.example.demo.exceptions.PathNotFoundException;
import com.example.demo.services.ChaineService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;


@RestController
@CrossOrigin("*")
@AllArgsConstructor
@Slf4j
public class ChaineAPI {
    ChaineService chaineService;


    @GetMapping("/chaines/{id}")

    public Chaine getChaine(@PathVariable Long id){
        return chaineService.getChaine(id);
    }

    @GetMapping("/scripts/{id}")

    public Script getScripts(@PathVariable Long id){
        return chaineService.getScript(id);
    }
    @PostMapping("/chaines/new")
    public Chaine saveChaine(@RequestBody Chaine chaine) throws IOException, ChaineNotFoundException, ChaineAlreadyExistsException {
        return chaineService.saveChaine(chaine.getName());
    }
    @PostMapping("/path/new")
    public void setPath(@RequestBody String path) throws PathNotFoundException {
         chaineService.setPath(path);
    }

    @GetMapping("/chaines")
    public List<Chaine> getChaines()
    {
        return chaineService.listchaines();
    }
    @GetMapping("/scripts")
    public List<Script> getScripts()
    {
        return chaineService.listScripts();
    }


    @PostMapping("/scripts/new")
    public Script saveScript(@RequestBody String name) throws IOException, ChaineNotFoundException {
        return chaineService.saveScript(name);
    }

    @GetMapping("/chaines/search")
    List<Chaine> searchChaines(@RequestParam(name = "name", defaultValue = "") String name) {
        return chaineService.searchChaines("%"+name+"%");
    }
    @GetMapping("/scripts/search")
    List<Script> searchScripts(@RequestParam(name = "name", defaultValue = "") String name) {
        return chaineService.searchScripts("%" + name + "%");
    }
    @DeleteMapping("/chaine/{id}")
    public void deleteChaine(@PathVariable(name = "id") Long id) {
        chaineService.deleteChaine(id);
    }
    @ExceptionHandler({IOException.class, ChaineNotFoundException.class, ChaineAlreadyExistsException.class, PathNotFoundException.class})
    public ResponseEntity<ErrorResponse> handleCustomException(Exception ex) {
        ErrorResponse errorResponse = new ErrorResponse(ex.getMessage());
        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }
    @GetMapping("/path")
    public String getPath(){
        return chaineService.getPath();
    }

}
