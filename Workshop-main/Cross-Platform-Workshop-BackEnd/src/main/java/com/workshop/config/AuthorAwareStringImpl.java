package com.workshop.config;

import com.workshop.model.userModel.User;
import com.workshop.repositories.User.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service

public class AuthorAwareStringImpl implements AuditorAware<String> {
    @Autowired
    private UserRepository userRepository;
    @Override
    public Optional<String> getCurrentAuditor() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof String) {
            String email = (String) authentication.getPrincipal();
            if (email.equals("anonymousUser")) {
                return Optional.of("null");
            } else {
                Optional<User> userOptional = userRepository.findByEmail(email);
                if (userOptional.isPresent()) {
                    User user = userOptional.get();
                    return Optional.of(user.getUser_name());
                }
            }
        }
        return Optional.of("null");
    }


}
