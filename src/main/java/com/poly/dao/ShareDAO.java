package com.poly.dao;

import com.poly.entity.Share;
import java.util.List;

public interface ShareDAO {
    
    /**
     * Lưu một bản ghi chia sẻ mới vào cơ sở dữ liệu.
     * @param entity Đối tượng Share cần lưu.
     * @return Đối tượng Share đã được lưu.
     */
    Share create(Share entity);
    
    /**
     * Tìm kiếm một bản ghi chia sẻ theo ID.
     * @param id Khóa chính của Share.
     * @return Đối tượng Share, hoặc null nếu không tìm thấy.
     */
    Share findById(Long id);
    
    /**
     * Lấy danh sách các bản ghi chia sẻ bởi một User.
     * @param userId ID của người dùng.
     * @return Danh sách các bản ghi Share.
     */
    List<Share> findByUserId(String userId);
    
    // Bạn có thể thêm các phương thức khác như update, delete, findAll nếu cần.
}