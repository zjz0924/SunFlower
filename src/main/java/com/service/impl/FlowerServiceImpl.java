package com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.FlowerDao;
import com.domain.Flower;
import com.page.PageHelperExt;
import com.service.FlowerService;

@Service
@Transactional
public class FlowerServiceImpl implements FlowerService{

	private static Logger logger = LoggerFactory.getLogger(FlowerServiceImpl.class);

	@Autowired
	private FlowerDao flowerDao;
	
	public Flower selectOne(Long id) {
		return flowerDao.selectOne(id);
	}

	public List<Flower> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return flowerDao.selectAllList(map);
	}
	
	public int save(Flower flower) {
		return flowerDao.insert(flower);
	}

	public int update(Flower flower) {
		return flowerDao.update(flower);
	}

	public int deleteByPrimaryKey(Long id) {
		return flowerDao.deleteByPrimaryKey(id);
	}

}





