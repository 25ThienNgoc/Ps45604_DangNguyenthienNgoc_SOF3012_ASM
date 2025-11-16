package com.poly.dao.impl;

import com.poly.dao.FavoriteDAO;
import com.poly.entity.Favorite;
import com.poly.entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import com.poly.util.JpaUtil; 

public class FavoriteDAOImpl implements FavoriteDAO {

    @Override
    public Favorite create(Favorite entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
            return entity;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi khi tạo bản ghi Favorite: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String userId, String videoId) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        
        // 1. Tìm bản ghi Favorite
        Favorite favorite = findFavorite(userId, videoId);
        
        if (favorite != null) {
            try {
                trans.begin();
                // Phải merge trước khi xóa nếu favorite không nằm trong context hiện tại
                em.remove(em.contains(favorite) ? favorite : em.merge(favorite));
                trans.commit();
            } catch (Exception e) {
                if (trans.isActive()) trans.rollback();
                throw new RuntimeException("Lỗi khi xóa bản ghi Favorite: " + e.getMessage(), e);
            } finally {
                em.close();
            }
        }
    }

    @Override
    public List<Video> findFavoriteVideosByUserId(String userId) {
        EntityManager em = JpaUtil.getEntityManager();
        
        // JPQL: Truy vấn các đối tượng Video thông qua bảng Favorite
        String jpql = "SELECT f.video FROM Favorite f WHERE f.user.id = :uid ORDER BY f.likeDate DESC";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        query.setParameter("uid", userId);
        
        List<Video> list = query.getResultList();
        em.close();
        return list;
    }

    @Override
    public Favorite findFavorite(String userId, String videoId) {
        EntityManager em = JpaUtil.getEntityManager();
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :uid AND f.video.id = :vid";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        query.setParameter("uid", userId);
        query.setParameter("vid", videoId);
        
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // Không tìm thấy
        } finally {
            em.close();
        }
    }
}