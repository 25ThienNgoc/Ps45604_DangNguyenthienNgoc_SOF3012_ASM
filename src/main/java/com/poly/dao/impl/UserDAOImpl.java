package com.poly.dao.impl;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;
import com.poly.util.JpaUtil; 

public class UserDAOImpl implements UserDAO {

    @Override
    public User create(User entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
            return entity;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi khi tạo người dùng (Đăng ký): " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public User update(User entity) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        
        try {
            trans.begin();
            // Phương thức merge được dùng để cập nhật
            User updatedUser = em.merge(entity);
            trans.commit();
            return updatedUser;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi khi cập nhật người dùng: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        
        try {
            User user = em.find(User.class, id);
            if (user != null) {
                trans.begin();
                em.remove(user); // Xóa vật lý
                trans.commit();
            }
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi khi xóa người dùng: " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    @Override
    public User findById(String id) {
        EntityManager em = JpaUtil.getEntityManager();
        User user = em.find(User.class, id);
        em.close();
        return user;
    }

    @Override
    public User findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.email = :email";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setParameter("email", email);
        
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public User findByUsernameAndEmail(String username, String email) {
        EntityManager em = JpaUtil.getEntityManager();
        String jpql = "SELECT u FROM User u WHERE u.id = :username AND u.email = :email";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setParameter("username", username);
        query.setParameter("email", email);
        
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<User> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        String jpql = "SELECT u FROM User u";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        List<User> list = query.getResultList();
        em.close();
        return list;
    }
}