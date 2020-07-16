function openLogin() {
    layer.open({
        type: 1,
        title: "用户登录",
        area: ['500px', '300px'],
        btnAlign: 'c',
        btn: ['登录', '取消'],
        yes: function(index, layero){
            userLogin(index);
        },
        btn2: function(index, layero){
            return true;
        },
        content: $("#login-layer")
    });
}

function openRegister() {
    layer.open({
        type: 1,
        title: "用户注册",
        area: ['500px', '420px'],
        btnAlign: 'c',
        btn: ['注册', '取消'],
        yes: function(index, layero){
            userRegister(index);
        },
        btn2: function(index, layero){
            return true;
        },
        content: $("#register-layer")
    });
}

function openModify() {
    layer.open({
        type: 1,
        title: "用户修改",
        area: ['500px', '320px'],
        btnAlign: 'c',
        btn: ['修改', '取消'],
        yes: function(index, layero){
            userModify(index);
        },
        btn2: function(index, layero){
            return true;
        },
        content: $("#modify-layer")
    });
}

function openPassword() {
    layer.open({
        type: 1,
        title: "密码修改",
        area: ['500px', '320px'],
        btnAlign: 'c',
        btn: ['修改', '取消'],
        yes: function(index, layero){
            userPassword(index);
        },
        btn2: function(index, layero){
            return true;
        },
        content: $("#password-layer")
    });
}

function userRegister(index) {
    $.ajax({
        type: 'post',
        url: '/customer/user_register',
        data: $("#register-form").serialize(),
        dataType: "json",
        success: function (data) {   //成功后回调
            if (data.success > 0) {
                layer.close(index);
                layer.alert("注册成功");
            }
            else if (data.success == 0) {
                layer.alert(data.message);
            }
            else {
                //窗口加高
                layer.style(index, {height: "460px"});

                $("#txt"+data.success).text(data.message);

                //隐藏或显示提示信息
                for(var i = -3; i < 0; i++) {
                    if (i != data.success) {
                        $("#msg"+i).addClass("layui-hide");
                    }
                    else {
                        $("#msg"+i).removeClass("layui-hide");
                    }
                }
            }
        },
        error: function (error) {    //失败后回调
            alert("connect error.");
        }
    });
}

function userLogin(index) {
    $.ajax({
        type: 'post',
        url: '/customer/user_login',
        data: $("#login-form").serialize(),
        dataType: "json",
        success: function (data) {   //成功后回调
            if (data.success > 0) {
                $("#login-nav").addClass("layui-hide");
                $("#user-nav").removeClass("layui-hide");
                $("#order-nav").removeClass("layui-hide");

                //使用返回的用户信息填充文本框
                $("#user-name").text(data.message.name);
                $("#cart-num").text(data.message.cartNum); //购物车数量
                $("#pwd-user-id").val(data.message.id);
                $("#set-user-id").val(data.message.id);
                $("#set-user-name").val(data.message.name);
                $("#set-user-phone").val(data.message.phone);
                $("#set-user-addr").val(data.message.address);

                layer.close(index); //关闭编号为index的弹出窗口
            }
            else {
                //显示错误信息
                $("#txt-login"+data.success).text(data.message);

                for(var i = -2; i < 0; i++) {
                    if (i != data.success) {
                        $("#msg-login"+i).addClass("layui-hide"); //添加隐藏样式
                    }
                    else {
                        $("#msg-login"+i).removeClass("layui-hide"); //移除隐藏样式
                    }
                }
            }
        },
        error: function (error) {    //失败后回调
            alert("connect error.");
        }
    });
}

function userModify(index) {
    $.ajax({
        type: 'post',
        url: '/customer/user_modify',
        data: $("#modify-form").serialize(),
        dataType: "json",
        success: function (data) {   //成功后回调
            if (data.success > 0) {
                $("#user-name").text(data.message.name);
                $("#set-user-name").val(data.message.name);
                $("#set-user-phone").val(data.message.phone);
                $("#set-user-addr").val(data.message.address);

                layer.close(index);
                layer.alert("修改成功");
            }
            else if (data.success == 0) {
                layer.alert(data.message);
            }
            else {
                //错误提示，同上
            }
        },
        error: function (error) {    //失败后回调
            alert("connect error.");
        }
    });
}

function userPassword(index) {
    $.ajax({
        type: 'post',
        url: '/customer/user_password',
        data: $("#password-form").serialize(),
        dataType: "json",
        success: function (data) {   //成功后回调
            if (data.success > 0) {
                layer.close(index);
                layer.alert("修改成功");
            }
            else if (data.success == 0) {
                layer.alert(data.message);
            }
            else {
                //错误提示，同上
            }
        },
        error: function (error) {    //失败后回调
            alert("connect error.");
        }
    });
}

function addToCart(pid) {
    $.ajax({
        type: 'post',
        url: '/cart/add_item?product.id=' + pid,
        dataType: "json",
        success: function (data) {   //成功后回调
            if (data.success) {
                layer.alert("商品加入购物车成功");
                //商品数量增加
                if (data.message != null) {
                    $("#cart-num").text(data.message);
                }
            }
            else  {
                layer.alert(data.message);
            }
        },
        error: function (error) {    //失败后回调
            alert("connect error.");
        }
    });
}