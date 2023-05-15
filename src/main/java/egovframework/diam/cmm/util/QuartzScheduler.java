package egovframework.diam.cmm.util;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.openqa.selenium.NoSuchElementException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.diam.cmm.selenium.CrawlingUtil;
import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class QuartzScheduler {
	
	@Autowired
	private WriteService writeService;
	
	@Scheduled(cron="0 0 9 1 * *")
	public void resetNewHitCount() {
		
		log.error("조회수 스케쥴러 실행..");
		
		try {
			writeService.updateNewHitCountReset();
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}
	
	
	//@Scheduled(cron="0 9 * * * *")
	public void crawlInsta() {
		
		try {
			CrawlingUtil util = new CrawlingUtil();
			List<Dm_crawl_vo> tt = util.crawlInstagram();
			tt.forEach(item -> {
				log.error(item.toString());
			});
		} catch (IOException ioe) {
			log.error(MessageCode.CMM_FILE_ERROR.getLog());
		} catch (NoSuchElementException nee) {
			log.error("crawling error");
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}

}
