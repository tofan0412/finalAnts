package ants.com.member.repository;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import ants.com.member.model.MemberVo;

@Repository("memberDao")
public class MemberDao implements MemberDaoI{
	private static final Logger logger = LoggerFactory.getLogger(MemberDao.class);
	
	@Resource(name="SqlSessionTemplate")
	SqlSessionTemplate sqlSession;
	
	@Override
	public MemberVo getMember(String mem_id) {
		logger.debug("MemberDao login : {}", mem_id);
		MemberVo memberVo = sqlSession.selectOne("member.getMember", mem_id);
		logger.debug("MemberDao memberVo : {}", memberVo);
		
		return memberVo;
	}

}
