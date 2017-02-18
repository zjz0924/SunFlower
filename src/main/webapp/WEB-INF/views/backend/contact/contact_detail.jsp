<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>联系方式</title>
		
		<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/resources/css/styles.css" rel="stylesheet">
		<link href="${ctx}/resources/css/bootstrap-table.css" rel="stylesheet">
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
		
		<!--[if lt IE 9]>
		<script src="js/html5shiv.js"></script>
		<script src="js/respond.min.js"></script>
		<![endif]-->
		
		<script>
			$(function(){
				var resultCode = "${resultCode}";
				if(resultCode != null && resultCode != '' && resultCode != undefined){
					var resultMsg = "${resultMsg}";
					
					if(resultCode == "01" || resultCode == "03"){ 
						art.dialog.tips(resultMsg, 2, "succeed");
					}else{
						art.dialog.tips(resultMsg, 2, "error");
						edit(1);
					}
				}
			});
			
			function edit(type){
				if(type == 1){
					$("label.account-content").hide();
					$("input").show();
					$("#image").css("display", "inline-block");
					$("#btnDiv").show();
				}else{
					$("label.account-content").show();
					$("input").hide();
					$("#btnDiv").hide();
				}
			}
		</script>
	</head>

	<body>
		<form class="form-horizontal" action="${ctx}/contactController/save" method="post" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${facadeBean.id}">
			
			<div class="col-md-4" style="width:100%">
				<div class="panel panel-default">
					<div class="panel-heading">
						联系方式
						<span class="pull-right" style="margin:8px 5px">
							<button onclick="edit(1)"  class="btn" type="button" style="background-color:white;border:1px solid orange;color:orange;">编辑</button>
						</span>
					</div>
					<div class="panel-body" style="margin-top:5px;">
						<div class="form-group" style="margin-bottom:20px;">
							<label class="account-title">联&nbsp;&nbsp;系&nbsp;&nbsp;人：</label>
							<label id="userNameLabel" class="account-content"> ${facadeBean.name} </label>
							<input id="name"  name="name" type="text" class="form-control" style="display:none;" value="${facadeBean.name}">
						</div>
						
						<div class="form-group" style="margin-bottom:20px;">
							<label class="account-title">手机号码：</label>
							<label class="account-content">${facadeBean.phone}</label>
							<input id="phone"  name="phone" type="text" class="form-control" style="display:none;" value="${facadeBean.phone}">
						</div>
						
						<div class="form-group" style="margin-bottom:20px;">
							<label class="account-title">QQ：</label>
							<label class="account-content">${facadeBean.qq}</label>
							<input id="qq"  name="qq" type="text" class="form-control" style="display:none;" value="${facadeBean.qq}">
						</div>
						
						<div class="form-group" style="margin-bottom:20px;">
							<label class="account-title">微信号：</label>
							<label class="account-content"> ${facadeBean.wechat} </label>
							<input id="wechat"  name="wechat" type="text" class="form-control" style="display:none;" value="${facadeBean.wechat}">
						</div>
						
						<div class="form-group" style="margin-bottom:20px;">
							<label class="account-title">二维码：</label>
							<label class="account-content"> <img src="${resUrl}/${facadeBean.qr}" style="width:100px;height:100px;"> </label>
							<input type="file" id="image" name="image" class="form-control" style="display:none;">
						</div>
						
						<div class="form-group" style="margin-bottom:20px;">
							<label class="account-title">地址：</label>
							<label class="account-content"> ${facadeBean.address} </label>
							<input id="address"  name="address" type="text" class="form-control" style="display:none;" value="${facadeBean.address}">
						</div>
						
						<div style="margin-bottom:30px;margin-top:30px;margin-left:100px;display:none;" id="btnDiv">
							<button type="submit" class="btn btn btn-orange btn-md">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="reset" class="btn btn-default btn-md" onclick="edit(2);">取消</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</body>

</html>