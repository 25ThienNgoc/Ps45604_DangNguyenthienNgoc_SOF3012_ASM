package com.poly.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Shares")
public class Share {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // PK

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

	public String getEmails() {
		return emails;
	}

	public void setEmails(String emails) {
		this.emails = emails;
	}

	public Date getShareDate() {
		return shareDate;
	}

	public void setShareDate(Date shareDate) {
		this.shareDate = shareDate;
	}

	// Mối quan hệ Many-to-One
    @ManyToOne
    @JoinColumn(name = "UserId", referencedColumnName = "id") // FK UserId
    private User user;

    // Mối quan hệ Many-to-One
    @ManyToOne
    @JoinColumn(name = "VideoId", referencedColumnName = "id") // FK VideoId
    private Video video;

    private String emails;

    @Temporal(TemporalType.DATE)
    private Date shareDate;

    // Constructors, Getters và Setters
    // ...
}