package ants.com.admin.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.admin.mapper.AdminMapper;

@Service("adminService")
public class AdminService {
	@Resource(name="adminMapper")
	private AdminMapper mapper;
	
}
