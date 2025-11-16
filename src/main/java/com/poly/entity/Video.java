package com.poly.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "Videos")
@NamedQuery(name = "Video.findAllActive", query = "SELECT o FROM Video o WHERE o.active = true ORDER BY o.views DESC")
public class Video {
    @Id
    private String id; // PK
    
    private String title;
    private String poster;
    private Integer views = 0; // Mặc định 0
    private String description;
    private Boolean active = true; // Mặc định true

    public Video() {}
    // ... Constructor đầy đủ ...
    
    // Getters và Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    // ... Các Getters/Setters khác ...
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }
    public Integer getViews() { return views; }
    public void setViews(Integer views) { this.views = views; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }
}