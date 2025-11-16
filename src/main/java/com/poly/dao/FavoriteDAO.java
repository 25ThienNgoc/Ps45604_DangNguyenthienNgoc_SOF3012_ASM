package com.poly.dao;

import com.poly.entity.Favorite;
import com.poly.entity.Video;
import com.poly.entity.User;
import java.util.List;

public interface FavoriteDAO {
    
    /**
     * Thêm video vào danh sách yêu thích (tạo bản ghi Favorite).
     */
    Favorite create(Favorite entity);
    
    /**
     * Xóa video khỏi danh sách yêu thích (xóa bản ghi Favorite).
     * @param userId ID người dùng.
     * @param videoId ID video.
     */
    void delete(String userId, String videoId);
    
    /**
     * Lấy tất cả video yêu thích của một người dùng.
     * @param userId ID người dùng.
     * @return Danh sách các đối tượng Video.
     */
    List<Video> findFavoriteVideosByUserId(String userId);

    /**
     * Kiểm tra xem một video đã được người dùng yêu thích hay chưa.
     */
    Favorite findFavorite(String userId, String videoId);
}