package com.workshop.config;

import com.workshop.repositories.User.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.*;
import org.springframework.security.authentication.*;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.*;

@Configuration
@RequiredArgsConstructor
public class ApplicationConfig {
    private final UserRepository userRepository;
    @Bean
    public UserDetailsService userDetailsService() {
        return user_name -> userRepository.findByEmail(user_name).orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }
    @Bean
    public PasswordEncoder passwordEncoder() {
        DelegatingPasswordEncoder delegatingPasswordEncoder = (DelegatingPasswordEncoder) PasswordEncoderFactories.createDelegatingPasswordEncoder();
        delegatingPasswordEncoder.setDefaultPasswordEncoderForMatches(new BCryptPasswordEncoder());
        return delegatingPasswordEncoder;
    }
    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(userDetailsService());
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        return authenticationProvider;
    }
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }
}
