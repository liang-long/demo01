package cn.kgc.mapper;

import cn.kgc.entity.Order;
import org.apache.ibatis.annotations.Mapper;

/**
 * Created by Tiler on 2020/5/20
 */
@Mapper
public interface OrderMapper {
    public Integer insertOneOrder(Order order);
}
