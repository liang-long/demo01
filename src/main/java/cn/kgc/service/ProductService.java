package cn.kgc.service;

import cn.kgc.entity.Product;
import cn.kgc.entity.ProductPage;

import java.util.List;
import java.util.Map;

/**
 * Created by Tiler on 2020/5/6
 */
public interface ProductService {
    public ProductPage getAllProducts(Map<String, Object> map);
}
