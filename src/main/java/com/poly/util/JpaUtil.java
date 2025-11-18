package com.poly.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {
    private static EntityManagerFactory factory;

    static {
        try {
            factory = Persistence.createEntityManagerFactory("OnlineEntertainmentPU"); 
        } catch (Exception e) {
            System.err.println("Lỗi khởi tạo EntityManagerFactory: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Tạo và trả về một EntityManager mới.
     * @return EntityManager
     */
    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }
    
    // Tùy chọn: Đóng factory khi ứng dụng kết thúc
    public static void shutdown() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}