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
				<li class="layui-nav-item layui-this"><a href="">商城首页</a></li>
                <li id="order-nav" class="layui-nav-item layui-hide"><a href="">订单管理</a></li>
			</ul>
			<#--登录前-->
			<#if !user??>
				<ul id="login-nav" class="layui-nav layui-layout-right">
                    <li class="layui-nav-item">
                        <a href="javascript:void(0);" onclick="openLogin()">
                            <i class="layui-icon layui-icon-username"></i> 登录
                        </a>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:void(0);" onclick="openRegister()">
                            <i class="layui-icon layui-icon-auz"></i> 注册
                        </a>
                    </li>
                </ul>
			</#if>

			<#--登录后-->
			<ul id="user-nav" class='layui-nav layui-layout-right ${user???string("", "layui-hide")}'>
				<li class="layui-nav-item">
					<a href="/cart/">购物车<span id="cart-num" class="layui-badge"><#if user??>${user.cartNum}</#if></span></a>
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
					<#list categories as c>
						<#if c.id == categoryId>
							<li class="layui-nav-item layui-this" style="text-align:center">
								<a href="?categoryId=${c.id}">${c.name}</a>
							</li>
						<#else>
							<li class="layui-nav-item" style="text-align:center">
								<a href="?categoryId=${c.id}">${c.name}</a>
							</li>
						</#if>
					</#list>
				</ul>
			</div>
		</div>
  
		<!-- 内容主体区域 -->
		<div class="layui-body">
			<form action="?categoryId=${categoryId}" method="get" class="layui-form" style="padding:20px 20px 5px 35px">
				<div class="layui-inline">
					<label class="layui-input-label">商品名称：</label>
					<div class="layui-input-inline" style="width: 150px;">
						<input type="text" name="productName" value="${productName!}" style="height:30px" autocomplete="off" class="layui-input">
					</div>
				</div>
			
				<div class="layui-inline" style="padding-left:20px">
					<label class="layui-input-label">价格范围：</label>
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="priceMin" value="${priceMin!}" style="height:30px" placeholder="￥" autocomplete="off" class="layui-input">
					</div>
					&nbsp;-&nbsp;
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="priceMax" value="${priceMax!}" style="height:30px" placeholder="￥" autocomplete="off" class="layui-input">
					</div>
				</div>
				
				<div class="layui-inline" style="padding-left:20px">
					<button class="layui-btn layui-btn-radius layui-btn-primary layui-btn-sm" lay-submit>
						<i class="layui-icon layui-icon-search"></i>搜索商品
					</button>
				</div>
			</form>
	
			<hr>

			<div align="center">
			<#list productPage.productsList as p>
				<#if (p_index % 4) == 0>
					<div class="layui-row layui-col-space1" style="padding-top:20px">
				</#if>

				<div class="layui-col-md3">
					<img src="/images/${p.image}" style="width:200px;height:200px">
					<div style="padding:10px 20px 5px 35px" align="left">
						<p>${p.name}</p>
						<p>价格：<span style="color:red">￥${p.price}</span></p>
					</div>
					<button type="button" onclick="addToCart(${p.id})" class="layui-btn layui-btn-radius layui-btn-sm
					    layui-btn-primary"><i class="layui-icon layui-icon-cart-simple"></i>加入购物车
					</button>
				</div>

				<#if (p_index + 1) % 4 == 0>
					</div>
				</#if>
			</#list>
			</div>

			<#--分页插件由js加载-->
			<div id="pagination" align="center" style="padding:20px 0px 20px 0px"></div>
		</div>
		
		<!-- 底部固定区域 -->
		<div class="layui-footer" style="text-align:center">
			©www.jwkt.net 版权所有
		</div>
		
		<!-- 登录表单，隐藏时不要使用layui-hide -->
		<div id="login-layer" style="display: none">
			<form id="login-form" class="layui-form" style="padding:50px 20px 5px 35px">
				<div class="layui-form-item">
					<label class="layui-form-label">登录名</label>
					<div class="layui-input-block">
						<input type="text" name="username" class="layui-input" style="width:80%">
					</div>
					<div id="msg-login-1" class="layui-hide">
						<label class="layui-form-label" style="color:red">错　误</label>
						<div id="txt-login-1" class="layui-form-mid layui-word-aux">辅助文字</div>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">密　码</label>
					<div class="layui-input-block">
						<input type="password" name="password" class="layui-input" style="width:80%">
					</div>
					<div id="msg-login-2" class="layui-hide">
						<label class="layui-form-label" style="color:red">错　误</label>
						<div id="txt-login-2" class="layui-form-mid layui-word-aux">辅助文字</div>
					</div>
				</div>
			</form>
		</div>

        <!-- 注册表单 -->
        <div id="register-layer" style="display: none">
            <form id="register-form" class="layui-form" style="padding:45px 20px 5px 20px">
                <div class="layui-form-item">
                    <label class="layui-form-label">登录名</label>
                    <div class="layui-input-block">
                        <input type="text" name="username" class="layui-input" id="username" style="width:80%">
                    </div>
                    <div id="msg-1" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div id="txt-1" class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">密　码</label>
                    <div class="layui-input-block">
                        <input type="text" name="password" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg-2" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div id="txt-2" class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">姓　名</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" class="layui-input" style="width:80%">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">手　机</label>
                    <div class="layui-input-block">
                        <input type="text" name="phone" class="layui-input" style="width:80%">
                    </div>
                    <div id="msg-3" class="layui-hide">
                        <label class="layui-form-label" style="color:red">错　误</label>
                        <div id="txt-3" class="layui-form-mid layui-word-aux">辅助文字</div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">地　址</label>
                    <div class="layui-input-block">
                        <input type="text" name="address" class="layui-input" style="width:80%">
                    </div>
                </div>
            </form>
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
	layui.use(['element', 'form', 'laypage', 'layer'], function(){
		var element = layui.element,
			laypage = layui.laypage,
			form = layui.form,
			layer = layui.layer;

		//加载分页符
		laypage.render({
			elem: 'pagination', //分页符所在位置
			count: ${productPage.rowCount}, //记录总数
			limit: 12, //页面大小
			curr: ${productPage.pageNum},    //当前页
            jump: function(obj, first){
                //得到了当前页，用于向服务端请求对应数据
				if (!first) { //首次打开页面时为不执行此函数
                    var url = "?categoryId=${categoryId}&pageNum=" + obj.curr;
                    /*priceMin != null*/
                    <#if priceMin??>
						url += "&priceMin=" + ${priceMin};
                    </#if>
					<#if priceMax??>
						url += "&priceMax=" + ${priceMax};
					</#if>
					<#if productName??>
						url += "&productName=" + ${productName};
					</#if>

                    location.href = url;
				}
            }
		});
	});
	</script>
</body>

</html>