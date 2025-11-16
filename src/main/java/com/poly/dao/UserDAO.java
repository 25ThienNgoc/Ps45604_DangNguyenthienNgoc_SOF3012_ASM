package com.poly.dao;

import com.poly.entity.User;
import java.util.List;

public interface UserDAO {
    
    /**
     * Tạo một người dùng mới (Đăng ký).
     * @param entity Đối tượng User cần lưu.
     * @return Đối tượng User đã được lưu.
     */
    User create(User entity);
    
    /**
     * Cập nhật thông tin người dùng (Đổi mật khẩu, Cập nhật Profile).
     * @param entity Đối tượng User đã cập nhật.
     * @return Đối tượng User đã được cập nhật.
     */
    User update(User entity);
    
    /**
     * Xóa một người dùng (Thường là vô hiệu hóa `Active` thay vì xóa vật lý).
     * @param id ID (Username) của người dùng cần xóa.
     */
    void delete(String id);
    
    /**
     * Tìm kiếm người dùng theo ID (Username) (Dùng cho Login, Edit Profile).
     * @param id ID (Username) cần tìm.
     * @return Đối tượng User, hoặc null nếu không tìm thấy.
     */
    User findById(String id);
    
    /**
     * Tìm kiếm người dùng theo Email (Dùng cho Forgot Password).
     * @param email Email cần tìm.
     * @return Đối tượng User, hoặc null nếu không tìm thấy.
     */
    User findByEmail(String email);
    
    /**
     * Tìm kiếm người dùng theo Username và Email (Dùng cho Forgot Password).
     * @param username Tên đăng nhập.
     * @param email Email.
     * @return Đối tượng User, hoặc null nếu không tìm thấy.
     */
    User findByUsernameAndEmail(String username, String email);
    
    /**
     * Lấy tất cả người dùng.
     * @return Danh sách tất cả người dùng.
     */
    List<User> findAll();
}