package cn.kgc.controller;

import cn.kgc.entity.Customer;
import cn.kgc.service.CartItemService;
import cn.kgc.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Tiler on 2020/5/11
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    @Autowired
    private CartItemService cartItemService;

    @RequestMapping("user_register")
    @ResponseBody
    public Map<String, Object> addOneCustomer(Customer customer) {
        Map<String, Object> result = new HashMap<>();

        //判断登录名
        String value = customer.getUsername();

        if (value == null || value.equals("")) {
            result.put("success", -1);
            result.put("message", "登录名不能为空");

            return result;
        }

        //判断密码
        value = customer.getPassword();

        if (value == null || value.length() < 6) {
            result.put("success", -2);
            result.put("message", "密码至少六位");

            return result;
        }

        //判断密码
        value = customer.getPhone();

        if (value == null || !value.startsWith("1") || value.length() != 11) {
            result.put("success", -3);
            result.put("message", "用户手机号格式有误");

            return result;
        }

        //判断登录名是否重复，读取数据库的判断放在所有判断最后
        if (customerService.getByUsername(customer.getUsername()) != null) {
            result.put("success", -1);
            result.put("message", "登录名称重复");

            return result;
        }

        //插入数据
        if (customerService.addOneCustomer(customer) > 0) {
            result.put("success", 1);
        }
        else {
            result.put("success", 0);
            result.put("message", "数据库写入失败");
        }

        return result;
    }

    @RequestMapping("user_login")
    @ResponseBody
    public Map<String, Object> getByUsername(String username, String password, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        if (username == null || username.equals("")) {
            result.put("success", -1);
            result.put("message", "登录名不能为空");
        }
        else if (password == null || password.equals("")) {
            result.put("success", -2);
            result.put("message", "密码不能为空");
        }
        else {
            Customer customer = customerService.getByUsername(username);
            if (customer == null) {
                result.put("success", -1);
                result.put("message", "登录名不存在");
            }
            else if (!customer.getPassword().equals(password)) {
                result.put("success", -2);
                result.put("message", "登录密码错误");
            }
            else {
                result.put("success", 1);
                result.put("message", customer); //返回用户信息

                session.setAttribute("user", customer);
            }
        }

        return result;
    }

    @RequestMapping("user_modify")
    @ResponseBody
    public Map<String, Object> setOneCustomer(Customer customer, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        //提交信息的判断同上，省略...

        //更新session中的user
        Customer user = (Customer) session.getAttribute("user");
        user.setName(customer.getName());
        user.setPhone(customer.getPhone());
        user.setAddress(customer.getAddress());

        if (customerService.setOneCustomer(customer) > 0) {
            result.put("success", 1);
            result.put("message", customer);
        }
        else {
            result.put("success", 0);
            result.put("message", "数据库读写失败");
        }

        return result;
    }

    @RequestMapping("user_password")
    @ResponseBody
    public Map<String, Object> setOnePassword(Integer id, String oldPwd, String repeat, String newPwd, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        //提交信息的判断同上，省略...
        //1:判断旧密码是否和现密码相同,2:判断重复密码是否和新密码相同,3:新密码是否六位以上

        //更新session用户的密码
        Customer user = (Customer) session.getAttribute("user");
        user.setPassword(newPwd);

        //新建用户用于修改
        Customer customer = new Customer();
        customer.setId(id);
        customer.setPassword(newPwd);

        if (customerService.setOneCustomer(customer) > 0) {
            result.put("success", 1);
        }
        else {
            result.put("success", 0);
            result.put("message", "数据库读写失败");
        }

        return result;
    }
}
