package ants.com.common.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.common.mapper.AlarmMapper;

@Service("alarmService")
public class AlarmService {
	
	@Resource(name="alarmMapper")
	private AlarmMapper alarmMapper;
	
	public String alarmMapper() {
		return alarmMapper.alarmCount();
	}
}
