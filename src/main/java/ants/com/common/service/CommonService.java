package ants.com.common.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.common.mapper.CommonMapper;

@Service("commonService")
public class CommonService{
	@Resource(name="commonMapper")
	private CommonMapper mapper;
}
