package egovframework.diam.biz.service.file;

import java.util.List;

import egovframework.diam.biz.model.file.Dm_file_vo;

public interface FileService {

	public List<Dm_file_vo> selectFileList(Dm_file_vo vo) throws Exception;
	
	public int selectfileListCount(Dm_file_vo vo) throws Exception;
	
	public int createFile(Dm_file_vo vo) throws Exception;
	
	public Dm_file_vo selectFile(Dm_file_vo vo) throws Exception;
}
