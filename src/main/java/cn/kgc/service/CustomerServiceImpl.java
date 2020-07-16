package cn.kgc.service;

import cn.kgc.entity.Customer;
import cn.kgc.mapper.CustomerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Tiler on 2020/5/11
 */
@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public Integer addOneCustomer(Customer customer) {
        return customerMapper.insertOneCustomer(customer);
    }

    @Override
    public Customer getByUsername(String username) {
        return customerMapper.selectByUsername(username);
    }

    @Override
    public Integer setOneCustomer(Customer customer) {
        return customerMapper.updateOneCustomer(customer);
    }
}
