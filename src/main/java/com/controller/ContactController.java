package com.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.domain.Contact;
import com.page.PageMap;
import com.service.ContactService;
import com.utils.Contants;
import com.vo.AjaxVO;

/**
 * 联系方式控制器
 * @author zhenjunzhuo
 * 2016-11-02
 */
@Controller
@RequestMapping(value = "contactController")
public class ContactController {
	
	@Autowired
	private ContactService contactService;
	
	//照片上传根路径 
	@Value("${img.root.url}")
	private String rootPath;
	
	@Value("${res.url.root}")
	private String resUrl;
	
	
	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Contact> dataList = contactService.selectAllList(map);
		
		if(dataList != null && dataList.size() > 0){
			model.addAttribute("facadeBean", dataList.get(0));
		}
		
		model.addAttribute("resUrl", resUrl);
		return "backend/contact/contact_detail";
	}
	
	
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Model model, String id, String name, String phone, String wechat, String qq, String address,
			@RequestParam(value = "image", required = false) MultipartFile multipartFile) {
		
		String resultCode = "";
		String resultMsg = "";
		Contact contact = null;
		
		try{
			contact = contactService.selectOne(Long.parseLong(id));
			contact.setName(name);
			contact.setAddress(address);
			contact.setQq(qq);
			contact.setPhone(phone);
			contact.setWechat(wechat);
			
			// 上传照片，获取照片路径 
			String imgName = uploadImg(multipartFile);
			if(StringUtils.isNotBlank(imgName)){
				contact.setQr(imgName);
			}
			contactService.update(contact);
			
			resultCode = Contants.EDIT_SUCCESS;
			resultMsg = Contants.EDIT_SUCCESS_MSG;
		}catch(Exception ex){
			ex.printStackTrace();
			resultCode = Contants.EXCEPTION;
			resultMsg = Contants.EXCEPTION_MSG;
		}
		
		model.addAttribute("resultCode",  resultCode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("facadeBean", contact);
		model.addAttribute("resUrl", resUrl);
		return "backend/contact/contact_detail";
	}
	
	
	/**
	 * 上传照片
	 */
	public String uploadImg(MultipartFile multipartFile) throws Exception{
		if(multipartFile != null && multipartFile.getSize() > 0){
			// 原始文件名
			String sourceName = multipartFile.getOriginalFilename();
			String newName = System.currentTimeMillis() + sourceName.substring(sourceName.indexOf("."));
			// 文件上传路径
			String uploadPath = rootPath + "/contact/";
			
			File uploadPathFile = new File(uploadPath);
			if(!uploadPathFile.exists()){
				uploadPathFile.mkdirs();
			}
			
			File srcFile = new File(uploadPath + newName);
			multipartFile.transferTo(srcFile);
			
			return "contact/" + newName;
		}
		
		return null;
	}
	
	
}
