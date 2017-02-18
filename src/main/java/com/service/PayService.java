package com.service;

import java.util.List;
import java.util.Map;
import com.domain.Pay;

public interface PayService {

	public Pay selectOne(Long id);
	
	public List<Pay> selectAllList(Map<String, Object> map);
	
	public int save(Pay Pay);
	
	public int update(Pay Pay);
	
	public int deleteByPrimaryKey(Long id);
}
