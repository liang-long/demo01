package cn.kgc.mapper;

import cn.kgc.entity.Product;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * Created by Tiler on 2020/5/6
 */
@Mapper
public interface ProductMapper {
    //通过map传递参数，使用键名进行值的引用
    public List<Product> selectAllProducts(Map<String, Object> map);
    public Product selectProductById(Integer productId);
}
