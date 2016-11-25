package net.avk.crud.model;

import java.util.Date;
import javax.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "age")
    private int age;

    @Column(name = "isAdmin")
    private boolean isAdmin;

    @Column(name = "createdDate")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Date createdDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getIsAdmin() {
        String result = "No";
        if (isAdmin)
        result = "Yes";
        return result;
    }

    public void setIsAdmin(String isAdmin) {
        if (isAdmin.equals("Yes"))
        this.isAdmin = true;
        else
            this.isAdmin = false;
    }

     public Date getCreatedDate() {
         return createdDate;
    }

    public void setCreatedDate() {
        this.createdDate = new Date();
    }
}
