package egovframework.diam.biz.db.main;

import java.util.List;

import egovframework.diam.biz.model.main.Dm_cover_vo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CoverMapper {
	
	public List<Dm_cover_vo> selectCoverList(Dm_cover_vo vo);
	
	public int selectCoverListCount(Dm_cover_vo vo);
	
	public int upsertCover(Dm_cover_vo vo);
	
	public Dm_cover_vo selectUseStatusCover(Dm_cover_vo vo);
	
	public int updateCoverStatus(Dm_cover_vo vo);
	
	public Dm_cover_vo selectCover(Dm_cover_vo vo);
	
	public int selectUniqVol(Dm_cover_vo vo);
	
	public int deleteCover(Dm_cover_vo vo);
}
