package com.poly.dao;

import com.poly.entity.Video;
import java.util.List;

public interface VideoDAO {
    
    /**
     * Tìm video theo ID.
     */
    Video findById(String id);
    
    /**
     * Trả về danh sách video được phân trang và đang active.
     * @param firstResult Vị trí bắt đầu.
     * @param maxResult Số lượng video tối đa mỗi trang.
     * @return List<Video>
     */
    List<Video> findPage(int firstResult, int maxResult);
    
    /**
     * Đếm tổng số video đang active.
     * @return Long tổng số video.
     */
    Long countActive();
    
    // Thêm các CRUD cơ bản nếu cần:
    // Video create(Video entity);
    // void update(Video entity);
    // void delete(String id);
}