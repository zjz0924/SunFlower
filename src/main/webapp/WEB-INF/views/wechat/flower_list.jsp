<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/wappage/taglibs.jsp" %>
<%@include file="/wappage/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link type="text/css" rel="stylesheet" href="${ctx}/resources/css/wechat.css"/>
		
		<title>产品展示</title>

		<style type="text/css">
			body{
				font-size: .9rem;
			}
		</style>
	</head>
	
	
	<body style="margin: 0px;">
		<form id="queryForm" name="queryForm" action="${ctx}/wechatController/flowerList" method="post">
		    <div style="background-color:white;margin-top:5px;padding-bottom:10px;">
		    	<div class="titleCenter">
		    		<div class="titleIcon">&nbsp;</div>
		    		<div class="titleContent">产品展示</div>
		    	</div>
		    	
		    	<div class="productList">
		    		<c:forEach items="${dataList}" var="vo">
		    			<div class="productPicListForm">
		    				<a href="${ctx}/wechatController/detail?id=${vo.id}">
		    					<div class="tableBox">
		    						<div class="tableCell tableCell-30">
		    							<img src="${resUrl}${vo.pic}" style="width:100%;height:100px;border-radius: .2rem;">
		    						</div>
		    						
		    						<div class="tableCell tableCell-70">
		    							<div class="paramName nameWrap" style="font-size:1.1rem;">${vo.name}</div>
		    						
		    							<c:if test="${not empty vo.language}">
		    								<div class="paramName nameWrap" style="font-size:.8rem;">${vo.language}</div>
		    							</c:if>
		    							<div class="paramName nameWrap" style="margin-bottom:.2rem;">
		    								<span style="color:red;font-weight:bold;<c:if test="${vo.disPrice != 0}">text-decoration:line-through;color:#666;</c:if>">${vo.price}</span>
		    								<c:if test="${vo.disPrice != 0}"><span style="color:red;font-weight:bold;"> / ${vo.disPrice}</span></c:if>
		    							</div>
		    							
		    							<c:if test="${not empty vo.discount}">
		    								<div class="paramName nameWrap"><span style="color:#f92a65;font-weight:bold;">${vo.discount}</span></div>
		    							</c:if>
		    						</div>
		    					</div>
		    				</a>
		    			</div>
		    			<div class="separatorLine"></div>
		    		</c:forEach>
		    		
		    		<c:if test="${not empty dataList}">
		    			<pagination:pagebar startRow="${dataList.getStartRow()}" id="queryForm" pageSize="${dataList.getPageSize()}"  totalSize="${dataList.getTotal()}"   showbar="true"  showdetail="true"/>
		    		</c:if>
		    	</div>
		    </div>
		</form>
	</body>
</html>
