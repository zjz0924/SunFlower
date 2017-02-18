<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/page/taglibs.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Sun Flower</title>

		<link href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/resources/css/styles.css" rel="stylesheet">
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/artDialog.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/jquery.artDialog.source.js?skin=idialog"></script>
		<script type="text/javascript" src="${ctx}/resources/js/artDialog4.1.2/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="${ctx}/resources/js/tools.js"></script>
		
		<!--[if lt IE 9]>
		<script src="js/html5shiv.js"></script>
		<script src="js/respond.min.js"></script>
		<![endif]-->
	</head>

	<body>
		<div class="row">
			<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-4 col-md-offset-4" style="margin-top:80px;">
				<div class="login-panel panel panel-default">
					<div class="panel-heading" style="color:black;font-size:25px;">Sun Flower</div>
					<div class="panel-body">
						<form action="${ctx}/backend/login" method="post" id="loginForm">
							<fieldset>
								<div class="form-group">
									<label class="login-span">用户名</label>
									<input class="form-control"  id="username" name="username" type="username" autofocus="true">
								</div>
								<div class="form-group">
									<label class="login-span">密码</label>
									<input class="form-control"  id="password" name="password" type="password">
								</div>
								<div class="form-group">
									<label class="login-span">验证码</label>
									<input name="vcode" id="vcode" class="form-control" maxLength="4"  style="width:35%;vertical-align:middle;display:inline-block"/> 
									<img src="${ctx}/backend/verifycode" id="verifyimg" title="看不清？点击刷新！" style="cursor: pointer;vertical-align:middle;margin-left:20px;"/>
								</div>
								
								<div id="error_message" align="center" style="color:red;font-weight:bold;">${error}</div>
								
								<div align="center" style="margin-top:20px;">
									<a href="javascript:void(0)" class="btn btn-primary" id="login">登录</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:void(0)" class="btn btn-danger" id="cancel">取消</a>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
			</div><!-- /.col-->
		</div><!-- /.row -->	

		<script src="${ctx}/resources/js/jquery-1.11.1.min.js"></script>
		<script>
			!function ($) {
				$("#login").click(function(){
					doSubmit();
				});
				
				$("#cancel").click(function(){
					$("#username").val("");
					$("#password").val("");
					$("#vcode").val("");
					$("#error_message").html("");
				});
				
				$("#verifyimg").click(function(){
					refreshVerify("verifyimg");
				});
				
				/**有父窗口则在父窗口打开*/  
		        if(self!=top){top.location=self.location;}  
			}(window.jQuery);
			
			document.onkeydown = function(event){
				var e = event || window.event || arguments.callee.caller.arguments[0];
				if(e && e.keyCode == 13){ // enter 键
					doSubmit();
				}
			}; 
			
			function checkVerify(verify) {
				var ret = false;
				jQuery.ajax({
			        type: "GET",
			        cache: false,
			        url: "${ctx}/backend/checkverify",
			        async: false,
			        data: "vcode="+verify,
			        success: function(msg) {
			        	ret = msg;
			        }
			    });
				
				return ret;
			}
			
			function refreshVerify(id){
				var imgurl = "${ctx}/backend/verifycode?rnd="+new Date().getTime();
				$("#"+id).attr("src", imgurl);
			}

			function doSubmit(){
				var username = $("#username").val();
				var password = $("#password").val();
				var verifyCode = $("#vcode").val();
			
				if (username.length == 0){
					$("#error_message").html("请输入用户名");
					$("#username").focus();
					return false;
				}else{
					$("#error_message").html("");
				}					
				
				if (password.length == 0){
					$("#error_message").html("请输入密码");
					$("#password").focus();
					return false;
				}
				
				if (verifyCode.length == 0){
					$("#error_message").html("请输入验证码");
					$("#vcode").focus();
					return false;
				}else {
					if (checkVerify(verifyCode) != true) {
			    		$("#error_message").html("验证码输入错误，看不清？点击图片换一个");
			    		$("#vcode").focus();
			    		
			    		//刷新验证码
			    		refreshVerify("verifyimg");
			    		return false;
					}else{
						$("#error_message").html("");
					}
				}
				
				$('#loginForm').submit();
			}
		</script>	
	</body>

</html>
