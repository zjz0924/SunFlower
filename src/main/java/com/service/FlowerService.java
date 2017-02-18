package com.service;

import java.util.List;
import java.util.Map;
import com.domain.Flower;

public interface FlowerService {

	public Flower selectOne(Long id);
	
	public List<Flower> selectAllList(Map<String, Object> map);
	
	public int save(Flower Flower);
	
	public int update(Flower Flower);
	
	public int deleteByPrimaryKey(Long id);
}
