package com.example.demo;

import com.example.demo.entities.Script;
import com.example.demo.repositories.ScriptRepository;
import com.example.demo.services.ChaineService;
import com.example.demo.services.ChaineServiceImpl;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.io.IOException;
import java.util.Scanner;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }


    @Bean
    CommandLineRunner commandLineRunner(ChaineService chaineService)  {
        System.out.println(chaineService.getPath());




        return null;
    }


}
