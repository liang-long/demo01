package cn.kgc.controller;

import cn.kgc.entity.CartItem;
import cn.kgc.entity.Customer;
import cn.kgc.service.CartItemService;
import cn.kgc.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Tiler on 2020/5/20
 */
@Controller
@RequestMapping("/order")
public class OrderItemController {
    @Autowired
    private OrderService orderService;

    @Autowired
    private CartItemService cartItemService;

    @RequestMapping("add_order")
    public String addOneOrder(HttpSession session) {
        Customer user = (Customer) session.getAttribute("user");

        //取出购物车中所有商品
        List<CartItem> list = cartItemService.getItemsByCid(user.getId());

        orderService.addOneOrder(list, user);

        return "all_orders";
    }
}
