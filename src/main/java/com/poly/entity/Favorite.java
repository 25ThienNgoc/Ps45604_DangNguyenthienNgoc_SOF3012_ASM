package com.poly.entity;

import jakarta.persistence.*; // Sử dụng Jakarta Persistence API (cho Jakarta EE / Tomcat 10+)
import java.util.Date;

@Entity
@Table(name = "Favorites")
public class Favorite {
    public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}

	public Date getLikeDate() {
		return likeDate;
	}

	public void setLikeDate(Date likeDate) {
		this.likeDate = likeDate;
	}

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // PK

    // Mối quan hệ Many-to-One: Nhiều Favorite thuộc về Một User
    @ManyToOne
    @JoinColumn(name = "UserId", referencedColumnName = "id") // FK UserId trỏ đến User.id
    private User user;

    // Mối quan hệ Many-to-One: Nhiều Favorite cho Một Video
    @ManyToOne
    @JoinColumn(name = "VideoId", referencedColumnName = "id") // FK VideoId trỏ đến Video.id
    private Video video;

    @Temporal(TemporalType.DATE)
    private Date likeDate;

}