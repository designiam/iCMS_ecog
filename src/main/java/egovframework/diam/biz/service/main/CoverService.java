package egovframework.diam.biz.service.main;

import java.util.List;

import egovframework.diam.biz.model.main.Dm_cover_vo;

public interface CoverService {
	
	public List<Dm_cover_vo> selectCoverList(Dm_cover_vo vo) throws Exception;
	
	public int selectCoverListCount(Dm_cover_vo vo) throws Exception;
	
	public void upsertCover(Dm_cover_vo vo) throws Exception;

	public Dm_cover_vo selectCover(Dm_cover_vo vo) throws Exception;
	
	public Dm_cover_vo selectUseCover(Dm_cover_vo vo) throws Exception;
	
	public int selectUniqVol(Dm_cover_vo vo) throws Exception;
	
	public void deleteCover(List<Dm_cover_vo> list) throws Exception;
	
	public Dm_cover_vo selectCoverByVol(Dm_cover_vo vo) throws Exception;
	
	public List<Dm_cover_vo> selectCoverCombobox() throws Exception;
}
