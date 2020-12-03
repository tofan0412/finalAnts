package ants.com.file.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.board.memBoard.model.IssueVo;
import ants.com.file.mapper.FileMapper;
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
	public int insertFile(PublicFileVo filevo) {
		return mapper.insertfile(filevo);
	}
	
	// 해당 게시글 파일들 가져오기
	public List<PublicFileVo> filelist(PublicFileVo pfv){
		return mapper.getfiles(pfv);
	}
	
	// 파일 삭제하기
	public int defiles(String pubId){
		return mapper.delfiles(pubId);
	}
	
}
