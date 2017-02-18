<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商品管理</title>
		
		<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/resources/css/styles.css" rel="stylesheet">
		<link href="${ctx}/resources/css/bootstrap-table.css" rel="stylesheet">
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/ckeditor_full/ckeditor.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/ckeditor_full/lang/zh-cn.js"></script>
		
		<!--[if lt IE 9]>
		<script src="js/html5shiv.js"></script>
		<script src="js/respond.min.js"></script>
		<![endif]-->
		
		<script>
			var descritionEditor;
			
			$(function(){
				var resultCode = "${resultCode}";
				if(resultCode != null && resultCode != '' && resultCode != undefined){
					var resultMsg = "${resultMsg}";
					// 设置按钮不可点
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md disabled");
					
					if(resultCode == "01" || resultCode == "03"){ 
						parent.successTip(resultMsg);
						window.location.href = "${ctx}/flowerController/list";
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
				
				descritionEditor =  CKEDITOR.replace('descrition', { height: '300px', width: '700px' });
				
				//自适应高度
				window.parent.adapter(document.body.scrollHeight + 10);
			});
			
			
			function checkData(){
				// 设置按钮不可点
				$("#saveBtn").attr("class", "btn btn btn-orange btn-md disabled");
				
				if(!isRequired("name", "名称")){ 
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
					return false;  
				}
				
				if(!isRequired("price", "价格")){ 
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
					return false; 
				}else{
					if(!isDouble("price", "价格")){
						$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
						return false;
					}
				}
				
				var disPrice = $("#disPrice").val();
				if(!isNull(disPrice)){
					if(!isDouble("disPrice", "优惠价格")){
						$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
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
						<a href="${ctx}/flowerController/list">商品管理</a> / 商品信息
					</div>
					
						<div class="panel-body">
							<form class="form-horizontal" action="${ctx}/flowerController/save" method="post" onsubmit="return checkData();" enctype="multipart/form-data">
								<input type="hidden" id="id" name="id" value="${ facadeBean.id }">
								
								<fieldset>
									<!-- 名称 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>商品名称</label>
										<div class="col-md-9">
											<input id="name" name="name" type="text" class="form-control" value="${facadeBean.name}">
										</div>
									</div>
									
									<!-- 照片 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">
											<c:if test="${empty facadeBean.id }"><span class="span-request">*</span></c:if>封面
										</label>
										<div class="col-md-9">
											<c:if test="${not empty facadeBean.id }">
												<img src="${resUrl}${facadeBean.pic}" style="width:100px;height:100px;margin-left:10px;">
											</c:if>
											<input type="file" id="image" name="image" class="form-control">
										</div>
									</div>
									
									<!-- 价格 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>价格</label>
										<div class="col-md-9">
											<input id="price" name="price" type="text" class="form-control" value="${facadeBean.price}">
										</div>
									</div>
									
									<!-- 优惠价格 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">优惠价格 </label>
										<div class="col-md-9">
											<input id="disPrice" name="disPrice" type="text" class="form-control" value="${facadeBean.disPrice}">
										</div>
									</div>
									
									<!-- 花语-->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">花语 </label>
										<div class="col-md-9">
											<textarea class="form-control" id="language" name="language">${facadeBean.language}</textarea>
										</div>
									</div>
									
									<!-- 优惠 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">优惠说明 </label>
										<div class="col-md-9">
											<textarea class="form-control" id="discount" name="discount">${facadeBean.discount}</textarea>
										</div>
									</div>
									
									<!-- 简介 -->
									<div class="form-group"  style="height:500px;">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">简介</label>
										<div class="col-md-9">
											<textarea class="fl textarea-1" id="descrition" name="descrition">${facadeBean.descrition}</textarea>
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