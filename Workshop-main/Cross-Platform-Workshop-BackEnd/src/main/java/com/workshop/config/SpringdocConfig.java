package com.workshop.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@OpenAPIDefinition
@SecurityScheme(
        name = "bearerAuth",
        description = "JWT auth Description",
        scheme = "bearer",
        type = SecuritySchemeType.HTTP,
        bearerFormat = "JWT",
        in = SecuritySchemeIn.HEADER
)
@Configuration
public class SpringdocConfig {
    @Bean
    public OpenAPI baseOpenAPI(){
        return  new OpenAPI().info(new Info().title("WorkShop API Service").version("1.0.0").description("WorkShop API Service"));
    }


}
