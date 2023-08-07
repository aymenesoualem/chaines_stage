package com.example.demo.entities;
import com.example.demo.enums.ScriptStatus;
import jakarta.persistence.*;
import jdk.jfr.BooleanFlag;
import lombok.*;

import java.util.List;
@Entity
@Data
@NoArgsConstructor @AllArgsConstructor
public class Script {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String name;

    @ManyToMany
    List<Fichier> fichiers;
    @ManyToMany
    List<Exec> execs;
    @ManyToMany
    List<Script> scripts;
    @Enumerated(EnumType.STRING)
    ScriptStatus status;
}
