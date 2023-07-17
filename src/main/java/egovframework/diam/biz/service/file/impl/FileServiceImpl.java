package egovframework.diam.biz.service.file.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.diam.biz.db.file.FileMapper;
import egovframework.diam.biz.model.file.Dm_file_vo;
import egovframework.diam.biz.service.file.FileService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("fileService")
public class FileServiceImpl extends EgovAbstractServiceImpl implements FileService {

	@Autowired
	private FileMapper fileMapper;
	
	@Override
	public List<Dm_file_vo> selectFileList(Dm_file_vo vo) throws Exception {
		return fileMapper.selectFileList(vo);
	}

	@Override
	public int selectfileListCount(Dm_file_vo vo) throws Exception {
		return fileMapper.selectfileListCount(vo);
	}

	@Override
	public int createFile(Dm_file_vo vo) throws Exception {
		return fileMapper.createFile(vo);
	}

	@Override
	public Dm_file_vo selectFile(Dm_file_vo vo) throws Exception {
		return fileMapper.selectFile(vo);
	}

}
