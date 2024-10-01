package com.workshop.config.cloud;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Storage;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.io.IOException;
import java.io.InputStream;

import com.google.firebase.cloud.StorageClient;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.io.ClassPathResource;

@Configuration
@Lazy
public class FireBaseQRService {

    @Bean
    public FirebaseApp initializeFirebaseApp() throws IOException {
        if (FirebaseApp.getApps().isEmpty()) {
            ClassPathResource resource = new ClassPathResource("workshopprojec04-firebase-adminsdk-hk50d-9ca90b8c3a.json");
            InputStream serviceAccount = resource.getInputStream();
            FirebaseOptions options = new FirebaseOptions.Builder().setStorageBucket("workshopprojec04.appspot.com")
                    .setProjectId("workshopprojec04")
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();
            return FirebaseApp.initializeApp(options);
        } else {
            return FirebaseApp.getInstance();
        }
    }
    @Bean
    public Storage getFirebaseStorage(FirebaseApp firebaseApp) {
        return StorageClient.getInstance(firebaseApp).bucket().getStorage();
    }
}
