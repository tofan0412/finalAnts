package ants.com.common.mapper;

import java.util.List;

import ants.com.common.model.MsgVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("msgMapper")
public interface MsgMapper {

	public int insertMsg(MsgVo msgVo);
	
	public List<MsgVo> msgList(MsgVo msgVo);
}
