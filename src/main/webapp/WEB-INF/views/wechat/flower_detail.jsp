<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link type="text/css" rel="stylesheet" href="${ctx}/resources/css/wechat.css" />
		
		<title>${facadeBean.name}</title>
	</head>
	
	
	<body style="margin: 0px;">
		<div style="position:relative;">
			<img src="${resUrl}${facadeBean.pic}" style="width:100%;height:200px;">	
			<div class="newsInfoTitle">
				${facadeBean.name} - ${facadeBean.language}
			</div>
		</div>
		
		<div style="margin-left:10px;">
			<span style="color:#f92965;line-height:2.75rem;height:3.75rem;font-size:1.1rem;font-weight:bold;<c:if test="${facadeBean.disPrice != 0}">text-decoration:line-through;color:#666;</c:if>">￥${facadeBean.price}</span>
		   	<c:if test="${facadeBean.disPrice != 0}"><span style="color:#f92965;font-weight:bold;font-size:1.1rem;"> / ￥${facadeBean.disPrice}</span></c:if>
		</div>
		
		<c:if test="${not empty facadeBean.discount}">
			<div style="margin-left:10px;color:#f92965;font-weight:bold;font-size:1.1rem;">
				${facadeBean.discount}
			</div>
		</c:if>
		
		<div class="titleCenter" style="margin-top:10px;">
    		<div class="titleIcon">&nbsp;</div>
    		<div class="titleContent">简介</div>
    	</div>
    	
    	<div class="descrition">
    		${facadeBean.descrition}
    	</div>
		
	</body>	
</html>
