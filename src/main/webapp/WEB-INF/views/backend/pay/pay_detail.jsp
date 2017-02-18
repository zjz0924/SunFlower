<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>支出管理</title>
		
		<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/resources/css/styles.css" rel="stylesheet">
		<link href="${ctx}/resources/css/bootstrap-table.css" rel="stylesheet">
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/WdatePicker.js"></script>
		
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
						window.location.href = "${ctx}/payController/list";
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
				
				if(!isRequired("content", "内容")){ 
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
				
				if(!isRequired("date", "支出日期")){ 
					$("#saveBtn").attr("class", "btn btn btn-orange btn-md");
					return false;  
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
						<a href="${ctx}/payController/list">支出管理</a> / 支出信息
					</div>
					
						<div class="panel-body">
							<form class="form-horizontal" action="${ctx}/payController/save" method="post" onsubmit="return checkData();" enctype="multipart/form-data">
								<input type="hidden" id="id" name="id" value="${ facadeBean.id }">
								
								<fieldset>
									<!-- 内容 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">内容</label>
										<div class="col-md-9">
											<textarea class="form-control" id="content" name="content">${facadeBean.content}</textarea>
										</div>
									</div>
									
									<!-- 价格 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>金额</label>
										<div class="col-md-9">
											<input id="price" name="price" type="text" class="form-control" value="${facadeBean.price}">
										</div>
									</div>
									
									<!-- 日期 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;"><span class="span-request">*</span>支出日期</label>
										<div class="col-md-9">
											<input type="text" id="date" name="date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate databox" value="<fmt:formatDate value='${facadeBean.date}' type='date' pattern='yyyy-MM-dd'/>" readOnly style="width:250px;"/>
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