package com.example.demo.repositories;

import com.example.demo.entities.Fichier;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FichierRepository extends JpaRepository<Fichier,Long> {
     Fichier findByName(String name);
}
