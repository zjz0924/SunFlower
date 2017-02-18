<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>ScrollPic</title>
		
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
				art.dialog.confirm('是否确定删除该图片？', function () {
					$.ajax({
						url:"${ctx}/scrollPicController/delete",
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
		</script>
		
	</head>
	
	<body>
		<form id="queryForm" name="queryForm" action="${ctx}/scrollPicController/list" method="post">
		<div class="col-md-4" style="width:100%">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="search">
						<span class="allsearchSpan" style="margin-left:25px;">创建时间</span>
						<input type="text" id="startCreateTime" name="startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endCreateTime\')}'})" class="Wdate databox" value="${startCreateTime}" readOnly/> - 
						<input type="text" id="endCreateTime" name="endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startCreateTime\')}'})" class="Wdate databox" value="${endCreateTime}" readOnly/>
						
						<button type="submit" class="btn btn-orange">搜索</button>
						<button onclick="doReset();" class="btn btn-default">取消</button>
						
						<span class="pull-right" style="margin:8px 5px">
							<button onclick="goTo('scrollPicController/detail')"  class="btn" type="button" style="background-color:white;border:1px solid orange;color:orange;">添加</button>
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
											<th style="width:25%"><div class="th-inner">图片</div></th>
											<!-- <th style="width:25%"><div class="th-inner">信息</div></th> -->
											<th style="width:25%"><div class="th-inner">排序号</div></th>
											<th style="width:25%"><div class="th-inner">创建时间</div></th>
											<th><div class="th-inner">操作</div></th>
										</tr>
									<thead>
									<tbody>
										<c:forEach items="${dataList}" var="vo" varStatus="s">
											<tr>
												<td align="center">${s.index + 1}</td>
												<td align="center"><img src="${resUrl}/${vo.pic}" style="width:50px;height:40px;"></td>
												<%-- <td align="center" title="${vo.info}">${vo.info}</td> --%>
												<td align="center" title="${vo.sortNum}">${vo.sortNum}</td>
												<td align="center"><fmt:formatDate value='${vo.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/></td>
												
												<td align="center">
													<button type="button" onclick="goTo('scrollPicController/detail?id=${vo.id}&mode=readonly')" style="background-color:orange;color:white;border:0px;margin-bottom:5px;">查看</button>&nbsp;
													<button type="button" onclick="goTo('scrollPicController/detail?id=${vo.id}')" style="background-color:orange;color:white;border:0px;" title="编辑">编辑</button>&nbsp;
													<button type="button" onclick="del(${vo.id})" style="background-color:orange;color:white;border:0px;" title="删除">删除</button>&nbsp;
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
