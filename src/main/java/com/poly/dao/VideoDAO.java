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
     * 
     * @param firstResult Vị trí bắt đầu.
     * @param maxResult   Số lượng video tối đa mỗi trang.
     * @return List<Video>
     */
    List<Video> findPage(int firstResult, int maxResult);

    /**
     * Đếm tổng số video đang active.
     * 
     * @return Long tổng số video.
     */
    Long countActive();

    /**
     * Đếm tổng số video (kể cả inactive).
     * 
     * @return Long tổng số video.
     */
    Long countAll();

    /**
     * Lấy danh sách tất cả video (kể cả inactive).
     * 
     * @return List<Video>
     */
    List<Video> findAll();

    // Thêm các CRUD cơ bản nếu cần:
    // Video create(Video entity);
    // void update(Video entity);
    // void delete(String id);
}