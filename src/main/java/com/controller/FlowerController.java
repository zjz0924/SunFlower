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

import com.domain.Flower;
import com.page.PageMap;
import com.service.FlowerService;
import com.utils.Contants;
import com.vo.AjaxVO;

/**
 * 花控制器
 * @author zhenjunzhuo
 * 2016-10-31
 */
@Controller
@RequestMapping(value = "flowerController")
public class FlowerController {
	
	@Autowired
	private FlowerService flowerService;
	
	//照片上传根路径 
	@Value("${img.root.url}")
	private String rootPath;
	
	@Value("${res.url.root}")
	private String resUrl;
	
	/**
	 * 列表
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String name, String startCreateTime, String endCreateTime, String isDisplay){
		Map<String, Object> map = new PageMap(request);
		map.put("isDelete", "N");
		
		if(StringUtils.isNotBlank(name)){
			map.put("name", name);
		}
		if(StringUtils.isNotBlank(startCreateTime)){
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if(StringUtils.isNotBlank(endCreateTime)){
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		if(StringUtils.isNotBlank(isDisplay)){
			map.put("isDisplay", isDisplay);
		}
		map.put("custom_order_sql", "is_display asc, create_time desc");
		
		List<Flower> dataList = flowerService.selectAllList(map);
		
		model.addAttribute("name", name);
		model.addAttribute("startCreateTime", startCreateTime);
		model.addAttribute("endCreateTime", endCreateTime);
		model.addAttribute("isDisplay", isDisplay);
		model.addAttribute("dataList", dataList);
		model.addAttribute("resUrl", resUrl);
		return "backend/flower/flower_list";
	}
	
	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id){
		
		if(StringUtils.isNotBlank(id)){
			Flower flower = flowerService.selectOne(Long.parseLong(id));
			
			
			model.addAttribute("facadeBean", flower);
		}
		
		String mode = request.getParameter("mode");
		model.addAttribute("mode", mode);
		model.addAttribute("resUrl", resUrl);
		return "backend/flower/flower_detail";
	}
	
	
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Model model, String id, String name, String price, String discount,
			@RequestParam(value = "image", required = false) MultipartFile multipartFile, String descrition, String disPrice, String language) {
		
		String resultCode = "";
		String resultMsg = "";
		Flower flower = null;
		
		try{
			if(StringUtils.isNotBlank(id)){
				flower = flowerService.selectOne(Long.parseLong(id));
				
				List<Flower> menuList = null;
				if(!name.equals(flower.getName())){
					Map<String, Object> rMap = new HashMap<String, Object>();
					rMap.put("name", name);
					rMap.put("isDelete", "N");
					menuList = flowerService.selectAllList(rMap);
				}
				
				if(menuList != null && menuList.size() > 0){
					resultCode = Contants.EDIT_FAIL;
					resultMsg = Contants.EDIT_FAIL_MSG + "，名称已存在";
				}else{
					flower.setName(name);
					flower.setPrice(Double.parseDouble(price));
					flower.setDiscount(discount);
					flower.setDescrition(descrition);
					if(StringUtils.isNoneBlank(disPrice)){
						flower.setDisPrice(Double.parseDouble(disPrice));
					}else{
						flower.setDisPrice(0d);
					}
					flower.setLanguage(language);
					
					// 上传照片，获取照片路径 
					String imgName = uploadImg(multipartFile);
					if(StringUtils.isNotBlank(imgName)){
						flower.setPic(imgName);
					}
					flowerService.update(flower);
					
					resultCode = Contants.EDIT_SUCCESS;
					resultMsg = Contants.EDIT_SUCCESS_MSG;
				}
			}else{
				flower = new Flower();
				flower.setName(name);
				if(StringUtils.isNoneBlank(disPrice)){
					flower.setDisPrice(Double.parseDouble(disPrice));
				}else{
					flower.setDisPrice(0d);
				}
				flower.setDiscount(discount);
				flower.setDescrition(descrition);
				flower.setCreateTime(new Date());
				flower.setDisPrice(Double.parseDouble(disPrice));
				flower.setLanguage(language);
				
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("name", name);
				rMap.put("isDelete", "N");
				List<Flower> flowerList = flowerService.selectAllList(rMap);
				
				if(flowerList != null && flowerList.size() > 0){
					resultCode = Contants.SAVE_FAIL;
					resultMsg = Contants.SAVE_FAIL_MSG + "，名称已存在";
				}else{
					// 上传照片，获取照片路径 
					String imgName = uploadImg(multipartFile);
					if(StringUtils.isNotBlank(imgName)){
						flower.setPic(imgName);
					}
					flowerService.save(flower);
					
					resultCode = Contants.SAVE_SUCCESS;
					resultMsg = Contants.SAVE_SUCCESS_MSG;
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
			resultCode = Contants.EXCEPTION;
			resultMsg = Contants.EXCEPTION_MSG;
		}
		
		model.addAttribute("resultCode",  resultCode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("facadeBean", flower);
		model.addAttribute("resUrl", resUrl);
		return "backend/flower/flower_detail";
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
			Flower flower = flowerService.selectOne(Long.parseLong(id));
			
			if(flower != null){
				flower.setIsDelete("Y");
				flower.setDeleteTime(new Date());
				flowerService.update(flower);
				
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
	 * 商品上下架
	 * @param   display，Y-上架，N-下架
	 * @param   id，菜单ID
	 */
	@ResponseBody
	@RequestMapping(value = "/updateDisplay")
	public AjaxVO updateDisplay(HttpServletRequest request){
		AjaxVO vo = new AjaxVO();
		String id = request.getParameter("id");
		String display = request.getParameter("display");
		
		if(StringUtils.isNotBlank(id)){
			Flower flower = flowerService.selectOne(Long.parseLong(id));
			flower.setIsDisplay(display);
			
			int num = flowerService.update(flower);
			if(num > 0){
				vo.setSuccess(true);
				vo.setMsg("操作成功");
			}else{
				vo.setSuccess(false);
				vo.setMsg("操作失败，商品不存在");
			}
		}else{
			vo.setSuccess(false);
			vo.setMsg("操作失败，商品不存在");
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
			String uploadPath = rootPath + "/flower/";
			
			File uploadPathFile = new File(uploadPath);
			if(!uploadPathFile.exists()){
				uploadPathFile.mkdirs();
			}
			
			File srcFile = new File(uploadPath + newName);
			multipartFile.transferTo(srcFile);
			
			return "flower/" + newName;
		}
		
		return null;
	}
	
	
	/**
	 * 编辑器上传照片
	 * @param multipartFile
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="uploadEditorFile")
    public void uploadFile(@RequestParam("upload") MultipartFile multipartFile,HttpServletRequest request,HttpServletResponse response){
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("X-Frame-Options", "SAMEORIGIN");
        String CKEditorFuncNum = request.getParameter("CKEditorFuncNum");
        Date d = new Date();
        String uploadPath = rootPath + "/flower/editor/";
        String downloadPath = resUrl + "/flower/editor/";
        File f = new File(uploadPath);
        if(!f.exists()){
        	f.mkdirs();
        }
        
        try {
        	PrintWriter out = null;
        	 
            String fileName= multipartFile.getOriginalFilename();
            String newName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("."));
    		String uploadContentType = multipartFile.getContentType();
    		String expandedName ="";
    		if (uploadContentType.equals("image/pjpeg")|| uploadContentType.equals("image/jpeg")) {  
                // IE6上传jpg图片的headimageContentType是image/pjpeg，而IE9以及火狐上传的jpg图片是image/jpeg  
                expandedName = ".jpg";  
            } else if (uploadContentType.equals("image/png") || uploadContentType.equals("image/x-png")) {  
                // IE6上传的png图片的headimageContentType是"image/x-png"  
                expandedName = ".png";  
            } else if (uploadContentType.equals("image/gif")) {  
                expandedName = ".gif";  
            } else if (uploadContentType.equals("image/bmp")) {  
                expandedName = ".bmp";  
            } else {  
                out.println("<script type=\"text/javascript\">");  
                out.println("window.parent.CKEDITOR.tools.callFunction(" + CKEditorFuncNum + ",''," + "'文件格式不正确（必须为.jpg/.gif/.bmp/.png文件）');");  
                out.println("</script>");  
                return ;  
            }  
    		
    		multipartFile.transferTo(new File(uploadPath +newName));
    		
    		out = response.getWriter();
    		out.println("<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction("+CKEditorFuncNum+", '"+downloadPath + newName +"','')</script>");  
    		out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }  
    }
}
