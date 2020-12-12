package ants.com.common.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.common.mapper.AlarmMapper;
import ants.com.common.model.AlarmVo;
import ants.com.member.model.MemberVo;

@Service("alarmService")
public class AlarmService {

	@Resource(name = "alarmMapper")
	private AlarmMapper alarmMapper;

	public int alarmInsert(AlarmVo alarmData) {
		return alarmMapper.alarmInsert(alarmData);
	}

	public AlarmVo alarmCount(AlarmVo alarmVo) {
		return alarmMapper.alarmCount(alarmVo);
	}

	public List<?> alarmList(AlarmVo alarmVo) {
		return alarmMapper.alarmList(alarmVo);
	}

	public int alarmListCount(AlarmVo alarmVo) {
		return alarmMapper.alarmListCount(alarmVo);
	}

	public int alarmUpdate(AlarmVo alarmVo) {
		return alarmMapper.alarmUpdate(alarmVo);
	}

	public int alarmDelete(ArrayList<String> deleteData) {
		return alarmMapper.alarmDelete(deleteData);
	}
}
