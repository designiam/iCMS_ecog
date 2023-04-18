package egovframework.diam.cmm.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import egovframework.diam.biz.service.board.WriteService;
import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class QuartzScheduler {
	
	@Autowired
	private WriteService writeService;
	
	@Scheduled(cron="0 0 9 1 * *")
	public void resetNewHitCount() {
		try {
			writeService.updateNewHitCountReset();
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}

}
