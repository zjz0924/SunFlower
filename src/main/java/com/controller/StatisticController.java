package com.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.domain.IncomeStatistic;
import com.domain.Statistic;
import com.page.PageMap;
import com.service.OrderService;

/**
 * 经营分析控制器
 * @author zhenjunzhuo
 * 2016-11-15
 */
@Controller
@RequestMapping(value = "statisticController")
public class StatisticController {

	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "/businessAnalysis")
	public String businessAnalysis(HttpServletRequest request, Model model, String startCreateTime, String endCreateTime){
		Map<String, Object> map = new PageMap(request);
		map.put("isDelete", "N");
		
		if(StringUtils.isNotBlank(startCreateTime)){
			map.put("startCreateTime", startCreateTime);
		}
		if(StringUtils.isNotBlank(endCreateTime)){
			map.put("endCreateTime", endCreateTime);
		}
		map.put("custom_order_sql", "date desc");
		
		List<IncomeStatistic> dataList = orderService.businessAnalysis(map);
		
		
		Statistic statistic = orderService.statistic(map);
		if(statistic == null){
			statistic = new Statistic();
		}
		
		model.addAttribute("startCreateTime", startCreateTime);
		model.addAttribute("endCreateTime", endCreateTime);
		model.addAttribute("dataList", dataList);
		model.addAttribute("statistic", statistic);
		return "backend/statistic/businessAnalysis";
	}
}
