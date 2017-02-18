package com.shiro.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.domain.User;
import com.service.UserService;
import com.utils.Contants;

public class FormAuthenticationExtendFilter extends FormAuthenticationFilter {
	private static Logger logger = LoggerFactory.getLogger(FormAuthenticationExtendFilter.class);
	
	@Autowired
	private UserService userService;
	
	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		
		String successUrl = "/index";
		
		/*//成功登录后返回成功跳转页面，指定跳转地址*/
		WebUtils.issueRedirect(request, response, successUrl);
		
		//成功登录后返回成功跳转页面
		//issueSuccessRedirect(request, response);
		
		String username = (String)SecurityUtils.getSubject().getPrincipal();
		if(StringUtils.isNotBlank(username)){
			User currentUser = userService.findByUserName(token.getPrincipal().toString());
			
			httpServletRequest.getSession().setAttribute(Contants.CURRENT_USER,  currentUser);
		}
		
		
		
		return false;
	}
}
