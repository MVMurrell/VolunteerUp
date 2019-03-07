package com.itmakesavillage;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class MvcItMakesAVillageApplication extends SpringBootServletInitializer {
	  @Override
	  protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
	    return application.sources(MvcItMakesAVillageApplication.class);
	  }

	public static void main(String[] args) {
		SpringApplication.run(MvcItMakesAVillageApplication.class, args);
	}

}

