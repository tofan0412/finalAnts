package ants.com.file.mapper;

import java.util.List;

import ants.com.file.model.HotIssueFileVo;
import ants.com.file.model.PrivateFileVo;
import ants.com.file.model.PublicFileVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("fileMapper")
public interface FileMapper {
	
	// 해당 파일 가져오기
	public PublicFileVo getfileDetail(String pubId);
	
	// 파일 넣기
	public int insertfile(PublicFileVo filevo);
	
	// 해당 게시글 파일 가져오기
	public List<PublicFileVo> getfiles(PublicFileVo pfv);
	
	// 파일 삭제하기
	public int delfiles(String pubId);
	
	// 프로젝트별 파일 수
	public int pubfilePagingListCnt(PublicFileVo publicFileVo);
	
	// 프로젝트별 파일목록
	public List<PublicFileVo> pubfilelist(PublicFileVo publicFileVo);
	
	// 파일 이름 변경
	public int modfilename(PrivateFileVo privateFileVo);
	
	
	/*			개	인	파	일	함				*/
	
	// 개인파일 목록
	public List<PrivateFileVo> privatefileList(PrivateFileVo privatefileVo);
	
	// 파일 갯수
	public int privatefilelistCount(PrivateFileVo privatefileVo);

	// 해당 사용자 개인파일함 총 용량
	public String privatefiletotalSize(PrivateFileVo privatefilevo);
	
	// 파일등록
	public int privateInsert(List<PrivateFileVo> list);
	
	// 파일 삭제하기
	public int privateDelete(PrivateFileVo privatefileVo);
	
	// 해당 파일 가져오기
	public PrivateFileVo privateSelect(PrivateFileVo privatefileVo);
	
	
	/*			PL-PM	파	일	함				*/
	// 파일저장
	public int insertHotissueFile(HotIssueFileVo hotIssueFileVo);
	
	// 해당 게시글 파일 가져오기
	public List<HotIssueFileVo> gethotfiles(HotIssueFileVo pfv);
	
	// 해당 파일 가져오기
	public HotIssueFileVo gethotfile(String hissuefId);
	
	// 파일 삭제하기
	public int delhotfiles(String hissuefId);

	// 파일 목록가져오기
	public List<HotIssueFileVo> hotissuefileList(HotIssueFileVo pfv);

	// 파일 수
	public int hotissuefilePagingListCnt (String reqId);
}


