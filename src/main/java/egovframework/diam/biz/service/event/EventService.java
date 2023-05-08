package egovframework.diam.biz.service.event;

import java.util.List;

import egovframework.diam.biz.model.event.Dm_event_vo;

public interface EventService {
	
	public List<Dm_event_vo> selectEventList(Dm_event_vo vo) throws Exception;
	
	public int selectEventCount(Dm_event_vo vo) throws Exception;

}
