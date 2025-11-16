package com.poly.dao.impl;

import com.poly.dao.ReportDAO;
import com.poly.dto.VideoFavoriteReport;
import com.poly.entity.Share;
import com.poly.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class ReportDAOImpl implements ReportDAO {

    @Override
    public List<VideoFavoriteReport> reportVideoFavorites() {
        EntityManager em = JpaUtil.getEntityManager();
        
        // Truy vấn JPQL sử dụng Constructor Expression để mapping trực tiếp
        String jpql = "SELECT new com.poly.dto.VideoFavoriteReport("
                    + "   f.video.title, " // Video Title
                    + "   COUNT(f), "     // Favorite Count
                    + "   MAX(f.likeDate), " // Latest Date
                    + "   MIN(f.likeDate) "  // Oldest Date
                    + ") "
                    + "FROM Favorite f "
                    + "GROUP BY f.video.title, f.video.id "
                    + "ORDER BY COUNT(f) DESC";
        
        TypedQuery<VideoFavoriteReport> query = em.createQuery(jpql, VideoFavoriteReport.class);
        
        List<VideoFavoriteReport> result = query.getResultList();
        em.close();
        return result;
    }

    @Override
    public List<Share> findSharedUsersByVideoId(String videoId) {
        EntityManager em = JpaUtil.getEntityManager();
        
        // Truy vấn lấy danh sách Share theo Video ID
        String jpql = "SELECT s FROM Share s WHERE s.video.id = :videoId";
        TypedQuery<Share> query = em.createQuery(jpql, Share.class);
        query.setParameter("videoId", videoId);
        
        List<Share> result = query.getResultList();
        em.close();
        return result;
    }

    @Override
    public List<String> findSharedVideoIds() {
        EntityManager em = JpaUtil.getEntityManager();
        
        // Lấy danh sách các VideoId (Distinct) có trong bảng Share
        String jpql = "SELECT DISTINCT s.video.id FROM Share s";
        TypedQuery<String> query = em.createQuery(jpql, String.class);
        
        List<String> result = query.getResultList();
        em.close();
        return result;
    }
}