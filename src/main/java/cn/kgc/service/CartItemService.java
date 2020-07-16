package cn.kgc.service;

import cn.kgc.entity.CartItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Tiler on 2020/5/15
 */
public interface CartItemService {
    public Integer addOneItem(CartItem cartItem);
    public Integer setOneItem(CartItem cartItem);
    public Integer getItemCount(Integer customerId);
    public CartItem getByPidCid(Integer productId, Integer customerId);
    public List<CartItem> getItemsByCid(Integer customerId);
    public Integer delItemById(Integer id);
}
