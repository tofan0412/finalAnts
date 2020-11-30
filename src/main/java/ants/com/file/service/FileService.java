package ants.com.file.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import ants.com.file.mapper.FileMapper;

@Service("fileService")
public class FileService{
	@Resource(name="fileMapper")
	private FileMapper mapper;

}
