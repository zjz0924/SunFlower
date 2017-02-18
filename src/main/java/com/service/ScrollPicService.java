package com.service;

import java.util.List;
import java.util.Map;
import com.domain.ScrollPic;

public interface ScrollPicService {

	public ScrollPic selectOne(Long id);
	
	public int save(ScrollPic ScrollPic);
	
	public int update(ScrollPic ScrollPic);
	
	public int deleteByPrimaryKey(Long id);
	
	public List<ScrollPic> selectAllList(Map<String, Object> map);
}
