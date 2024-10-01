package com.workshop.service;

import com.workshop.authentication.*;
import com.workshop.jwtservice.JwtService;
import com.workshop.model.userModel.Roles;
import com.workshop.model.userModel.User;
//import com.workshop.repositories.User.RoleCustomerRepository;
import com.workshop.repositories.User.RoleRepository;
import com.workshop.repositories.User.UserRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
//    private  final RoleCustomerRepository RoleCustomerReposetory;
    private  final RoleRepository roleRepository;
    private final JwtService jwtService;
    private final Logger logger = LoggerFactory.getLogger(AuthenticationService.class);
    public AuthenticationResponse authenticationResponse(AuthenticationRequest authenticationRequest){

        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authenticationRequest.getEmail(), authenticationRequest.getPassword()));
            User user = userRepository.findByEmail(authenticationRequest.getEmail()).orElseThrow();
            List<Roles> role = roleRepository.getRolesForUserByEmail(user.getEmail());
            Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
            Set<Roles> set = new HashSet<>();
            role.forEach(c -> set.add(new Roles(c.getName())));
            user.setRoles(set);
            set.forEach(i -> authorities.add(new SimpleGrantedAuthority(i.getName())));
            var jwtToken = jwtService.generateAccessToken(user, authorities);
            var jwtRefreshToken = jwtService.generateRefreshToken(user, authorities);

            UserResponse userResponse = new UserResponse();
            List<String> roles = new ArrayList<>();
            for (SimpleGrantedAuthority authority : authorities) {
                roles.add(authority.getAuthority());
            }
            userResponse.setEmail(user.getEmail())
                    .setUser_name(user.getUser_name()).setPhoneNumber(user.getPhoneNumber())
                    .setFull_name(user.getFull_name()).setGender(user.getGender()).setImage(user.getImage_url())
                    .setAccessToken(jwtToken)
                    .setRefreshToken(jwtRefreshToken)
                    .setRoles(roles);

            AuthenticationResponse<UserResponse> response = AuthenticationResponse.<UserResponse>builder()
                    .user(userResponse)
                    .build();

            return response;
        } catch (Exception e) {
            // Log the exception
            logger.error("An error occurred in authenticationResponse method.", e);

            // Handle the exception or rethrow it if needed
            throw new RuntimeException("An error occurred while processing the authentication request.", e);
        }
    }

    public AuthenticationResponse OauthenticationResponse(User OUse){

        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(OUse.getEmail(),OUse.getPassword()));
        User user = userRepository.findByEmail(OUse.getEmail()).orElseThrow();
        List<Roles> role = null;
//        if(user!=null){ role = RoleCustomerReposetory.getRole(user);}
        if(user!=null){ role = roleRepository.getRolesForUserByEmail(user.getEmail());}
        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();

        Set<Roles> set = new HashSet<>();
        role.stream().forEach(c->set.add(new Roles(c.getName())));
        user.setRoles(set);
        set.stream().forEach(i->authorities.add(new SimpleGrantedAuthority(i.getName())));
        var jwtToken = jwtService.generateAccessToken(user,authorities);
        var jwtRefreshToken = jwtService.generateRefreshToken(user,authorities);
        UserResponse userResponse = new UserResponse();
        List<String> roles = new ArrayList<>();

        for (SimpleGrantedAuthority authority : authorities) {
            roles.add(authority.getAuthority());
        }
        userResponse.setEmail(user.getEmail())
                .setUser_name(user.getUser_name())
                .setFull_name(user.getFull_name()).setPhoneNumber(user.getPhoneNumber()).setImage(user.getImage_url())
                .setAccessToken(jwtToken).setGender(user.getGender())
                .setRefreshToken(jwtRefreshToken)
                .setRoles(roles);
        AuthenticationResponse<UserResponse> response = AuthenticationResponse.<UserResponse>builder()
                .user(userResponse)
                .build();
        return response;
    }
}