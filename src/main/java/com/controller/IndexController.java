package com.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.domain.User;
import com.service.UserService;
import com.utils.Contants;

/**
 * 首页控制器
 * @author zhenjunzhuo
 */
@Controller
@RequestMapping(value = "")
public class IndexController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {
		User currentUser = (User) request.getSession().getAttribute(Contants.CURRENT_USER);
		 
		model.addAttribute("currentUser", currentUser);
		return "backend/sys/index";
	}

}

		
		
