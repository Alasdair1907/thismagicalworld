package world.thismagical.entity;

import world.thismagical.util.PrivilegeLevel;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="authors")
public class AuthorEntity implements Serializable {
    @Id
    @Column(name="author_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long authorId;

    @Column(name="display_name")
    private String displayName;

    @Column(name="login")
    private String login;

    @Column(name="password")
    private String passwd;

    @Column(name="privilege_level")
    private Short privilegeLevel;

    public long getAuthorId() {
        return authorId;
    }

    public void setAuthorId(long authorId) {
        this.authorId = authorId;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public PrivilegeLevel getPrivilegeLevel() {
        return PrivilegeLevel.getPrivilegeLevel(this.privilegeLevel);
    }

    public void setPrivilegeLevel(PrivilegeLevel privilegeLevel) {
        this.privilegeLevel = privilegeLevel.getId();
    }

}
