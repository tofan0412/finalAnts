package ants.com.common.mapper;

import ants.com.common.model.AlarmVo;
import ants.com.member.model.MemberVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("alarmMapper")
public interface AlarmMapper {

	public int alarmInsert(AlarmVo alarmData);

	public int alarmCount(MemberVo memberVo);
	
}
