package com.poly.dto;

import java.util.Date;

public class VideoFavoriteReport {
    // Tên (ID) của video
    private String videoId; 
    // Tiêu đề video
    private String videoTitle; 
    // Số lượng người yêu thích
    private Long favoriteCount; 
    // Ngày yêu thích mới nhất
    private Date latestDate; 
    // Ngày yêu thích cũ nhất
    private Date oldestDate; 

    // Constructor để JPA mapping
    public VideoFavoriteReport(String videoTitle, Long favoriteCount, Date latestDate, Date oldestDate) {
        this.videoTitle = videoTitle;
        this.favoriteCount = favoriteCount;
        this.latestDate = latestDate;
        this.oldestDate = oldestDate;
    }
    
    // Constructor cho Shared Report (để làm mẫu)
    // public VideoFavoriteReport(String senderName, String senderEmail, String receiverEmail, Date shareDate) { ... } 

    // Getters and Setters (Có thể tự tạo hoặc dùng Lombok)

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getVideoTitle() {
        return videoTitle;
    }

    public void setVideoTitle(String videoTitle) {
        this.videoTitle = videoTitle;
    }

    public Long getFavoriteCount() {
        return favoriteCount;
    }

    public void setFavoriteCount(Long favoriteCount) {
        this.favoriteCount = favoriteCount;
    }

    public Date getLatestDate() {
        return latestDate;
    }

    public void setLatestDate(Date latestDate) {
        this.latestDate = latestDate;
    }

    public Date getOldestDate() {
        return oldestDate;
    }

    public void setOldestDate(Date oldestDate) {
        this.oldestDate = oldestDate;
    }
