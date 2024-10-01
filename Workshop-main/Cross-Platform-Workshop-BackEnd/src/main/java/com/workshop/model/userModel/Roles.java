package com.workshop.model.userModel;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.workshop.model.userModel.User;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import java.util.HashSet;
import java.util.Set;

@Data
@Getter
@Setter
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@Table(name="roles")
public class Roles {
    @Id
    @SequenceGenerator(
            name = "role_sequence",
            sequenceName = "role_sequence",
            allocationSize = 1
    )
    @GeneratedValue(strategy = GenerationType.AUTO,generator = "role_sequence")
    private Long id;
    private String name;

    @ManyToMany(mappedBy = "roles", fetch = FetchType.EAGER)
    @JsonIgnore
    private Set<User> user = new HashSet<>();


    public Roles(Long id, String name) {
        this.id = id;
        this.name = name;
    }
    public Roles(String name) {
        this.name = name;
    }
}
