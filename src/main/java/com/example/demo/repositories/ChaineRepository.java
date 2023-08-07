package com.example.demo.repositories;

import com.example.demo.entities.Chaine;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ChaineRepository extends JpaRepository<Chaine,Long> {
     Chaine findByName(String name);
     @Query(value = "select c from Chaine c where c.name like :name")
     List<Chaine> searchChaine(@Param("name")String name);
}
