package cn.kgc.mapper;

import cn.kgc.entity.CartItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Tiler on 2020/5/15
 */
@Mapper
public interface CartItemMapper {
    public Integer insertOneItem(CartItem cartItem);
    public Integer updateOneItem(CartItem cartItem);
    public CartItem selectByPidCid(@Param("productId") Integer productId,
                                   @Param("customerId") Integer customerId);
    public Integer selectItemCount(Integer customerId);
    public List<CartItem> selectItemsByCid(Integer customerId);
    public Integer deleteItemById(Integer id);
}
