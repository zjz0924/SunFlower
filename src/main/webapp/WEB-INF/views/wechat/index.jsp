<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
		<title>Sun Flower</title>

		<link type="text/css" rel="stylesheet" href="${ctx}/resources/js/mmenu/css/mmenu.css" />
		<link type="text/css" rel="stylesheet" href="${ctx}/resources/js/mmenu/css/jquery.mmenu.all.css" />
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/mmenu/js/jquery.mmenu.all.min.js"></script>
		<script type="text/javascript">
			$(function() {
				$('nav#menu').mmenu({
					navbar: {
						title: "Sun Flower",
						titleLink: "none"
					}
				});
				
				$("nav ul li:first a").trigger("click");
				
				$("#modular").load(function() {
					$(this).height(0); //用于每次刷新时控制IFRAME高度初始化 
					var height = $(this).contents().height();
					$(this).height(height < 400 ? 400 : height);
				});
			});
			
			function openFrame(src) {
				var frame = document.getElementById("modular");
				frame.src = "${ctx}/" + src;
			}
		</script>
		
		<style type="text/css">
			body{
				overflow-x: hidden;
				overflow-y: hidden;
				font-family: "\5FAE\8F6F\96C5\9ED1",Helvetica,"黑体",Arial,Tahoma;
				height: 100%;
			}
		</style>
	</head>
	<body>
		<div id="page">
			<div class="header">
				<a href="#menu"><span></span></a>
				Sun Flower
			</div>
			
			<!-- 菜单 -->
			<nav id="menu">
				<ul>
					<li><a href="#indexContent" onclick="openFrame('wechatController/indexContent')">首页</a></li>
					<li><a href="#productList" onclick="openFrame('wechatController/flowerList')">产品展示</a></li>
					<li><a href="#hotsale" onclick="openFrame('wechatController/hotSaleList')">热销推荐</a></li>
					<li><a href="#messageBoard" onclick="openFrame('wechatController/messageBoard')">留言板</a></li>
					<li><a href="#contact" onclick="openFrame('wechatController/contant')">联系方式</a></li>
				</ul>
			</nav>
			<!-- 菜单 -->
			
			<!-- 内容 -->
			<div class="content">
				<iframe id='modular' frameborder='0' width='100%' height='500px' scrolling='hidden'></iframe>
			</div>
		</div>
	</body>
</html>