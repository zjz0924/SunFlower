<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link type="text/css" rel="stylesheet" href="${ctx}/resources/css/wechat.css" />
		<script type="text/javascript" src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		
		<title>留言板</title>
		<script type="text/javascript">
			function doSubmit(){
				var name = $("#name").val();
				var wechat = $("#wechat").val();
				var phone = $("#phone").val();
				var content = $("#content").val();
				$("#notice").css("color", "#eb6a40");
				$("#notice").html("");
				$("#tips").hide();
				
				if(isNull(name)){
					$("#notice").html("请填写姓名");
					$("#name").focus();
					$("#tips").show();
					return false;
				}
				
				if(isNull(wechat) && isNull(phone)){
					$("#notice").html("微信号与手机请任选一个填写");
					$("#tips").show();
					return false;
				}
				
				if(isNull(content)){
					$("#notice").html("请填写留言内容");
					$("#content").focus();
					$("#tips").show();
					return false;
				}
				
				$.ajax({
					url: "${ctx}/wechatController/saveMessage?time=" + new Date(),
					data: {
						name: name,
						wechat: wechat,
						phone: phone,
						content: content
					},
					success: function(data){
						var suc = data.success;
						$("#tips").show();
						$("#notice").html(data.msg);
						
						if(suc){
							$("#notice").css("color", "green");
							$("#name").val('');
							$("#wechat").val('');
							$("#phone").val('');
							$("#content").val('');
						}
					}
				});
			}
			
			function isNull(data){
				if(data == null || data == undefined || data == ""){
					return true;
				}
				return false;
			}
		</script>
		
	</head>
	
	
	<body>
	    <div style="background-color:white;margin-top:5px;padding-bottom:10px;">
	    	<div class="titleCenter">
	    		<div class="titleIcon">&nbsp;</div>
	    		<div class="titleContent">留言板</div>
	    	</div>

			<div class="g_globalLine mtitle">
				<div class="mbTitle publishIcon">
		    		发表留言
		    	</div>
			</div>
	    	
	    	<!-- 错误信息 -->
	    	<div id="tips" style="display:none;">
	    		<div class="notice" id="notice"></div>
	    	</div>
	    	
	    	<!-- 姓名 -->
	    	<div class="g_globalLine">
	    		<input id="name" type="text" maxlength="50 " placeholder="姓名(必填)" class="msg_isMust msg_ipt g_input fk-inputFontColor">
	    	</div>
	    	
	    	<!-- 微信号 -->
	    	<div class="g_globalLine">
	    		<input id="wechat" type="text" maxlength="50 " placeholder="微信号(可填)" class="msg_isMust msg_ipt g_input fk-inputFontColor">
	    	</div>
	    	
	    	<!-- 手机 -->
	    	<div class="g_globalLine">
	    		<input id="phone" type="text" maxlength="50 " placeholder="电话号码(可填)" class="msg_isMust msg_ipt g_input fk-inputFontColor">
	    	</div>
	    	
	    	<!-- 内容 -->
	    	<div class="g_globalLine">
				<textarea id="content" class="g_textArea msg_textArea" maxlength="10000" placeholder="内容"></textarea>
	    	</div>
	    	
	    	<div style="clear:both"></div>
	    	<div class="g_globalLine">
	    		<input type="button" class="g_button sendIcon msgSubmitButton submitIcon" onclick="doSubmit()" value="提交">
	    	</div>
	    	
	    </div>
	</body>
</html>
