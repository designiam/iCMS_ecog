package egovframework.diam.biz.db.file;

import java.util.List;

import egovframework.diam.biz.model.file.Dm_file_vo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("fileMapper")
public interface FileMapper {

	public List<Dm_file_vo> selectFileList(Dm_file_vo vo);
	
	public int selectfileListCount(Dm_file_vo vo);
	
	public int createFile(Dm_file_vo vo);
	
	public Dm_file_vo selectFile(Dm_file_vo vo);
}
