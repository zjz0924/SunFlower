package com.service;

import java.util.List;
import java.util.Map;
import com.domain.MessageBoard;

public interface MessageBoardService {

	public MessageBoard selectOne(Long id);
	
	public List<MessageBoard> selectAllList(Map<String, Object> map);
	
	public int save(MessageBoard MessageBoard);
	
	public int update(MessageBoard MessageBoard);
	
	public int deleteByPrimaryKey(Long id);
}
