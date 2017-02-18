<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link type="text/css" rel="stylesheet" href="${ctx}/resources/css/wechat.css" />
		
		<title>联系方式</title>

		<style type="text/css">
			body{
				font-size: .9rem;
			}
			
			.rowDiv{
				margin-left:.5rem;
				margin-top: .5rem;
			}
			
			.titleSpan{
				display: inline-block;
				width: 25%;
			}
			
		</style>
	</head>
	
	
	<body style="background-color: #F4F4F4;margin: 0px;">
		<div style="padding:.5rem 0rem;background-color:white;width:100%;align:center;">
			<img src="${ctx}/resources/img/contact.png" style="width:100%;"/>
		</div>
		
	    <div style="background-color:white;margin-top:5px;padding-bottom:10px;">
	    	<div class="titleCenter">
	    		<div class="titleIcon">&nbsp;</div>
	    		<div class="titleContent">联系方式</div>
	    	</div>

	    	<c:if test="${not empty contact.name}">
				<div class="rowDiv" style="display:none;">
					<span class="titleSpan">联  系  人：</span>
					<span class="contentSpan">${contact.name}</span>
				</div>
			</c:if>
	    	
	    	<c:if test="${not empty contact.phone}">
				<div class="rowDiv">
					<span class="titleSpan">手机号码：</span>
					<span class="contentSpan">${contact.phone}</span>
				</div>
			</c:if>
			
			<c:if test="${not empty contact.wechat}">
				<div class="rowDiv">
					<span class="titleSpan">微&nbsp;&nbsp;信：</span>
					<span class="contentSpan">${contact.wechat}</span>
				</div>
			</c:if>
			
			<c:if test="${not empty contact.qr}">
				<div class="rowDiv">
					<span class="titleSpan">二  维  码：</span>
					<img src="${resUrl}${contact.qr}" style="width:80px;height:80px;vertical-align:middle;"></img>
				</div>
			</c:if>
			
			<c:if test="${not empty contact.qq}">
				<div class="rowDiv">
					<span class="titleSpan">Q&nbsp;&nbsp;&nbsp;Q：</span>
					<span class="contentSpan">${contact.qq}</span>
				</div>
			</c:if>
			
			<c:if test="${not empty contact.address}">
				<div class="rowDiv">
					<span class="titleSpan">地&nbsp;&nbsp;址：</span>
					<span class="contentSpan">${contact.address}</span>
				</div>
			</c:if>
	    </div>
	</body>
</html>
