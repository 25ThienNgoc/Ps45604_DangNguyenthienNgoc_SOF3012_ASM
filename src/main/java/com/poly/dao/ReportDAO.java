package com.poly.dao;

import com.poly.dto.VideoFavoriteReport;
import com.poly.entity.Share;
import java.util.List;

public interface ReportDAO {
    
    /**
     * Thống kê số người yêu thích từng video.
     * Tương ứng với Tab FAVORITES.
     * @return Danh sách các đối tượng VideoFavoriteReport.
     */
    List<VideoFavoriteReport> reportVideoFavorites();
    
    /**
     * Lấy danh sách các bản ghi chia sẻ dựa trên VideoId.
     * Tương ứng với Tab SHARED FRIENDS có filter.
     * @param videoId ID của video cần lọc.
     * @return Danh sách các bản ghi Share.
     */
    List<Share> findSharedUsersByVideoId(String videoId);
    
    /**
     * Lấy danh sách tất cả các Video có lượt chia sẻ (dùng cho Select Box filter).
     * @return Danh sách các Video ID.
     */
    List<String> findSharedVideoIds();
}