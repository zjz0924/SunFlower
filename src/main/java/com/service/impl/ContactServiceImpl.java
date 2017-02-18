package com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ContactDao;
import com.domain.Contact;
import com.page.PageHelperExt;
import com.service.ContactService;

@Service
@Transactional
public class ContactServiceImpl implements ContactService{

	private static Logger logger = LoggerFactory.getLogger(ContactServiceImpl.class);

	@Autowired
	private ContactDao contactDao;
	
	public Contact selectOne(Long id) {
		return contactDao.selectOne(id);
	}

	public int save(Contact Contact) {
		return contactDao.insert(Contact);
	}

	public int update(Contact Contact) {
		return contactDao.update(Contact);
	}

	public int deleteByPrimaryKey(Long id) {
		return contactDao.deleteByPrimaryKey(id);
	}

	public List<Contact> selectAllList(Map<String, Object> map) {
		PageHelperExt.startPage(map);
		return contactDao.selectAllList(map);
	}
}





