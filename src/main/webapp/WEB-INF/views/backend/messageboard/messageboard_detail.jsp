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
						<a href="${ctx}/messageBoardController/list">留言管理</a> / 留言信息
					</div>
					
						<div class="panel-body">
							<form class="form-horizontal" action="${ctx}/messageBoardController/save" method="post" onsubmit="return checkData();" enctype="multipart/form-data">
								<input type="hidden" id="id" name="id" value="${ facadeBean.id }">
								
								<fieldset>
									<!-- 名称 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">姓名</label>
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
									
									<!-- 微信 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">微信</label>
										<div class="col-md-9">
											<input id="phone" name="phone" type="text" class="form-control" value="${facadeBean.wechat}">
										</div>
									</div>
									
									<!-- 内容 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">内容</label>
										<div class="col-md-9">
											<textarea class="form-control" id="descrition" name="descrition">${facadeBean.content}</textarea>
										</div>
									</div>
									
									<!-- 留言时间 -->
									<div class="form-group">
										<label class="col-md-3 control-label" style="letter-spacing:2px;">留言时间</label>
										<div class="col-md-9">
											<input type="text" id="date" name="date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate databox" value="<fmt:formatDate value='${facadeBean.createTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" readOnly style="width:250px;"/>
										</div>
									</div>
									<!-- 
									<div class="widget-center">
										<button id="saveBtn" type="submit" class="btn btn btn-orange btn-md">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="reset" class="btn btn-default btn-md" onclick="window.location.reload();">取消</button>
									</div> -->
									
								</fieldset>
							</form>
						<div>
					</div>
				</div>
			</div>
		</div>
	</body>

</html>