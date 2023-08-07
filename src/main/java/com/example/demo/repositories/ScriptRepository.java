package com.example.demo.repositories;

import com.example.demo.entities.Chaine;
import com.example.demo.entities.Script;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ScriptRepository extends JpaRepository<Script,Long> {
     Script findByName(String name);
     @Query(value = "select s from Script s where s.name like :name")
     List<Script> searchScript(@Param("name")String name);
}
