package com.dao;

import java.util.List;
import java.util.Map;

import com.domain.IncomeStatistic;
import com.domain.Statistic;

public interface OrderDao extends SqlDao{
	
	List<Long> getHotSale();
	
	List<IncomeStatistic> businessAnalysis(Map<String, Object> map);
	
	Statistic statistic(Map<String, Object> map);
}