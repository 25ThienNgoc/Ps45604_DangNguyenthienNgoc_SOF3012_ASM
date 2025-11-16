package com.poly.dao.impl;

import com.poly.dao.ShareDAO;
import com.poly.entity.Share;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;
import com.poly.util.JpaUtil; // Giả sử bạn có lớp tiện ích JpaUtil

public class ShareDAOImpl implements ShareDAO {

    @Override
    public Share create(Share entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        
        try {
            trans.begin();
            // Sử dụng persist để thêm đối tượng mới vào cơ sở dữ liệu
            em.persist(entity);
            trans.commit();
            return entity;
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            // Trong ứng dụng thực tế, nên log lỗi và ném ra một ngoại lệ tùy chỉnh
            throw new RuntimeException("Lỗi khi tạo bản ghi Share: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public Share findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        // Phương thức find là cách đơn giản để tìm kiếm theo khóa chính
        Share share = em.find(Share.class, id);
        em.close();
        return share;
    }

    @Override
    public List<Share> findByUserId(String userId) {
        EntityManager em = JpaUtil.getEntityManager();
        
        // JPQL để truy vấn các bản ghi Share dựa trên ID người dùng
        String jpql = "SELECT o FROM Share o WHERE o.user.id = :uid ORDER BY o.shareDate DESC";
        TypedQuery<Share> query = em.createQuery(jpql, Share.class);
        query.setParameter("uid", userId);
        
        List<Share> list = query.getResultList();
        em.close();
        return list;
    }
}