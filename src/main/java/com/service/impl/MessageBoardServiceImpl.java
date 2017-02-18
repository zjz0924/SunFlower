package com.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.dao.MessageBoardDao;
import com.domain.MessageBoard;
import com.page.PageHelperExt;
import com.service.MessageBoardService;

@Service
@Transactional
public class MessageBoardServiceImpl implements MessageBoardService{

	private static Logger logger = LoggerFactory.getLogger(MessageBoardServiceImpl.class);

	@Autowired
	private MessageBoardDao messageBoardDao;
	
	public MessageBoard selectOne(Long id) {
		return messageBoardDao.selectOne(id);
	}

	public List<MessageBoard> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return messageBoardDao.selectAllList(map);
	}
	
	public int save(MessageBoard MessageBoard) {
		return messageBoardDao.insert(MessageBoard);
	}

	public int update(MessageBoard MessageBoard) {
		return messageBoardDao.update(MessageBoard);
	}

	public int deleteByPrimaryKey(Long id) {
		return messageBoardDao.deleteByPrimaryKey(id);
	}

}





