package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Profile;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@SpringBootApplication
public class Project1Application extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(Project1Application.class, args);
	}
	
	@Profile({"dev", "test"})
	@Bean
    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }
	
	@Override 
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) { 
	   return builder.sources(Project1Application.class); 
	}

}
