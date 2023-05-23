package egovframework.diam.biz.db.main;

import java.util.List;

import egovframework.diam.biz.model.main.Dm_subscribe_vo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SubscribeMapper {
	
	public int selectSubsListCount(Dm_subscribe_vo vo);
	
	public List<Dm_subscribe_vo> selectSubsList(Dm_subscribe_vo vo);

	public int deleteSubscribe(Dm_subscribe_vo vo);
	
	public Dm_subscribe_vo selectByPk(Dm_subscribe_vo vo);
	
	public Dm_subscribe_vo selectByEmail(Dm_subscribe_vo vo);
	
	public int insertSubscribe(Dm_subscribe_vo vo);
}
