package ants.com.file.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.file.mapper.FileMapper;
import ants.com.file.model.PrivateFileVo;
import ants.com.file.model.PublicFileVo;

@Service("fileService")
public class FileService{
	
	@Resource(name="fileMapper")
	private FileMapper mapper;
	
	// 해당 파일 가져오기
	public PublicFileVo getfile(String pubId) {
		return mapper.getfileDetail(pubId);
	}
	
	// 파일 넣기
	public String insertFile(PublicFileVo filevo) {
		mapper.insertfile(filevo);
		System.out.println("id : " +filevo.getPubId());
		return filevo.getPubId();
	}
	
	// 해당 게시글 파일들 가져오기
	public List<PublicFileVo> filelist(PublicFileVo pfv){
		return mapper.getfiles(pfv);
	}
	
	// 파일 삭제하기
	public int defiles(String pubId){
		return mapper.delfiles(pubId);
	}
	
	
	/*			개	인	파	일	함				*/
	
	// 개인파일 목록
	public List<PrivateFileVo> privatefileList(PrivateFileVo privatefileVo){
		return mapper.privatefileList(privatefileVo);
	}
	
	// 파일 갯수
	public int privatefilelistCount(PrivateFileVo privatefileVo) {
		return mapper.privatefilelistCount(privatefileVo);
	}
	
	// 파일 등록
	public int privateInsert(List<PrivateFileVo> list) {
		return mapper.privateInsert(list);
	}
	
	// 파일 삭제하기
	public int privateDelete(PrivateFileVo privatefileVo){
		return mapper.privateDelete(privatefileVo);
	}
	
	// 해당 파일 가져오기
	public PrivateFileVo privateSelect(PrivateFileVo privatefileVo) {
		return mapper.privateSelect(privatefileVo);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
