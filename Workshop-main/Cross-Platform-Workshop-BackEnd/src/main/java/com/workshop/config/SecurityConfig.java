package com.workshop.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private  final JwtSecurityFilter jwtSecurityFilter;
    private  final AuthenticationProvider authenticationProvider;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws  Exception{
//        http.csrf(csrf->csrf.disable());
        http.csrf(AbstractHttpConfigurer::disable);
        http.sessionManagement(sess -> sess.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
        http.authorizeRequests()
                .requestMatchers(HttpMethod.OPTIONS,"/**").permitAll()

                .requestMatchers("/auth/**").permitAll()
                .requestMatchers("/test/**").permitAll()
                .requestMatchers("/web/**").permitAll()
                .requestMatchers("/swagger-ui/**").permitAll()
                .requestMatchers("/v3/api-docs/**").permitAll()
                .requestMatchers("/user/**").hasAnyAuthority("USER","SELLER","ADMIN")
                .requestMatchers("/seller/**").hasAnyAuthority("SELLER","ADMIN")
                .requestMatchers("/admin/**").hasAnyAuthority("ADMIN")
                .requestMatchers("/h2-console/**", "/ws", "/ws/**", "/app/**", "/topic/**",
                        "/img/**", "/websocket-server", "/websocket-server/**").permitAll()
                .and()
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeRequests()
                .anyRequest().authenticated()
                .and()
               .authenticationProvider(authenticationProvider)
                .addFilterBefore(jwtSecurityFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}
