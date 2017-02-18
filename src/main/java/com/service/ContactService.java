package com.service;

import java.util.List;
import java.util.Map;
import com.domain.Contact;

public interface ContactService {

	public Contact selectOne(Long id);
	
	public int save(Contact contact);
	
	public int update(Contact contact);
	
	public int deleteByPrimaryKey(Long id);
	
	public List<Contact> selectAllList(Map<String, Object> map);
}
