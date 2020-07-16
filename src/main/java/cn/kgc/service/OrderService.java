package cn.kgc.service;

import cn.kgc.entity.CartItem;
import cn.kgc.entity.Customer;
import cn.kgc.entity.Order;

import java.util.List;

/**
 * Created by Tiler on 2020/5/20
 */
public interface OrderService {
    public Integer addOneOrder(List<CartItem> items, Customer user);
}
