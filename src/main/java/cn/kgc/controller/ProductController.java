package cn.kgc.controller;

import cn.kgc.entity.Category;
import cn.kgc.entity.Customer;
import cn.kgc.entity.Product;
import cn.kgc.entity.ProductPage;
import cn.kgc.service.CartItemService;
import cn.kgc.service.CategoryService;
import cn.kgc.service.ProductService;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Tiler on 2020/5/6
 */
@Controller
@RequestMapping("/product")
public class ProductController {
    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CartItemService cartItemService;

    @Value("${product.page.size}")
    private Integer defaultSize;

    private String getStrParam(String param) {
        if (param == null || param.trim().equals("")) {
            return null;
        }
        else {
            return param.trim();
        }
    }

    @RequestMapping("/")
    public String getAllProducts(@RequestParam Map<String, String> params, Model model, HttpSession session) {
        //获取参数并去掉字符串前后空格
        String productName = getStrParam(params.get("productName"));
        String strCategory = getStrParam(params.get("categoryId"));
        String strPriceMax = getStrParam(params.get("priceMax"));
        String strPriceMin = getStrParam(params.get("priceMin"));
        String strPageSize = getStrParam(params.get("pageSize"));
        String strPageNum = getStrParam(params.get("pageNum"));

        //类型转换
        Integer categoryId = strCategory == null? 1 : Integer.parseInt(strCategory);
        Integer priceMax = strPriceMax == null? null : Integer.parseInt(strPriceMax);
        Integer priceMin = strPriceMin == null? null : Integer.parseInt(strPriceMin);
        Integer pageSize = strPageSize == null? defaultSize : Integer.parseInt(strPageSize);
        Integer pageNum = strPageNum == null? 1 : Integer.parseInt(strPageNum);
        Integer cartNum = null;

        //查询参数
        Map<String, Object> map = new HashMap<>();
        map.put("categoryId", categoryId);
        map.put("productName", productName);
        map.put("priceMax", priceMax);
        map.put("priceMin", priceMin);
        map.put("pageSize", pageSize);
        map.put("pageNum", pageNum);

        //查询
        List<Category> categories = categoryService.getAllCategories();
        ProductPage productPage = productService.getAllProducts(map);

        //查询用户购物车内商品总数
        Customer user = (Customer) session.getAttribute("user");
        if (user != null) {
            cartNum = cartItemService.getItemCount(user.getId());
        }

        model.addAttribute("categories", categories);
        model.addAttribute("productPage", productPage);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("productName", productName);
        model.addAttribute("priceMin", priceMin);
        model.addAttribute("priceMax", priceMax);
        model.addAttribute("cartItemNum", cartNum);

        return "all_products";
    }
}
