<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>flower</title>
		
		<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/resources/css/styles.css" rel="stylesheet">
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/My97DatePicker/WdatePicker.js"></script>
		
		<script type="text/javascript">
			function goTo(url){
				window.location.href = "${ctx}/" + url;
			}
			
			function doReset(){
				$(":input").val("");
			}

			function del(id){
				art.dialog.confirm('是否确定删除该商品？', function () {
					$.ajax({
						url:"${ctx}/flowerController/delete",
						data:{
							id: id
						},
						success:function(data){
							var suc = data.success;
							
							if(suc){
								parent.successTip(data.msg);
								window.location.reload();
							}else{
								parent.errorTip(data.msg);
							}
						}
					});
				});
			}
			
			function updateDisplay(id, type){
				var msg;
				if(type == 'N'){
					msg = "是否确定要下架该商品？";
				}else{
					msg = "是否确定要恢复该商品？"
				}
				
				art.dialog.confirm(msg, function () {
					$.ajax({
						url:"${ctx}/flowerController/updateDisplay",
						data:{
							id: id,
							display: type
						},
						success:function(data){
							var suc = data.success;
							
							if(suc){
								art.dialog.tips(data.msg, 1, "succeed");
								window.location.reload();
							}else{
								art.dialog.tips(data.msg, 2, "error");
							}
						}
					});
				});
			}
		</script>
		
	</head>
	
	<body>
		<form id="queryForm" name="queryForm" action="${ctx}/flowerController/list" method="post">
		<div class="col-md-4" style="width:100%">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="search">
						<span class="allsearchSpan" style="margin-left:25px;">名称</span>
						<input value="${name}" id="name" name="name" type="text" class="form-control" style="width:150px;">
						
						<span class="allsearchSpan" style="margin-left:25px;">创建时间</span>
						<input type="text" id="startCreateTime" name="startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endCreateTime\')}'})" class="Wdate databox" value="${startCreateTime}" readOnly/> - 
						<input type="text" id="endCreateTime" name="endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startCreateTime\')}'})" class="Wdate databox" value="${endCreateTime}" readOnly/>
						
						<span class="allsearchSpan" style="margin-left:25px;">分类</span>
						<select id="isDisplay" name="isDisplay" class="form-control" style="width:150px;">
							<option value="">全部</option>
							<option value="Y"  <c:if test="${isDisplay == 'Y'}">selected="selected"</c:if>>是</option>
							<option value="N"  <c:if test="${isDisplay == 'N'}">selected="selected"</c:if>>否</option>
						</select>
						
						<button type="submit" class="btn btn-orange">搜索</button>
						<button onclick="doReset();" class="btn btn-default">取消</button>
						
						<span class="pull-right" style="margin:8px 5px">
							<button onclick="goTo('flowerController/detail')"  class="btn" type="button" style="background-color:white;border:1px solid orange;color:orange;">添加</button>
						</span>
					</div>
				</div>
			</div>
					
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="bootstrap-table">
						<div class="fixed-table-container">
							<div class="fixed-table-body">
								<table class="table table-hover">
									<thead>
										<tr>
											<th style="width:6%"><div class="th-inner">序号</div></th>
											<th style="width:10%"><div class="th-inner">名称</div></th>
											<th style="width:8%"><div class="th-inner">图片</div></th>
											<th style="width:11%"><div class="th-inner">价格/优惠价格</div></th>
											<th style="width:7%"><div class="th-inner">是否展示</div></th>
											<th style="width:15%"><div class="th-inner">花语</div></th>
											<th style="width:15%"><div class="th-inner">优惠信息</div></th>
											<th style="width:9%"><div class="th-inner">创建时间</div></th>
											<th><div class="th-inner">操作</div></th>
										</tr>
									<thead>
									<tbody>
										<c:forEach items="${dataList}" var="vo" varStatus="s">
											<tr>
												<td align="center">${s.index + 1}</td>
												<td title="${vo.name}">${vo.name}</td>
												<td align="center"><img src="${resUrl}${vo.pic}" style="width:50px;height:40px;"></td>
												<td align="center" title="${vo.price}">${vo.price} / ${vo.disPrice}</td>
												<td align="center">
													<c:if test="${vo.isDisplay == 'Y' }"><span style="color:green;font-weight:bold;">是</span></c:if>
													<c:if test="${vo.isDisplay == 'N' }"><span style="color:red;font-weight:bold;">否</span></c:if>
												</td>
												<td align="center" title="${vo.language}">${vo.language}</td>
												<td align="center" title="${vo.discount}">${vo.discount}</td>
												<td align="center"><fmt:formatDate value='${vo.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/></td>
												
												<td align="center">
													<button type="button" onclick="goTo('flowerController/detail?id=${vo.id}&mode=readonly')" style="background-color:orange;color:white;border:0px;margin-bottom:5px;">查看</button>&nbsp;
													
													<button type="button" onclick="goTo('flowerController/detail?id=${vo.id}')" style="background-color:orange;color:white;border:0px;" title="编辑">编辑</button>&nbsp;
													
													<button type="button" onclick="del(${vo.id})" style="background-color:orange;color:white;border:0px;" title="删除">删除</button>&nbsp;
													
													<c:choose>
														<c:when test="${empty vo.isDisplay || vo.isDisplay == 'N' }">
															<button type="button" onclick="updateDisplay('${vo.id}', 'Y')" style="background-color:white;color:orange;border:1px solid orange;" title="上架">上架</button>&nbsp;
														</c:when>
														<c:otherwise>
															<button type="button" onclick="updateDisplay('${vo.id}', 'N')" style="background-color:white;color:orange;border:1px solid orange;" title="下架">下架</button>&nbsp;
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:forEach>
										
										<c:if test="${fn:length(dataList) < 1}">
											<tr><td colspan="10" align="center">暂无数据</td></tr>
										</c:if>
									</tbody>
								</table>
							</div>
							<pagination:pagebar startRow="${dataList.getStartRow()}" id="queryForm" pageSize="${dataList.getPageSize()}"  totalSize="${dataList.getTotal()}"   showbar="true"  showdetail="true"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
	</body>
</html>
