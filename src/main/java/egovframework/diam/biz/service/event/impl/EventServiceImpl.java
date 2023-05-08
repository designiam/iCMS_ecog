package egovframework.diam.biz.service.event.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.diam.biz.db.event.EventMapper;
import egovframework.diam.biz.model.event.Dm_event_vo;
import egovframework.diam.biz.service.event.EventService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("eventServiceImpl")
public class EventServiceImpl extends EgovAbstractServiceImpl implements EventService{

	@Autowired private EventMapper eventMapper;

	@Override
	public List<Dm_event_vo> selectEventList(Dm_event_vo vo) throws Exception {
		return eventMapper.selectEventList(vo);
	}

	@Override
	public int selectEventCount(Dm_event_vo vo) throws Exception {
		return eventMapper.selectEventCount(vo);
	}
}
