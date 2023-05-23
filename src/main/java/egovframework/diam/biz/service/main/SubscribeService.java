package egovframework.diam.biz.service.main;

import java.util.List;

import egovframework.diam.biz.model.main.Dm_subscribe_vo;

public interface SubscribeService {

	public int selectSubsListCount(Dm_subscribe_vo vo) throws Exception;
	
	public List<Dm_subscribe_vo> selectSubsList(Dm_subscribe_vo vo) throws Exception;
	
	public int deleteSubscribe(Dm_subscribe_vo vo) throws Exception;
	
	public Dm_subscribe_vo selectByPk(Dm_subscribe_vo vo) throws Exception;
	
	public Dm_subscribe_vo selectByEmail(Dm_subscribe_vo vo) throws Exception;
	
	public int insertSubscribe(Dm_subscribe_vo vo) throws Exception;
}
