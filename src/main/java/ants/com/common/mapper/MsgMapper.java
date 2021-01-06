package ants.com.common.mapper;

import ants.com.common.model.MsgVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("msgMapper")
public interface MsgMapper {

	public int insertMsg(MsgVo msgVo);
}
