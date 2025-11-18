package com.poly.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Favorite", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"UserId", "VideoId"}) // Ràng buộc UNIQUE
})
public class Favorite implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne @JoinColumn(name = "UserId")
    private User user; // Khóa ngoại tới User

    @ManyToOne @JoinColumn(name = "VideoId")
    private Video video; // Khóa ngoại tới Video

    @Column(name = "LikeDate", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date likeDate = new Date();

    // Getters và Setters (Bạn cần thêm đầy đủ)
    // ...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Video getVideo() { return video; }
    public void setVideo(Video video) { this.video = video; }
    public Date getLikeDate() { return likeDate; }
    public void setLikeDate(Date likeDate) { this.likeDate = likeDate; }
}