package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.domain.Pay;
import com.page.PageMap;
import com.service.PayService;
import com.utils.Contants;
import com.vo.AjaxVO;

/**
 * 支出控制器
 * @author zhenjunzhuo
 * 2016-11-15
 */
@Controller
@RequestMapping(value = "payController")
public class PayController {
	
	@Autowired
	private PayService payService;
	
	/**
	 * 列表
	 */
	@RequestMapping(value = "/list")
	public String list(HttpServletRequest request, Model model, String startCreateTime, String endCreateTime){
		Map<String, Object> map = new PageMap(request);
		map.put("isDelete", "N");
		
		if(StringUtils.isNotBlank(startCreateTime)){
			map.put("startCreateTime", startCreateTime);
		}
		if(StringUtils.isNotBlank(endCreateTime)){
			map.put("endCreateTime", endCreateTime);
		}
		map.put("custom_order_sql", "date desc");
		
		List<Pay> dataList = payService.selectAllList(map);
		
		model.addAttribute("startCreateTime", startCreateTime);
		model.addAttribute("endCreateTime", endCreateTime);
		model.addAttribute("dataList", dataList);
		return "backend/pay/pay_list";
	}
	
	/**
	 * 详情
	 */
	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest request, Model model, String id){
		
		if(StringUtils.isNotBlank(id)){
			Pay Pay = payService.selectOne(Long.parseLong(id));
			model.addAttribute("facadeBean", Pay);
		}
		
		String mode = request.getParameter("mode");
		model.addAttribute("mode", mode);
		return "backend/pay/pay_detail";
	}
	
	
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, Model model, String content, String price, String date) {
		String resultCode = "";
		String resultMsg = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Pay pay = null;
		
		try{
			pay = new Pay();
			pay.setCreateTime(new Date());
			pay.setContent(content);
			pay.setDate(sdf.parse(date));
			pay.setPrice(Double.parseDouble(price));
			payService.save(pay);

			resultCode = Contants.SAVE_SUCCESS;
			resultMsg = Contants.SAVE_SUCCESS_MSG;
		}catch(Exception ex){
			ex.printStackTrace();
			resultCode = Contants.EXCEPTION;
			resultMsg = Contants.EXCEPTION_MSG;
		}
		
		model.addAttribute("resultCode",  resultCode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("facadeBean", pay);
		return "backend/pay/pay_detail";
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
			Pay pay = payService.selectOne(Long.parseLong(id));
			
			if(pay != null){
				pay.setIsDelete("Y");
				pay.setDeleteTime(new Date());
				payService.update(pay);
				
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
