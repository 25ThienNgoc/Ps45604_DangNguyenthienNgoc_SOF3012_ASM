package com.poly.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "Share")
public class Share implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne @JoinColumn(name = "UserId")
    private User user; // Khóa ngoại tới User (Người chia sẻ)

    @ManyToOne @JoinColumn(name = "VideoId")
    private Video video;

    @Column(name = "Emails", nullable = false)
    private String emails; // Chuỗi emails người nhận

    @Column(name = "ShareDate", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date shareDate = new Date();

    // Getters và Setters (Bạn cần thêm đầy đủ)
    // ...
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Video getVideo() { return video; }
    public void setVideo(Video video) { this.video = video; }
    public String getEmails() { return emails; }
    public void setEmails(String emails) { this.emails = emails; }
    public Date getShareDate() { return shareDate; }
    public void setShareDate(Date shareDate) { this.shareDate = shareDate; }
}