package cn.kgc.mapper;

import cn.kgc.entity.Customer;
import org.apache.ibatis.annotations.Mapper;

/**
 * Created by Tiler on 2020/5/11
 */
@Mapper
public interface CustomerMapper {
    public Integer insertOneCustomer(Customer customer);
    public Customer selectByUsername(String username);
    public Integer updateOneCustomer(Customer customer);
}
