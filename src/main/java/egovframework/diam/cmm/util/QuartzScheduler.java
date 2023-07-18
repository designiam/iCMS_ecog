package egovframework.diam.cmm.util;

import java.util.List;

import org.apache.logging.log4j.message.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import egovframework.diam.biz.model.event.Dm_event_vo;
import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.biz.service.event.EventService;
import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class QuartzScheduler  {
	
	
	@Autowired
	private WriteService writeService;
	
	@Autowired
	private EventService eventService;
	
	@Scheduled(cron="0 10 9 1 * *")
	public void resetNewHitCount() {
		
		try {
			writeService.updateNewHitCountReset();
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}
	
	@Scheduled(cron="0 10 0 * * *")
	public void eventStatusChange() {
		try {
			List<Dm_event_vo> soonList = eventService.selectTargetEvent(Dm_event_vo.builder().command("start").build());
			List<Dm_event_vo> ingList = eventService.selectTargetEvent(Dm_event_vo.builder().command("end").build());
			
			if (soonList.size() > 0) {
				soonList.forEach(item -> {
					item.setDm_status("1");
				});
			}
			if (ingList.size() > 0) {
				ingList.forEach(item -> {
					item.setDm_status("3");
				});
			}
			soonList.addAll(ingList);
			if (soonList.size() > 0) {
				eventService.updateEventStatus(soonList);				
			}
			
		} catch (DataAccessException e) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
		} catch (RuntimeException e) {
			log.error(MessageCode.CMM_TRANSACTION_FAIL.getLog());
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}
	
}
