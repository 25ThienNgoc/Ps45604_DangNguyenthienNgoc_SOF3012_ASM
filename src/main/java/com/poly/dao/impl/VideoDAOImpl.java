package com.poly.dao.impl;

import com.poly.dao.VideoDAO;
import com.poly.entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import com.poly.util.JpaUtil; // Giả sử bạn có lớp tiện ích này

public class VideoDAOImpl implements VideoDAO {

    // Sử dụng JpaUtil để lấy EntityManager
    @Override
    public Video findById(String id) {
        EntityManager em = JpaUtil.getEntityManager();
        Video video = em.find(Video.class, id);
        em.close();
        return video;
    }

    @Override
    public List<Video> findPage(int firstResult, int maxResult) {
        EntityManager em = JpaUtil.getEntityManager();

        // Sử dụng NamedQuery đã định nghĩa trong class Video
        TypedQuery<Video> query = em.createNamedQuery("Video.findAllActive", Video.class);

        // Thiết lập phân trang
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResult);

        List<Video> list = query.getResultList();
        em.close();
        return list;
    }

    @Override
    public Long countActive() {
        EntityManager em = JpaUtil.getEntityManager();
        String jpql = "SELECT count(o) FROM Video o WHERE o.active = true";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);

        Long count = query.getSingleResult();
        em.close();
        return count;
    }

    @Override
    public Long countAll() {
        EntityManager em = JpaUtil.getEntityManager();
        String jpql = "SELECT count(o) FROM Video o";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);

        Long count = query.getSingleResult();
        em.close();
        return count;
    }

    @Override
    public List<Video> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        String jpql = "SELECT o FROM Video o ORDER BY o.id DESC";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);

        List<Video> list = query.getResultList();
        em.close();
        return list;
    }
}