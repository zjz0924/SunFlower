package com.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.dao.PayDao;
import com.domain.Pay;
import com.page.PageHelperExt;
import com.service.PayService;

@Service
@Transactional
public class PayServiceImpl implements PayService{

	private static Logger logger = LoggerFactory.getLogger(PayServiceImpl.class);

	@Autowired
	private PayDao payDao;
	
	public Pay selectOne(Long id) {
		return payDao.selectOne(id);
	}

	public List<Pay> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return payDao.selectAllList(map);
	}
	
	public int save(Pay Pay) {
		return payDao.insert(Pay);
	}

	public int update(Pay Pay) {
		return payDao.update(Pay);
	}

	public int deleteByPrimaryKey(Long id) {
		return payDao.deleteByPrimaryKey(id);
	}

}





