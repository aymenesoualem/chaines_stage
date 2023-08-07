package com.example.demo.config;

import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

@Configuration
public class PathConfig {
    private final String filePath = System.getProperty("user.dir")+"\\SHS\\"; // Replace with your initial file path

    @Bean
    @Scope(value = ConfigurableBeanFactory.SCOPE_SINGLETON)
    public String filePath() {
        return filePath;
    }
}
