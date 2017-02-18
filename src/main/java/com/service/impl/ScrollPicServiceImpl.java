package com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ScrollPicDao;
import com.domain.ScrollPic;
import com.page.PageHelperExt;
import com.service.ScrollPicService;

@Service
@Transactional
public class ScrollPicServiceImpl implements ScrollPicService{

	private static Logger logger = LoggerFactory.getLogger(ScrollPicServiceImpl.class);

	@Autowired
	private ScrollPicDao scrollPicDao;
	
	public ScrollPic selectOne(Long id) {
		return scrollPicDao.selectOne(id);
	}

	public int save(ScrollPic ScrollPic) {
		return scrollPicDao.insert(ScrollPic);
	}

	public int update(ScrollPic ScrollPic) {
		return scrollPicDao.update(ScrollPic);
	}

	public int deleteByPrimaryKey(Long id) {
		return scrollPicDao.deleteByPrimaryKey(id);
	}

	public List<ScrollPic> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return scrollPicDao.selectAllList(map);
	}
}





