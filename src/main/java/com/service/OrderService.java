package com.service;

import java.util.List;
import java.util.Map;

import com.domain.IncomeStatistic;
import com.domain.Order;
import com.domain.Statistic;

public interface OrderService {

	public Order selectOne(Long id);
	
	public List<Order> selectAllList(Map<String, Object> map);
	
	public int save(Order Order);
	
	public int update(Order Order);
	
	public int deleteByPrimaryKey(Long id);
	
	public List<Long> getHotSale();
	
	/**
	 * 收入统计
	 */
	List<IncomeStatistic> businessAnalysis(Map<String, Object> map);
	
	/**
	 * 统计
	 */
	Statistic statistic(Map<String, Object> map);
}
