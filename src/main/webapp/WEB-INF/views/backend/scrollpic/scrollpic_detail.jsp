<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>滚动大图</title>
		
		<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/resources/css/styles.css" rel="stylesheet">
		<link href="${ctx}/resources/css/bootstrap-table.css" rel="stylesheet">
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
		
		<script>
			$(function(){
				var resultCode = "${resultCode}";
				if(resultCode != null && resultCode != '' && resultCode != undefined){
					var resultMsg = "${resultMsg}";
					// 设置按钮不可点
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md disabled");
					
					if(resultCode == "01" || resultCode == "03"){ 
						parent.successTip(resultMsg);
						window.location.href = "${ctx}/scrollPicController/list";
					}else{
						// 设置按钮可点
						$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
						parent.errorTip(resultMsg);
					}
				}
				
				var mode = "${mode}";
				if(mode == "readonly"){
					$(":input").attr("disabled","true");
				}
			});
			
			function checkData(){
				// 设置按钮不可点
				$("#saveBtn").attr("class", "btn btn btn-orange btn-md disabled");
				
				var sortNum = $("#sortNum").val();
				if(!isNull(sortNum)){
					if(!isPositiveNum($("#sortNum").val())){
						parent.errorTip("排序号必须为正整数");
						$("#sortNum").focus();
						$("#sortNum").val();
						return false;
					}
				}
				return true;
			}
		</script>	
	</head>

	<body>
		<div class="row">
			<div class="col-md-8">
				<div class="panel panel-default">
					<div class="panel-heading">
						<a href="${ctx}/scrollPicController/list">滚动大图管理</a> / 大图信息
					</div>
					
						<div class="panel-body">
							<form class="form-horizontal" action="${ctx}/scrollPicController/save" method="post" onsubmit="return checkData();" enctype="multipart/form-data">
								<input type="hidden" id="id" name="id" value="${facadeBean.id}">
								
								<fieldset>
									<!-- 照片 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">
											<c:if test="${empty facadeBean.id}"><span class="span-request">*</span></c:if>图片
										</label>
										<div class="col-md-9">
											<c:if test="${not empty facadeBean.id }">
												<img src="${resUrl}/${facadeBean.pic}" style="width:200px;height:150px;margin-left:10px;">
											</c:if>
											<input type="file" id="image" name="image" class="form-control">
										</div>
									</div>
									
									<!-- 标题 -->
								<%-- 	<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>标题</label>
										<div class="col-md-9">
											<input id="info" name="info" type="text" class="form-control" value="${facadeBean.info}">
										</div>
									</div> --%>
									
									<!-- 排序号 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">排序号 </label>
										<div class="col-md-9">
											<input id="sortNum" name="sortNum" type="text" class="form-control" value="${facadeBean.sortNum}">
										</div>
									</div>
									
									<div class="widget-center">
										<button id="saveBtn" type="submit" class="btn btn btn-orange btn-md">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="reset" class="btn btn-default btn-md" onclick="window.location.reload();">取消</button>
									</div>
									
								</fieldset>
							</form>
						<div>
					</div>
				</div>
			</div>
		</div>
	</body>

</html>