package com.pwk.service.impl;

import com.pwk.entity.Product;
import com.pwk.service.ImageService;
import com.pwk.service.ProductService;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-17
 * Time: 下午10:23
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public class ProductServiceImpl implements ProductService {
    @Resource
    private SessionFactory sessionFactory;
    @Resource
    private JdbcTemplate jdbcTemplate;
    @Resource
    private ImageService imageService;

    @Override
    public void add(Product product) {
        sessionFactory.getCurrentSession().save(product);
    }

    @Override
    public void update(Product product) {
        sessionFactory.getCurrentSession().update(product);
    }

    @Override
    public void delete(int id) {
        imageService.deleteByProductId("product",id);
        sessionFactory.getCurrentSession().delete(this.getProductById(id,true));
    }

    @Override
    public Product getProductById(int id,boolean status) {
        Product product = (Product) sessionFactory.getCurrentSession().get(Product.class, id);
        if(product!=null&&(status||StringUtils.equals(product.getStatus(),"1")))
            return product;
        else
            return null;
    }

    @Override
    public List<Product> getProductByBrandId(Integer brandId, int page, int size,boolean status) {
        String sql = "";
        if (brandId == 0) {
            if(status)
                sql = " from Product p order by p.updateDate desc";
            else
                sql = " from Product p where p.status=1 order by p.updateDate desc";
            Query query = sessionFactory.getCurrentSession().createQuery(sql);
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
            return query.list();
        } else {
            if(status)
                sql = "from Product p where p.brand.id=:id order by p.updateDate desc";
            else
                sql = "from Product p where p.status=1 and p.brand.id=:id order by p.updateDate desc";
            Query query = sessionFactory.getCurrentSession().createQuery(sql);
            query.setParameter("id",brandId, Hibernate.INTEGER);
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
            return query.list();
        }
    }

    @Override
    public List<Product> getProductByCategoryId(Integer categoryId, int page, int size, boolean status) {
        String sql = "";
        if (categoryId == 0) {
            if(status)
                sql = " from Product p order by p.updateDate desc";
            else
                sql = " from Product p where p.status=1 order by p.updateDate desc";
            Query query = sessionFactory.getCurrentSession().createQuery(sql);
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
            return query.list();
        } else {
            if(status)
                sql = "from Product p where p.category.id=:id order by p.updateDate desc";
            else
                sql = "from Product p where p.status=1 and p.category.id=:id order by p.updateDate desc";
            Query query = sessionFactory.getCurrentSession().createQuery(sql);
            query.setParameter("id",categoryId, Hibernate.INTEGER);
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
            return query.list();
        }
    }

    @Override
    public List<Product> getAllProducts(boolean status) {
        if(status)
            return sessionFactory.getCurrentSession().createQuery("from Product p ").list();
        else
            return sessionFactory.getCurrentSession().createQuery("from Product p where p.status=1").list();
    }

    @Override
    public List<Product> getProductByList(int page, int size,boolean status) {
        Query query = null;
        if(status)
            query = sessionFactory.getCurrentSession().createQuery("from Product p order by p.updateDate desc");
        else
            query = sessionFactory.getCurrentSession().createQuery("from Product p where p.status=1 order by p.updateDate desc");
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public List<Product> getProductByRand(Integer brandId, int page, int size,boolean status) {
        Query query = null;
        if (brandId == 0) {
            if(status)
                query = sessionFactory.getCurrentSession().createQuery("from Product p order by rand()");
            else
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.status=1 order by rand()");
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
            return query.list();
        } else {
            if(status)
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:id order by rand()");
            else
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:id and p.status=1 order by rand()");
            query.setParameter("id",brandId,Hibernate.INTEGER);
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
            return query.list();
        }
    }

    @Override
    public List<Product> getProductBy_bId_cId_keyword(Integer brandId,Integer categoryId, String keyword, int page, int size, boolean status) {
        Query query = null;
        if (status) {
            if(brandId == 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.name like :keyword or p.brand.brandName like :keyword1 order by p.updateDate desc ");
            }else if(brandId == 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1) order by p.updateDate desc ");
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and (p.name like :keyword or p.brand.brandName like :keyword1) order by p.updateDate desc ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1) order by p.updateDate desc ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }
        } else {
            if(brandId == 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.name like :keyword or p.brand.brandName like :keyword1 desc ");
            }else if(brandId == 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1)  and p.status=1 order by p.updateDate desc ");
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and (p.name like :keyword or p.brand.brandName like :keyword1)  and p.status=1 order by p.updateDate desc ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1)  and p.status=1 order by p.updateDate desc ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }
        }
        query.setParameter("keyword", "%" + keyword + "%", Hibernate.STRING);
        query.setParameter("keyword1", "%" + keyword + "%", Hibernate.STRING);
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public int getTotal(boolean status) {
        if(status)
            return sessionFactory.getCurrentSession().createQuery("from Product p ").list().size();
        else
            return sessionFactory.getCurrentSession().createQuery("from Product p where p.status=1 ").list().size();
    }

    @Override
    public int getTotalBybId(Integer brandId,boolean status) {
        Query query = null;
        if (brandId != 0) {
            if(status)
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:id ");
            else
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:id and p.status=1 ");
            query.setParameter("id",brandId,Hibernate.INTEGER);
            return query.list().size();
        } else {
            if(status)
                query = sessionFactory.getCurrentSession().createQuery("from Product p ");
            else
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.status=1 ");
            return query.list().size();
        }
    }

    @Override
    public int getTotalByKeyword(String keyword,boolean status) {
        Query query = null;
        if(status)
            query = sessionFactory.getCurrentSession().createQuery("from Product p where p.name like :name or p.brand.brandName like :brandName");
        else
            query = sessionFactory.getCurrentSession().createQuery("from Product p where (p.name like :name or p.brand.brandName like :brandName) and p.status=1 ");
        query.setParameter("name","%"+keyword+"%",Hibernate.STRING);
        query.setParameter("brandName","%"+keyword+"%",Hibernate.STRING);
        return query.list().size();
    }

    @Override
    public List<Product> getProductByKeyword(String keyword,int page,int size,boolean status) {
        Query query = null;
        if(status)
            query = sessionFactory.getCurrentSession().createQuery("from Product p where p.name like :name or p.brand.brandName like :brandName order by p.updateDate desc");
        else
            query = sessionFactory.getCurrentSession().createQuery("from Product p where (p.name like :name or p.brand.brandName like :brandName) and p.status=1 order by p.updateDate desc ");
        query.setParameter("name","%"+keyword+"%",Hibernate.STRING);
        query.setParameter("brandName","%"+keyword+"%",Hibernate.STRING);
        query.setFirstResult(size * (page - 1));
        query.setMaxResults(size);
        return query.list();
    }

    @Override
    public void deleteProductColorLink(Integer productId) {
        jdbcTemplate.execute("delete from product_color_link where id="+productId);
    }

    @Override
    public int getTotalBy_bid_cId_keyword(Integer brandId,Integer categoryId, String keyword, boolean status) {
        Query query = null;
        if (status) {
            if(brandId == 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.name like :keyword or p.brand.brandName like :keyword1 ");
            }else if(brandId == 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1) ");
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and (p.name like :keyword or p.brand.brandName like :keyword1) ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1) ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }
        } else {
            if(brandId == 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.name like :keyword or p.brand.brandName like :keyword1 ");
            }else if(brandId == 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1)  and p.status=1 ");
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId == 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and (p.name like :keyword or p.brand.brandName like :keyword1)  and p.status=1 ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
            }else if(brandId != 0 && categoryId != 0){
                query = sessionFactory.getCurrentSession().createQuery("from Product p where p.brand.id=:brandId and p.category.id=:categoryId and (p.name like :keyword or p.brand.brandName like :keyword1)  and p.status=1 ");
                query.setParameter("brandId", brandId, Hibernate.INTEGER);
                query.setParameter("categoryId", categoryId, Hibernate.INTEGER);
            }
        }
        query.setParameter("keyword", "%" + keyword + "%", Hibernate.STRING);
        query.setParameter("keyword1", "%" + keyword + "%", Hibernate.STRING);
        return query.list().size();
    }
}
