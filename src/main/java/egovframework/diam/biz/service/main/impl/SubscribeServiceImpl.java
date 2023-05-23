package egovframework.diam.biz.service.main.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.diam.biz.db.main.SubscribeMapper;
import egovframework.diam.biz.model.main.Dm_subscribe_vo;
import egovframework.diam.biz.service.main.SubscribeService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("subscribeService")
public class SubscribeServiceImpl extends EgovAbstractServiceImpl implements SubscribeService {
	
	@Autowired private SubscribeMapper subscribeMapper;

	@Override
	public int selectSubsListCount(Dm_subscribe_vo vo) throws Exception {
		return subscribeMapper.selectSubsListCount(vo);
	}

	@Override
	public List<Dm_subscribe_vo> selectSubsList(Dm_subscribe_vo vo) throws Exception {
		return subscribeMapper.selectSubsList(vo);
	}

	@Override
	public int deleteSubscribe(Dm_subscribe_vo vo) throws Exception {
		return subscribeMapper.deleteSubscribe(vo);
	}

	@Override
	public Dm_subscribe_vo selectByPk(Dm_subscribe_vo vo) throws Exception {
		return subscribeMapper.selectByPk(vo);
	}

	@Override
	public Dm_subscribe_vo selectByEmail(Dm_subscribe_vo vo) throws Exception {
		return subscribeMapper.selectByEmail(vo);
	}

	@Override
	public int insertSubscribe(Dm_subscribe_vo vo) throws Exception {
		return subscribeMapper.insertSubscribe(vo);
	}

}
