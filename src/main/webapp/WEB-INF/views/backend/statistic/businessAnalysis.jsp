<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>
<%@include file="/page/NavPageBar.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>经营管理</title>
		
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
			
			$(function(){
				//自适应高度
				window.parent.adapter(document.body.scrollHeight + 10);
			});
		</script>
	</head>
	
	<body>
		<form id="queryForm" name="queryForm" action="${ctx}/statisticController/businessAnalysis" method="post">
		<div class="col-md-4" style="width:100%">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="search">
						<span class="allsearchSpan" style="margin-left:25px;">统计时间</span>
						<input type="text" id="startCreateTime" name="startCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endCreateTime\')}'})" class="Wdate databox" value="${startCreateTime}" readOnly/> - 
						<input type="text" id="endCreateTime" name="endCreateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startCreateTime\')}'})" class="Wdate databox" value="${endCreateTime}" readOnly/>
						
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="submit" class="btn btn-orange">搜索</button>
						<button onclick="doReset();" class="btn btn-default">取消</button>
					</div>
				</div>
			</div>
			
			<div class="panel panel-default" style="padding-top:30px;">
			
				<div class="row" style="width:100%;margin-left:20px">
					<div class="col-xs-12 col-md-6 col-lg-3">
						<div class="panel panel-blue panel-widget ">
							<div class="row no-padding">
								<div class="col-sm-3 col-lg-5 widget-left">
									<em class="glyphicon glyphicon-shopping-cart glyphicon-l"></em>
									<p style="color:white;margin-top:5px;">收入总额</p>
								</div>
								<div class="col-sm-9 col-lg-7 widget-right">
									<div class="text-muted"  style="margin-top:10px;"><span style="color:#30a5ff;font-weight:bold;font-size:20px;">￥${statistic.income}</span></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-md-6 col-lg-3">
						<div class="panel panel-red panel-widget">
							<div class="row no-padding">
								<div class="col-sm-3 col-lg-5 widget-left">
									<em class="glyphicon glyphicon-shopping-cart glyphicon-l"></em>
									<p style="color:white;margin-top:5px;">支出总额</p>
								</div>
								<div class="col-sm-9 col-lg-7 widget-right">
									<div class="text-muted" style="margin-top:10px;"><span style="color:#f9243f;font-weight:bold;font-size:20px;">￥${statistic.outcome}</span></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-md-6 col-lg-3">
						<div class="panel panel-orange panel-widget">
							<div class="row no-padding">
								<div class="col-sm-3 col-lg-5 widget-left">
									<em class="glyphicon glyphicon-stats glyphicon-l"></em>
									<p style="color:white;margin-top:5px;">营业总额</p>
								</div>
								<div class="col-sm-9 col-lg-7 widget-right">
									<div class="text-muted"  style="margin-top:10px;"><span style="color:#ffb53e;font-weight:bold;font-size:20px;">￥${statistic.income - statistic.outcome}</span></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			
				<div class="panel-body">
					<div class="bootstrap-table">
						<div class="fixed-table-container">
							<div class="fixed-table-body">
								<table class="table table-hover">
									<thead>
										<tr>
											<th style="width:6%"><div class="th-inner">序号</div></th>
											<th style="width:25%"><div class="th-inner">支出日期</div></th>
											<th style="width:25%"><div class="th-inner">数量</div></th>
											<th style="width:25%"><div class="th-inner">金额</div></th>
										</tr>
									<thead>
									<tbody>
										<c:forEach items="${dataList}" var="vo" varStatus="s">
											<tr>
												<td align="center">${s.index + 1}</td>
												<td align="center"><fmt:formatDate value='${vo.date}' type="date" pattern="yyyy-MM-dd"/></td>
												<td align="center" title="${vo.total}">${vo.total}</td>
												<td align="center" title="${vo.totalPrice}">${vo.totalPrice}</td>
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
