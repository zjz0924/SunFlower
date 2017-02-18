<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>首页</title>
		
		<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/resources/css/styles.css" rel="stylesheet">
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
		
		<!--[if lt IE 9]>
		<script src="js/html5shiv.js"></script>
		<script src="js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
			ul.nav li.parent{
				border-bottom:1px solid #1f262d;
				border-top:1px solid #37414b;
			} 
		</style>
		
		<script>
			$(function(){
				$("ul[class='nav menu'] li[class='parent']").click(function(){
					var index = $(this).find("ul").attr("class").indexOf("in");
					
					$("ul[class='children collapsed collapse in']").attr("class", "children collapse");
					$("a span em").attr("class", "glyphicon glyphicon-chevron-up");
					
					if(index != -1){
						$(this).find("ul").attr("class", "children collapse");
						$(this).find("a span em").attr("class", "glyphicon glyphicon-chevron-up");
			        }else{
			        	$(this).find("ul").attr("class", "children collapsed collapse in");
			        	$(this).find("a span em").attr("class", "glyphicon glyphicon-chevron-down");
			        }
				});
				
				$("li[class='parent']").click(function(){
					$("ul[class='nav menu'] li").removeClass("active");
					$(this).addClass("active");
				});
				
				// 点击事件
				$("li[class='sub']").click(function(){
					$("ul[class='nav menu'] li").removeClass("active");
					$(this).addClass("active");
					
					if (event != null && event.stopPropagation) {
						event.stopPropagation();
					} else if (window.event) {
						window.event.cancelBubble = true;
					}
					
					// 清空提示数量
					if(!isNull($(this).attr("type"))){
						$("#" + $(this).attr("type")).html("");
					}
				});

				$("#modular").load(function() {
					$(this).height(0); //用于每次刷新时控制IFRAME高度初始化 
					var height = $(this).contents().height() + 10;
					$(this).height(height < 650 ? 650 : height);
				});

				if (isNull($("ul[class='nav menu'] li:first").attr("class"))) {
					$("ul[class='nav menu'] li:first a").trigger("click");
				} else {
					$("ul[class='nav menu'] li:first ul li:first a").trigger("click");
					$("ul[class='nav menu'] li").removeClass("active");
					$("ul[class='nav menu'] li:first ul li:first").addClass("active");

					//防止js冒泡
					if (event.stopPropagation) {
						event.stopPropagation();
					} else if (window.event) {
						window.event.cancelBubble = true;
					}
				}
			});

			function openFrame(src) {
				var frame = document.getElementById("modular");
				frame.src = "${ctx}/" + src;
			}

			function errorTip(content, time) {
				if (time == null || time == "" || time == undefined) {
					time = 2;
				}
				art.dialog.tips(content, time, "error");
			}

			function successTip(content, time) {
				if (time == null || time == "" || time == undefined) {
					time = 2;
				}
				art.dialog.tips(content, time, "succeed");
			}

			function adapter(height) {
				$("#modular").height(height < 650 ? 650 : height);
			}

			function scrollToTop() {
				document.body.scrollTop = 0; //转到页面顶部
			}
		</script>	
	</head>

	<body>
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="javascript:void(0)"><span id="merchantName" style="color:#ff8000">Sun Flower</span></a>
					<ul class="user-menu">
						<li class="dropdown pull-right">
							<a href="javascript:void(0)" onclick="openFrame('merchantController/accountManager')">
								<span class="glyphicon glyphicon-user" style="color:#fff;" id="userName">${currentUser.userName}</span>
							</a>&nbsp;&nbsp;&nbsp;
							<a href="${ctx}/backend/loginout"><span class="glyphicon glyphicon-log-out"></span>&nbsp;退出</a>
						</li>
					</ul>
				</div>
			</div><!-- /.container-fluid -->
		</nav>
			
		<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar" style="background-color:#37414b">
			<ul class="nav menu">
				<li class="parent">
					<a href="javascript:void(0)">
						<span class="glyphicon glyphicon-list-alt"></span> 信息管理
						<span data-toggle="collapse" class="icon pull-right"><em class="glyphicon glyphicon-chevron-down"></em></span> 
					</a>
					
					<ul class="children collapsed" id="sub-item-1" style="background-color:black;">
						<li class="sub">
							<a style="background-color:#1e242b" href="javascript:void(0)" onclick="openFrame('flowerController/list');"><span class="glyphicon glyphicon-list-alt"></span>商品管理</a>
						</li>
						<li class="sub">
							<a style="background-color:#1e242b;" href="javascript:void(0)" onclick="openFrame('scrollPicController/list');"><span class="glyphicon glyphicon-picture"></span>滚动大图</a>
						</li>
						<li class="sub">
							<a style="background-color:#1e242b;" href="javascript:void(0)" onclick="openFrame('contactController/detail');"><span class="glyphicon glyphicon-user"></span>联系方式</a>
						</li>
					</ul>
				</li>
				
				<li class="parent">
					<a href="javascript:void(0)">
						<span class="glyphicon glyphicon-list-alt"></span> 经营管理
						<span data-toggle="collapse" class="icon pull-right"><em class="glyphicon glyphicon-chevron-down"></em></span> 
					</a>
					
					<ul class="children collapsed" id="sub-item-1" style="background-color:black;">
						<li class="sub">
							<a style="background-color:#1e242b;" href="javascript:void(0)" onclick="openFrame('messageBoardController/list');"><span class="glyphicon glyphicon-edit"></span>留言板</a>
						</li>
						<li class="sub">
							<a style="background-color:#1e242b;" href="javascript:void(0)" onclick="openFrame('orderController/list');"><span class="glyphicon glyphicon-shopping-cart"></span>订单管理</a>
						</li>
						<li class="sub">
							<a style="background-color:#1e242b;" href="javascript:void(0)" onclick="openFrame('payController/list');"><span class="glyphicon glyphicon-edit"></span>支出管理</a>
						</li>
						<li class="sub">
							<a style="background-color:#1e242b;" href="javascript:void(0)" onclick="openFrame('statisticController/businessAnalysis');"><span class="glyphicon glyphicon-signal"></span>经营分析</a>
						</li>
					</ul>
				</li>
			</ul>
		</div><!--/.sidebar-->
			
			
		<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">			
			<iframe id="modular" name="modular" width="98.5%" frameborder=0 height="100%" src="" 
                marginheight="0" marginwidth="0"  scrolling="no"  style="margin-top:-59px;margin-left:5px;">
		</div><!--/.main-->
	</body>

</html>
