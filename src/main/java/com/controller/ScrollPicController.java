package com.controller;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.domain.ScrollPic;
import com.page.PageMap;
import com.service.ScrollPicService;
import com.utils.Contants;
import com.vo.AjaxVO;

/**
 * 滚动大图控制器
 * @author zhenjunzhuo
 * 2016-10-31
 */
@Controller
@RequestMapping(value = "scrollPicController")
public class ScrollPicController {
	
	@Autowired
	private ScrollPicService scrollPicService;
	
	//照片上传根路径 
	@Value("${img.root.url}")
	private String rootPath;
	
	@Value("${res.url.root}")
	private String resUrl;
	
	/**
	 * 列表
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String startCreateTime, String endCreateTime){
		Map<String, Object> map = new PageMap(request);
		map.put("isDelete", "N");
		
		if(StringUtils.isNotBlank(startCreateTime)){
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if(StringUtils.isNotBlank(endCreateTime)){
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		map.put("custom_order_sql", "sort_num desc");
		
		List<ScrollPic> dataList = scrollPicService.selectAllList(map);
		
		model.addAttribute("startCreateTime", startCreateTime);
		model.addAttribute("endCreateTime", endCreateTime);
		model.addAttribute("dataList", dataList);
		model.addAttribute("resUrl", resUrl);
		return "backend/scrollpic/scrollpic_list";
	}
	
	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id){
		
		if(StringUtils.isNotBlank(id)){
			ScrollPic scrollPic = scrollPicService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", scrollPic);
		}
		
		String mode = request.getParameter("mode");
		model.addAttribute("mode", mode);
		model.addAttribute("resUrl", resUrl);
		return "backend/scrollpic/scrollpic_detail";
	}
	
	
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Model model, String id, String name, String price, String info, String sortNum,
			@RequestParam(value = "image", required = false) MultipartFile multipartFile, String descrition) {
		
		String resultCode = "";
		String resultMsg = "";
		ScrollPic scrollPic = null;
		
		try{
			if(StringUtils.isNotBlank(id)){
				scrollPic = scrollPicService.selectOne(Long.parseLong(id));
				//scrollPic.setInfo(info);
				if(StringUtils.isNotBlank(sortNum)){
					scrollPic.setSortNum(Integer.parseInt(sortNum));
				}
				
				// 上传照片，获取照片路径 
				String imgName = uploadImg(multipartFile);
				if(StringUtils.isNotBlank(imgName)){
					scrollPic.setPic(imgName);
				}
				scrollPicService.update(scrollPic);
				
				resultCode = Contants.EDIT_SUCCESS;
				resultMsg = Contants.EDIT_SUCCESS_MSG;
			}else{
				scrollPic = new ScrollPic();
				scrollPic.setInfo(info);
				if(StringUtils.isNotBlank(sortNum)){
					scrollPic.setSortNum(Integer.parseInt(sortNum));
				}
				scrollPic.setCreateTime(new Date());
				
				// 上传照片，获取照片路径 
				String imgName = uploadImg(multipartFile);
				if(StringUtils.isNotBlank(imgName)){
					scrollPic.setPic(imgName);
				}
				scrollPicService.save(scrollPic);
				
				resultCode = Contants.SAVE_SUCCESS;
				resultMsg = Contants.SAVE_SUCCESS_MSG;
			}
		}catch(Exception ex){
			ex.printStackTrace();
			resultCode = Contants.EXCEPTION;
			resultMsg = Contants.EXCEPTION_MSG;
		}
		
		model.addAttribute("resultCode",  resultCode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("facadeBean", scrollPic);
		model.addAttribute("resUrl", resUrl);
		return "backend/scrollpic/scrollpic_detail";
	}
	
	
	/**
	 * 删除
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public AjaxVO delete(HttpServletRequest request){
		AjaxVO vo = new AjaxVO();
		String id = request.getParameter("id");
		
		if(StringUtils.isNotBlank(id)){
			ScrollPic scrollPic = scrollPicService.selectOne(Long.parseLong(id));
			
			if(scrollPic != null){
				scrollPic.setIsDelete("Y");
				scrollPic.setDeleteTime(new Date());
				scrollPicService.update(scrollPic);
				
				vo.setSuccess(true);
				vo.setMsg(Contants.DELETE_SUCCESS_MSG);
			}else{
				vo.setSuccess(false);
				vo.setMsg(Contants.DELETE_FAIL_MSG + "，记录不存在");
			}
		}else{
			vo.setSuccess(false);
			vo.setMsg(Contants.DELETE_FAIL_MSG + "，记录不存在");
		}
		return vo;
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
			String uploadPath = rootPath + "/scrollPic/";
			
			File uploadPathFile = new File(uploadPath);
			if(!uploadPathFile.exists()){
				uploadPathFile.mkdirs();
			}
			
			File srcFile = new File(uploadPath + newName);
			multipartFile.transferTo(srcFile);
			
			return "scrollPic/" + newName;
		}
		
		return null;
	}
}
