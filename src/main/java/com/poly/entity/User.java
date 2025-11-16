package com.poly.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Users")
public class User {
    @Id
    private String id; // PK
    
    private String password;
    private String email;
    private String fullname;
    private Boolean admin = false; // Mặc định là false

    // Constructor mặc định (Bắt buộc cho JPA)
    public User() {}

    // Constructor đầy đủ
    public User(String id, String password, String email, String fullname, Boolean admin) {
        this.id = id;
        this.password = password;
        this.email = email;
        this.fullname = fullname;
        this.admin = admin;
    }
    
    // Getters và Setters (Bắt buộc)
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    // ... Các Getters/Setters khác ...
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public Boolean getAdmin() { return admin; }
    public void setAdmin(Boolean admin) { this.admin = admin; }
}