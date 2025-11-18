package com.poly.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "Video")
@NamedQuery(name = "Video.findAllActive", query = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.id DESC")
public class Video implements Serializable {
    @Id
    @Column(name = "Id")
    private String id;

    @Column(name = "Title", nullable = false)
    private String title;

    @Column(name = "Poster")
    private String poster;

    @Column(name = "Views", nullable = false)
    private Integer views = 0;

    @Column(name = "Description")
    private String description;

    @Column(name = "Active", nullable = false)
    private Boolean active = true;

    // Mapping tới các bảng liên quan (Tùy chọn)
    @OneToMany(mappedBy = "video", fetch = FetchType.LAZY)
    private List<Favorite> favorites = new ArrayList<>();

    @OneToMany(mappedBy = "video", fetch = FetchType.LAZY)
    private List<Share> shares = new ArrayList<>();

    // Getters và Setters (Bạn cần thêm đầy đủ)
    // ...
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public List<Favorite> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<Favorite> favorites) {
        this.favorites = favorites;
    }

    public List<Share> getShares() {
        return shares;
    }

    public void setShares(List<Share> shares) {
        this.shares = shares;
    }
}