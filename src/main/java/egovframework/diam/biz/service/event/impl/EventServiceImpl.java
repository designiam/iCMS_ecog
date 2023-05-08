package egovframework.diam.biz.service.event.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.diam.biz.db.event.EventMapper;
import egovframework.diam.biz.model.event.Dm_event_vo;
import egovframework.diam.biz.service.event.EventService;
import egovframework.diam.cmm.util.MessageCode;
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

	@Override
	public int upsertEvent(Dm_event_vo vo) throws Exception {
		return eventMapper.upsertEvent(vo);
	}

	@Override
	public Dm_event_vo selectEvent(Dm_event_vo vo) throws Exception {
		return eventMapper.selectEvent(vo);
	}

	@Override
	@Transactional
	public void deleteEvent(List<Dm_event_vo> list) throws Exception {
		if (list.size() > 0) {
			list.forEach(item -> {
				if (eventMapper.deleteEvent(item) < 1) throw new RuntimeException(MessageCode.CMM_TRANSACTION_FAIL.getLog());
			});
		}
	}
}
