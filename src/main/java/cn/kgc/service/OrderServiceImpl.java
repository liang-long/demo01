package cn.kgc.service;

import cn.kgc.entity.*;
import cn.kgc.mapper.OrderItemMapper;
import cn.kgc.mapper.OrderMapper;
import cn.kgc.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by Tiler on 2020/5/20
 */
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Autowired
    private ProductMapper productMapper;

    //将购物车内的商品转存至订单详情表中
    @Override
    public Integer addOneOrder(List<CartItem> items, Customer user) {
        List<OrderItem> list = new ArrayList<>();

        Float totalPrice = 0f;

        for (CartItem item : items) {
            Integer pid = item.getProduct().getId();

            //取商品的最新价格
            Product product = productMapper.selectProductById(pid);

            Float price = item.getNumber() * product.getPrice();
            totalPrice += price; //计算订单总价

            //生成订单详情
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(product);
            orderItem.setNumber(item.getNumber());
            orderItem.setPrice(price);

            //加入列表中
            list.add(orderItem);
        }

        //生成订单
        String uuid = UUID.randomUUID().toString().replace("-", "");

        Order order = new Order();
        order.setOrderNumber(uuid);
        order.setCustomer(user);
        order.setTotalPrice(totalPrice);

        //加入订单并获取订单id
        orderMapper.insertOneOrder(order);
        Integer orderId = order.getId();

        //为OrderItem赋订单编号值
        for (OrderItem item : list) {
            item.setOrderId(orderId);
        }

        //加入订单详情表中
        return orderItemMapper.insertAllItems(list);
    }
}
