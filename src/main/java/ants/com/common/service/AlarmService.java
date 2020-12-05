package ants.com.common.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.common.mapper.AlarmMapper;
import ants.com.common.model.AlarmVo;
import ants.com.member.model.MemberVo;

@Service("alarmService")
public class AlarmService {
	
	@Resource(name="alarmMapper")
	private AlarmMapper alarmMapper;
	

	public int alarmInsert(AlarmVo alarmData) {
		return alarmMapper.alarmInsert(alarmData);
	}

	public int alarmCount(MemberVo memberVo) {
		return alarmMapper.alarmCount(memberVo);
	}
}
