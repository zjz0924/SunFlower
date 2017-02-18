package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.domain.Flower;
import com.domain.Order;
import com.domain.Pay;
import com.page.PageMap;
import com.service.FlowerService;
import com.service.OrderService;
import com.utils.Contants;
import com.vo.AjaxVO;

/**
 * 订单控制器
 * @author zhenjunzhuo
 * 2016-10-31
 */
@Controller
@RequestMapping(value = "orderController")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
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
	public String list(HttpServletRequest request, Model model, String orderNum, String name, String flowerId, String startCreateTime, String endCreateTime, String wechat, String phone){
		Map<String, Object> map = new PageMap(request);
		map.put("isDelete", "N");
		
		if(StringUtils.isNotBlank(name)){
			map.put("name", name);
		}
		if(StringUtils.isNotBlank(orderNum)){
			map.put("orderNum", orderNum);
		}
		if(StringUtils.isNotBlank(flowerId)){
			map.put("flowerId", flowerId);
		}
		if(StringUtils.isNotBlank(phone)){
			map.put("phone", phone);
		}
		if(StringUtils.isNotBlank(wechat)){
			map.put("wechat", wechat);
		}
		if(StringUtils.isNotBlank(startCreateTime)){
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if(StringUtils.isNotBlank(endCreateTime)){
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		map.put("custom_order_sql", "create_time desc");
		List<Order> dataList = orderService.selectAllList(map);
		
		
		Map<String, Object> flowerMap = new HashMap<String, Object>();
		flowerMap.put("isDelete", "N");
		flowerMap.put("isDisplay", "Y");
		flowerMap.put("custom_order_sql", "name asc");
		List<Flower> flowerList = flowerService.selectAllList(flowerMap);
		
		model.addAttribute("name", name);
		model.addAttribute("phone", phone);
		model.addAttribute("wechat", wechat);
		model.addAttribute("flowerId", flowerId);
		model.addAttribute("startCreateTime", startCreateTime);
		model.addAttribute("endCreateTime", endCreateTime);
		model.addAttribute("orderNum", orderNum);
		model.addAttribute("dataList", dataList);
		model.addAttribute("resUrl", resUrl);
		model.addAttribute("flowerList", flowerList);
		return "backend/order/order_list";
	}
	
	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id){
		
		if(StringUtils.isNotBlank(id)){
			Order Order = orderService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", Order);
		}
		
		String mode = request.getParameter("mode");
		model.addAttribute("mode", mode);
		model.addAttribute("resUrl", resUrl);
		
		Map<String, Object> flowerMap = new HashMap<String, Object>();
		flowerMap.put("isDelete", "N");
		flowerMap.put("isDisplay", "Y");
		flowerMap.put("custom_order_sql", "name asc");
		List<Flower> flowerList = flowerService.selectAllList(flowerMap);
		model.addAttribute("flowerList", flowerList);
		
		return "backend/order/order_detail";
	}
	
	
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Model model, String id, String name, double price, int num,
			 Long flowerId, String wechat, String phone, String address, String remarks) {
		
		String resultCode = "";
		String resultMsg = "";
		Order order = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHssmm");
		Date date = new Date();
		
		try{
			order = new Order();
			order.setName(name);
			order.setPrice(price);
			order.setNum(num);
			order.setAddress(address);
			order.setCreateTime(date);
			order.setFlowerId(flowerId);
			order.setOrderNum(sdf.format(date));
			order.setPhone(phone);
			order.setPrice(price);
			order.setRemarks(remarks);
			order.setWechat(wechat);
			order.setCreateTime(new Date());
			orderService.save(order);

			resultCode = Contants.SAVE_SUCCESS;
			resultMsg = Contants.SAVE_SUCCESS_MSG;
		}catch(Exception ex){
			ex.printStackTrace();
			resultCode = Contants.EXCEPTION;
			resultMsg = Contants.EXCEPTION_MSG;
			
			Map<String, Object> flowerMap = new HashMap<String, Object>();
			flowerMap.put("isDelete", "N");
			flowerMap.put("isDisplay", "Y");
			flowerMap.put("custom_order_sql", "name asc");
			List<Flower> flowerList = flowerService.selectAllList(flowerMap);
			model.addAttribute("flowerList", flowerList);
		}
		
		model.addAttribute("resultCode",  resultCode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("facadeBean", order);
		model.addAttribute("resUrl", resUrl);
		return "backend/order/order_detail";
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
			Order order = orderService.selectOne(Long.parseLong(id));
			
			if(order != null){
				order.setIsDelete("Y");
				order.setDeleteTime(new Date());
				orderService.update(order);
				
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
}
