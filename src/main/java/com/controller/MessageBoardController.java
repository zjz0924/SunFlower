package com.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.domain.MessageBoard;
import com.page.PageMap;
import com.service.MessageBoardService;
import com.utils.Contants;
import com.vo.AjaxVO;

/**
 * 留言板控制器
 * @author zhenjunzhuo
 * 2016-11-14
 */
@Controller
@RequestMapping(value = "messageBoardController")
public class MessageBoardController {
	
	@Autowired
	private MessageBoardService messageBoardService;
	
	
	/**
	 * 列表
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String name, String phone, String wechat, String startCreateTime, String endCreateTime){
		Map<String, Object> map = new PageMap(request);
		map.put("isDelete", "N");
		
		if(StringUtils.isNotBlank(name)){
			map.put("name", name);
		}
		if(StringUtils.isNotBlank(wechat)){
			map.put("wechat", wechat);
		}
		if(StringUtils.isNotBlank(phone)){
			map.put("phone", phone);
		}
		if(StringUtils.isNotBlank(startCreateTime)){
			map.put("startCreateTime", startCreateTime + " 00:00:00");
		}
		if(StringUtils.isNotBlank(endCreateTime)){
			map.put("endCreateTime", endCreateTime + " 23:59:59");
		}
		map.put("custom_order_sql", "create_time desc");
		
		List<MessageBoard> dataList = messageBoardService.selectAllList(map);
		
		model.addAttribute("name", name);
		model.addAttribute("phone", phone);
		model.addAttribute("wechat", wechat);
		model.addAttribute("startCreateTime", startCreateTime);
		model.addAttribute("endCreateTime", endCreateTime);
		model.addAttribute("dataList", dataList);
		return "backend/messageboard/messageboard_list";
	}
	
	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id){
		
		if(StringUtils.isNotBlank(id)){
			MessageBoard messageBoard = messageBoardService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", messageBoard);
		}
		
		String mode = request.getParameter("mode");
		model.addAttribute("mode", mode);
		return "backend/messageboard/messageboard_detail";
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
			MessageBoard messageBoard = messageBoardService.selectOne(Long.parseLong(id));
			
			if(messageBoard != null){
				messageBoard.setIsDelete("Y");
				messageBoardService.update(messageBoard);
				
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
