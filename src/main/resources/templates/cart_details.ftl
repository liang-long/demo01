<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>MyShop</title>
	<link rel="stylesheet" href="/layui/css/layui.css">
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">MyShop</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="/product/">商城首页</a></li>
				<li class="layui-nav-item"><a href="">订单管理</a></li>
			</ul>
			<#--登录后-->
            <ul id="user-nav" class='layui-nav layui-layout-right'>
                <li class="layui-nav-item layui-this">
                    <a href="">购物车<span id="cart-num" class="layui-badge"><#if user??>${user.cartNum}</#if></span></a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:void(0);">
                        <img src="/images/ico-01.jpg" class="layui-nav-img">
                        <span id="user-name"><#if user??>${user.name}</#if></span>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:void(0)" onclick="openModify()">基本资料</a></dd>
                        <dd><a href="javascript:void(0)" onclick="openPassword()">安全设置</a></dd>
                    </dl>
                </li>
            </ul>
		</div>
		
		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree"  lay-filter="test">
					<li class="layui-nav-item layui-this" style="text-align:center"><a href="">购物车</a></li>
					<li class="layui-nav-item" style="text-align:center"><a href="">收藏夹</a></li>
				</ul>
			</div>
		</div>
  
		<!-- 内容主体区域 -->
		<div class="layui-body">
			<div class="layui-container">  
				<table class="layui-table">
					<colgroup>
						<col>
						<col>
						<col>
						<col width="100">
						<col>
						<col>
					</colgroup>
					<thead>
						<tr>
						  <th>编号</th>
						  <th>名称</th>
						  <th>价格</th>
						  <th>数量</th>
						  <th>总价</th>
						  <th>操作</th>
						</tr> 
					</thead>
					<tbody>
						<#list items as t>
							<tr id="item-${t.id}">
                                <td>${t.id}</td>
                                <td>${t.product.name}</td>
                                <td id="price-${t.id}">${t.product.price?string("###.00")}</td>
                                <td>
                                    <input type="text" id="number-${t.id}" value="${t.number}" lay-verify="required|number"
										   onchange="setNumber(${t.id});" class="layui-input" style="height:30px;"/>
                                </td>
                                <td id="total-${t.id}">${(t.product.price * t.number)?string("###.00")}</td>
                                <td>
                                    <button type="button" onclick="delItem(${t.id})" class="layui-btn layui-btn-primary
                                    layui-btn-sm">删除</button>
                                </td>
                            </tr>
						</#list>
						<tr>
						  <td colspan="4" align="center">总　计</td>
						  <td id="total">${total?string("###.00")}</td>
						  <td>
						    <button type="button" onclick="location.href='/order/add_order'" class="layui-btn
						        layui-btn-primary layui-btn-sm">结算</button>
						  </td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- 底部固定区域 -->
		<div class="layui-footer" style="text-align:center">
			©www.jwkt.net 版权所有
		</div>

        <!-- 修改表单 -->
        <div id="modify-layer" style="display: none">
            <form id="modify-form" class="layui-form" style="padding:45px 20px 5px 20px">
                <input type="hidden" id="set-user-id" name="id" value="<#if user??>${user.id!}</#if>"/>
                <div class="layui-form-item">
                    <label class="layui-form-label">姓　名</label>
                    <div class="layui-input-block">
                        <input type="text" id="set-user-name" name="name" value="<#if user??>${user.name!}</#if>" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg-32" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">手　机</label>
                    <div class="layui-input-block">
                        <input type="text" id="set-user-phone" name="phone" value="<#if user??>${user.phone!}</#if>" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg-33" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">地　址</label>
                    <div class="layui-input-block">
                        <input type="text" name="address" id="set-user-addr" value="<#if user??>${user.address!}</#if>" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg-34" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
            </form>
        </div>

        <!-- 修改密码 -->
        <div id="password-layer" style="display: none">
            <form id="password-form" class="layui-form" style="padding:45px 20px 5px 20px">
                <input type="hidden" id="pwd-user-id" name="id" value="<#if user??>${user.id!}</#if>"/>
                <div class="layui-form-item">
                    <label class="layui-form-label">原密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="oldPwd" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">新密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="newPwd" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">重复密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="repeat" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
            </form>
        </div>
	</div>
	
	<script src="/layui/js/jquery.min.js"></script>
	<script src="/layui/layui.js"></script>
    <script src="/js/customer.js"></script>
	<script>
	//JavaScript代码区域
	layui.use(['element', 'form', 'layer'], function(){
		var element = layui.element,
			layer = layui.layer,
			form = layui.form;
	});

    //重新计算所有商品总价
	function getTotal() {
        var sum = 0;

        //选择id以'total-'打头的所有元素
        $("[id^='total-']").each(function(index){
            sum += parseFloat($(this).text());
        });

        $("#total").text(sum.toFixed(2));
    }

	function setNumber(id) {
	    //取商品的数量
	    var num = $("#number-"+id).val();

        $.ajax({
            type: 'post',
            url: '/cart/set_number?id='+id+"&number="+num,
            dataType: "json",
            success: function (data) {   //成功后回调
                if (data.success) {
                    var total = $("#number-"+id).val() * $("#price-"+id).text();
                    $("#total-" + id).text(total.toFixed(2));

                    getTotal();
                }
                else {
                    layer.alert(data.message);
                }
            },
            error: function (error) {    //失败后回调
                alert("connect error.");
            }
        });
	}

	function delItem(id) {
        $.ajax({
            type: 'post',
            url: '/cart/del_item?id='+id,
            dataType: "json",
            success: function (data) {   //成功后回调
                if (data.success) {
                    //删除表格中的一行
                    $("#item-"+id).remove();

                    getTotal(); //重新计算总价

                    //更新购物车商品数量
                    var num = $("#cart-num").text();
                    $("#cart-num").text(parseInt(num)-1);
                }
                else {
                    layer.alert(data.message);
                }
            },
            error: function (error) {    //失败后回调
                alert("connect error.");
            }
        });
    }

	</script>
</body>
</html>