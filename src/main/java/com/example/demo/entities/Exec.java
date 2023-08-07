package com.example.demo.entities;


import jakarta.persistence.*;

import lombok.Data;

import java.util.List;

@Entity
@Data
public class Exec {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String name;



}
