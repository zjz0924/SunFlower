package com.controller;

import java.util.ArrayList;
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

import com.domain.Contact;
import com.domain.Flower;
import com.domain.MessageBoard;
import com.domain.ScrollPic;
import com.page.PageMap;
import com.service.ContactService;
import com.service.FlowerService;
import com.service.MessageBoardService;
import com.service.OrderService;
import com.service.ScrollPicService;
import com.vo.AjaxVO;

/**
 * 公众号控制器
 * @author zhenjunzhuo
 * 2016-10-31
 */
@Controller
@RequestMapping(value = "wechatController")
public class WechatController {
	
	@Autowired
	private ScrollPicService scrollPicService;
	@Autowired
	private FlowerService flowerService;
	@Autowired
	private ContactService contactService;
	@Autowired
	private MessageBoardService messageBoardService;
	@Autowired
	private OrderService orderService;
	
	@Value("${res.url.root}")
	private String resUrl;
	
	/**
	 * 首页
	 */
	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model){
		return "wechat/index";
	}
	
	
	/**
	 * 首页
	 */
	@RequestMapping(value = "/indexContent")
	public String indexContent(HttpServletRequest request, Model model){
		// 滚动大图
		Map<String, Object> scrollPicMap = new PageMap(0, 5);
		scrollPicMap.put("isDelete", "N");
		scrollPicMap.put("custom_order_sql", "sort_num desc");
		List<ScrollPic> scrollPickList = scrollPicService.selectAllList(scrollPicMap);
		
		// 花类
		Map<String, Object> flowerMap = new PageMap(0, 5);
		flowerMap.put("isDelete", "N");
		flowerMap.put("isDisplay", "Y");
		flowerMap.put("custom_order_sql", "create_time desc");
		List<Flower> flowerList = flowerService.selectAllList(flowerMap);
		
		//销量榜
		Map<String, Object> saleFlowerMap = new PageMap(0, 5);
		saleFlowerMap.put("isDelete", "N");
		saleFlowerMap.put("isDisplay", "Y");
		
		List<Long> flowerIdList = orderService.getHotSale();
		if(flowerIdList == null || flowerIdList.size() < 1){
			flowerIdList.add(-1l);
		}
		saleFlowerMap.put("idList", flowerIdList);
		saleFlowerMap.put("custom_order_sql", "create_time desc");
		List<Flower> saleFlowerList = flowerService.selectAllList(saleFlowerMap);
		
		model.addAttribute("scrollPickList", scrollPickList);
		model.addAttribute("saleFlowerList", saleFlowerList);
		model.addAttribute("resUrl", resUrl);
		model.addAttribute("flowerList", flowerList);
		
		return "wechat/index_content";
	}
	
	
	/**
	 * 联系方式
	 */
	@RequestMapping(value = "/contant")
	public String contant(HttpServletRequest request, Model model){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Contact> contactList = contactService.selectAllList(map);
		
		if(contactList != null && contactList.size() > 0){
			model.addAttribute("contact", contactList.get(0));
		}
		
		model.addAttribute("resUrl", resUrl);
		return "wechat/contact";
	}

	
	/**
	 * 产品列表
	 * type: 1- 热销， 2-产品列表
	 */
	@RequestMapping(value = "/flowerList")
	public String flowerList(HttpServletRequest request, Model model){
		List<Flower> flowerList = new ArrayList<Flower>();
		
		Map<String, Object> flowerMap = new PageMap(request);
		flowerMap.put("isDelete", "N");
		flowerMap.put("isDisplay", "Y");
		flowerMap.put("custom_order_sql", "create_time desc");
		
		flowerList = flowerService.selectAllList(flowerMap);
		
		model.addAttribute("dataList", flowerList);
		model.addAttribute("resUrl", resUrl);
		return "wechat/flower_list";
	}
	
	
	/**
	 * 热销推荐
	 */
	@RequestMapping(value = "/hotSaleList")
	public String hotSaleList(HttpServletRequest request, Model model, String type){
		List<Flower> flowerList = new ArrayList<Flower>();
		
		Map<String, Object> flowerMap = new PageMap(request);
		flowerMap.put("isDelete", "N");
		flowerMap.put("isDisplay", "Y");
		
		List<Long> flowerIdList = orderService.getHotSale();
		if(flowerIdList == null || flowerIdList.size() < 1){
			flowerIdList.add(-1l);
		}
		flowerMap.put("idList", flowerIdList);
		flowerMap.put("custom_order_sql", "create_time desc");
		flowerList = flowerService.selectAllList(flowerMap);
		
		model.addAttribute("dataList", flowerList);
		model.addAttribute("resUrl", resUrl);
		return "wechat/hotsale_list";
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
		
		model.addAttribute("resUrl", resUrl);
		return "wechat/flower_detail";
	}
	
	
	/**
	 * 留言
	 */
	@RequestMapping(value = "/messageBoard")
	public String messageBoard(HttpServletRequest request, Model model){
		return "wechat/message_board";
	}
	
	
	/**
	 * 添加留言
	 */
	@RequestMapping(value = "/saveMessage")
	@ResponseBody
	public AjaxVO saveMessage(HttpServletRequest request, Model model, String name, String phone, String content, String wechat) {
		AjaxVO vo = new AjaxVO();
		
		try{
			MessageBoard messageBoard = new MessageBoard();
			messageBoard.setName(name);
			messageBoard.setContent(content);
			messageBoard.setCreateTime(new Date());
			
			if(StringUtils.isNotBlank(phone)){
				messageBoard.setPhone(phone);
			}
			if(StringUtils.isNotBlank(wechat)){
				messageBoard.setWechat(wechat);
			}
			messageBoardService.save(messageBoard);
			
			vo.setSuccess(true);
			vo.setMsg("留言成功");
		}catch(Exception ex){
			ex.printStackTrace();
			
			vo.setSuccess(false);
			vo.setMsg("留言失败，请重试");
		}
		return vo;
	}
}
