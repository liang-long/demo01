package cn.kgc.entity;

import java.util.Date;

/**
 * Created by Tiler on 2020/5/11
 */
public class Customer {
    private Integer id;
    private String name;
    private String username;
    private String password;
    private String phone;
    private String address;
    private Date registerDate;
    private Integer cartNum;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public Integer getCartNum() {
        return cartNum;
    }

    public void setCartNum(Integer cartItemNum) {
        this.cartNum = cartItemNum;
    }
}
