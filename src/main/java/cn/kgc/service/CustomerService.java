package cn.kgc.service;

import cn.kgc.entity.Customer;

/**
 * Created by Tiler on 2020/5/11
 */
public interface CustomerService {
    public Integer addOneCustomer(Customer customer);
    public Customer getByUsername(String username);
    public Integer setOneCustomer(Customer customer);
}
