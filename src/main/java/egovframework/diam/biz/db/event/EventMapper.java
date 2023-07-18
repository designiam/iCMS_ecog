package egovframework.diam.biz.db.event;

import java.util.List;

import egovframework.diam.biz.model.event.Dm_event_vo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface EventMapper {
	
	public List<Dm_event_vo> selectEventList(Dm_event_vo vo);
	
	public int selectEventCount(Dm_event_vo vo);
	
	public int upsertEvent(Dm_event_vo vo);
	
	public Dm_event_vo selectEvent(Dm_event_vo vo);
	
	public int deleteEvent(Dm_event_vo vo);
	
	public List<Dm_event_vo> selectTargetEvent(Dm_event_vo vo);
	
	public int updateEventStatus(Dm_event_vo vo);

}
