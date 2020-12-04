package ants.com.file.mapper;

import java.util.List;

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
	
	
	/*			개	인	파	일	함				*/
	
	// 개인파일 목록
	public List<PrivateFileVo> privatefileList(PrivateFileVo privatefileVo);
	
	public int privatefilelistCount(PrivateFileVo privatefileVo);
	
	public int privateInsert(List<PrivateFileVo> list);
}
