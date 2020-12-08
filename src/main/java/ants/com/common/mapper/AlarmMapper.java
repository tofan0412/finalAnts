package ants.com.common.mapper;

import java.util.List;

import ants.com.common.model.AlarmVo;
import ants.com.member.model.MemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("alarmMapper")
public interface AlarmMapper {

	public int alarmInsert(AlarmVo alarmData);

	public AlarmVo alarmCount(AlarmVo alarmVo);

	public List<?> alarmList(AlarmVo alarmVo);

	public int alarmListCount(AlarmVo alarmVo);

	public int alarmUpdate(AlarmVo alarmVo);
	
}
