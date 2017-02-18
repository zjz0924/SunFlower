<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>订单管理</title>
		
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
					// 设置按钮不可点
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md disabled");
					
					if(resultCode == "01" || resultCode == "03"){ 
						parent.successTip(resultMsg);
						window.location.href = "${ctx}/orderController/list";
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
				
				//自适应高度
				window.parent.adapter(document.body.scrollHeight + 10);
			});
			
			
			function checkData(){
				// 设置按钮不可点
				$("#saveBtn").attr("class", "btn btn btn-orange btn-md disabled");
				
				if(!isRequired("flowerId", "花类")){ 
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
					return false;  
				}
				
				if(!isRequired("price", "金额")){ 
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
					return false; 
				}else{
					if(!isDouble("price", "金额")){	
						$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
						return false;
					}
				}
				
				if(!isRequired("num", "数量")){ 
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
					return false;  
				}else{
					if(!isPositive("num", "数量")){
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
						<a href="${ctx}/orderController/list">订单管理</a> / 订单信息
					</div>
					
						<div class="panel-body">
							<form class="form-horizontal" action="${ctx}/orderController/save" method="post" onsubmit="return checkData();" enctype="multipart/form-data">
								<input type="hidden" id="id" name="id" value="${ facadeBean.id }">
								
								<fieldset>
									<c:if test="${not empty facadeBean.id }">
										<div class="form-group">
											<label class="col-md-3 control-label" style="letter-spacing:2px;">照片</label>
											<div class="col-md-9">
												<img src="${resUrl}${facadeBean.flower.pic}" style="width:100px;height:100px;margin-left:10px;">
											</div>
										</div>
									</c:if>
								
									<!-- 花类 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>花类</label>
										<div class="col-md-9">
											<select id="flowerId" name="flowerId" class="form-control">
												<option value="">请选择</option>
												<c:forEach items="${flowerList}" var="vo">
													<option value="${vo.id}"  <c:if test="${facadeBean.flowerId == vo.id}">selected="selected"</c:if>>${vo.name} / ${vo.price}<c:if test="${vo.disPrice != 0}">&nbsp;（优惠价：${vo.disPrice}）</c:if></option>
												</c:forEach>
											</select>
										</div>
									</div>
									
									<!-- 价格 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>金额</label>
										<div class="col-md-9">
											<input id="price" name="price" type="text" class="form-control" value="${facadeBean.price}">
										</div>
									</div>
									
									<!-- 数量 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>数量</label>
										<div class="col-md-9">
											<input id="num" name="num" type="text" class="form-control" value="${facadeBean.num}">
										</div>
									</div>
									
									<!-- 联系人-->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">联系人</label>
										<div class="col-md-9">
											<input id="name" name="name" type="text" class="form-control" value="${facadeBean.name}">
										</div>
									</div>
									
									<!-- 电话 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">电话</label>
										<div class="col-md-9">
											<input id="phone" name="phone" type="text" class="form-control" value="${facadeBean.phone}">
										</div>
									</div>
									
									<!-- 微信  -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">微信</label>
										<div class="col-md-9">
											<input id="wechat" name="wechat" type="text" class="form-control" value="${facadeBean.wechat}">
										</div>
									</div>
									
									<!-- 地址  -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">地址</label>
										<div class="col-md-9">
											<textarea class="form-control" id="address" name="address">${facadeBean.address}</textarea>
										</div>
									</div>
									
									<!-- 备注 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">备注</label>
										<div class="col-md-9">
											<textarea class="form-control" id="remarks" name="remarks">${facadeBean.remarks}</textarea>
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