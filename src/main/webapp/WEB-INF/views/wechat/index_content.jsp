<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link type="text/css" rel="stylesheet" href="${ctx}/resources/css/wechat.css" />
		<link type="text/css" href="${ctx}/resources/js/touchSlider/css/style.css" rel="stylesheet"/>
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/touchSlider/js/jquery.event.drag-1.5.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/touchSlider/js/jquery.touchSlider.js"></script>
		
		<title>首页</title>

		<style type="text/css">
			body{
				font-size: .9rem;
				font-family: "\5FAE\8F6F\96C5\9ED1",Helvetica,"黑体",Arial,Tahoma"
			}
		</style>
		
		<script type="text/javascript">
			$(document).ready(function(){
			/* 	$(".main_visual").hover(function(){
					$("#btn_prev,#btn_next").fadeIn()
				},function(){
					$("#btn_prev,#btn_next").fadeOut()
				}); */
				
				$dragBln = false;
				
				$(".main_image").touchSlider({
					flexible : true,
					speed : 200,
					btn_prev : $("#btn_prev"),
					btn_next : $("#btn_next"),
					paging : $(".flicking_con a"),
					counter : function (e){
						$(".flicking_con a").removeClass("on").eq(e.current-1).addClass("on");
					}
				});
				
				$(".main_image").bind("mousedown", function() {
					$dragBln = false;
				});
				
				$(".main_image").bind("dragstart", function() {
					$dragBln = true;
				});
				
				$(".main_image a").click(function(){
					if($dragBln) {
						return false;
					}
				});
				
				timer = setInterval(function(){
					$("#btn_next").click();
				}, 5000);
				
				$(".main_visual").hover(function(){
					clearInterval(timer);
				},function(){
					timer = setInterval(function(){
						$("#btn_next").click();
					},5000);
				});
				
				$(".main_image").bind("touchstart",function(){
					clearInterval(timer);
				}).bind("touchend", function(){
					timer = setInterval(function(){
						$("#btn_next").click();
					}, 5000);
				});
				
			});
		</script>
		
	</head>
	
	
	<body style="background-color: #F4F4F4;margin: 0px;">
		<div class="main_visual">
			<div class="flicking_con">
				<c:forEach items="${scrollPickList}" var="vo" varStatus="vst">
					<a href="#">${vst.index + 1}</a>
				</c:forEach>
			</div>
			<div class="main_image">
				<ul>
					<c:forEach items="${scrollPickList}" var="vo">
						<li><span style="background:url('${resUrl}${vo.pic}') center top no-repeat"></span></li>
					</c:forEach>
				</ul>
				<a href="javascript:;" id="btn_prev"></a>
				<a href="javascript:;" id="btn_next"></a>
			</div>
		</div>
	
		<div class='formBannerTitle' style="margin-top:5px;">
			<div class='titleLeft'></div>
			<div class='titleCenter'>
				<div class='titleText'>
					<div class='titleTextIcon icon-titleText'>&nbsp;</div>
					<div class='textContent'>产品展示</div>
				</div>
				<div class='formBannerMore'>
					<a class="titleMoreLink" href="${ctx}/wechatController/flowerList?type=2">
						<span class="titleMore">more</span>
					</a>
				</div>
			</div>
			<div class="titleRight"></div>
		</div>
		
		<div class='formMiddle'>
			<div class='middleLeft'></div>
			<div class='middleCenter'>
				<div class='formMiddleContent moduleContent'>
					<div style="background-color: #fff;" class="mProductList styleForm8">
						<c:forEach items="${flowerList}" var="vo">
							<div class="productWaterFall" style="float:left;width:47%;margin-left:2%;">
						   		<a href="${ctx}/wechatController/detail?id=${vo.id}">
							   		<div class="waterFallImg">
								   		<div style="height: 9.4667rem; background: url('${resUrl}${vo.pic}') center center / cover no-repeat;"></div>
							   		</div>
							   		
							   		<div class="paramPadding">
							   			${vo.name}/ <span style="color:red;font-weight:bold;">${vo.price}</span>
							   		</div>
						   		</a>
					   		</div>
				   		</c:forEach>
					</div>
			   </div>
			   <div class='middleRight middleRight315'></div>
	   	   </div>
	   </div>
	   
	   <c:if test="${not empty saleFlowerList}">
	   <div class='formBannerTitle' style="margin-top:5px;">
			<div class='titleLeft'></div>
			<div class='titleCenter'>
				<div class='titleText'>
					<div class='titleTextIcon icon-titleText'>&nbsp;</div>
					<div class='textContent'>热销推荐</div>
				</div>
				<div class='formBannerMore'>
					<a class="titleMoreLink" href="${ctx}/wechatController/hotSaleList">
						<span class="titleMore">more</span>
					</a>
				</div>
			</div>
			<div class="titleRight"></div>
		</div>
		
		<div class='formMiddle'>
			<div class='middleLeft'></div>
			<div class='middleCenter'>
				<div class='formMiddleContent moduleContent'>
					<div style="background-color: #fff;" class="mProductList styleForm8">
						<c:forEach items="${saleFlowerList}" var="vo">
							<div class="productWaterFall" style="float:left;width:47%;margin-left:2%;">
						   		<a href="${ctx}/wechatController/detail?id=${vo.id}">
							   		<div class="waterFallImg">
								   		<div style="height: 9.4667rem; background: url('${resUrl}${vo.pic}') center center / cover no-repeat;"></div>
							   		</div>
							   		
							   		<div class="paramPadding">
							   			${vo.name}/ 
							   			<span style="color:red;font-weight:bold;">
							   				<c:choose>
							   					<c:when test="${vo.disPrice != 0}">
							   						${vo.disPrice}
							   					</c:when>
							   					<c:otherwise>
							   						${vo.price}
							   					</c:otherwise>
							   				</c:choose>
							   			</span>
							   		</div>
						   		</a>
					   		</div>
				   		</c:forEach>
					</div>
			   </div>
			   <div class='middleRight middleRight315'></div>
	   	   </div>
	   </div>
	</c:if>
	   
		
	</body>
</html>
