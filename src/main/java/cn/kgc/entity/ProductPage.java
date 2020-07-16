package cn.kgc.entity;

import java.util.List;

/**
 * Created by Tiler on 2020/5/6
 */
public class ProductPage {
    private Integer rowCount;  //记录总数
    private Integer pageCount; //总页数
    private Integer pageNum;   //当前页
    private List<Product> productsList; //商品列表

    public Integer getRowCount() {
        return rowCount;
    }

    public void setRowCount(Integer rowCount) {
        this.rowCount = rowCount;
    }

    public Integer getPageCount() {
        return pageCount;
    }

    public void setPageCount(Integer pageCount) {
        this.pageCount = pageCount;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public List<Product> getProductsList() {
        return productsList;
    }

    public void setProductsList(List<Product> productsList) {
        this.productsList = productsList;
    }
}
