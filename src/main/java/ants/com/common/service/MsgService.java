package ants.com.common.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import ants.com.common.mapper.MsgMapper;
import ants.com.common.model.MsgVo;

@Service("msgService")
public class MsgService {
	@Resource(name="msgMapper")
	private MsgMapper mapper;

	public int insertMsg(MsgVo msgVo) {
		return mapper.insertMsg(msgVo);
	}


}
