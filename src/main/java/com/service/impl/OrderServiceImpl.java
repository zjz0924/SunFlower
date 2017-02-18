package com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.dao.OrderDao;
import com.domain.IncomeStatistic;
import com.domain.Order;
import com.domain.Statistic;
import com.page.PageHelperExt;
import com.service.OrderService;

@Service
@Transactional
public class OrderServiceImpl implements OrderService{

	private static Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);

	@Autowired
	private OrderDao orderDao;
	
	public Order selectOne(Long id) {
		return orderDao.selectOne(id);
	}

	public List<Order> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return orderDao.selectAllList(map);
	}
	
	public int save(Order Order) {
		return orderDao.insert(Order);
	}

	public int update(Order Order) {
		return orderDao.update(Order);
	}

	public int deleteByPrimaryKey(Long id) {
		return orderDao.deleteByPrimaryKey(id);
	}

	public List<Long> getHotSale(){
		return orderDao.getHotSale();
	}
	
	public List<IncomeStatistic> businessAnalysis(Map<String, Object> map){
		PageHelperExt.startPage(map);
		return orderDao.businessAnalysis(map);
	}
	
	public Statistic statistic(Map<String, Object> map){
		return orderDao.statistic(map);
	}
}





