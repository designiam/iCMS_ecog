package egovframework.diam.cmm.util;

import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletContext;

import org.openqa.selenium.NoSuchElementException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.diam.cmm.selenium.CrawlingUtil;
import egovframework.diam.cmm.service.CrawlService;
import lombok.extern.log4j.Log4j2;

@Component
@Log4j2
public class QuartzScheduler implements ServletContextAware {
	
	private String path;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.path = servletContext.getRealPath("/") + "resources/crawl/";
	}
	
	@Autowired
	private WriteService writeService;
	@Autowired
	private CrawlService crawlService;
	
	@Scheduled(cron="0 10 9 1 * *")
	public void resetNewHitCount() {
		
		try {
			writeService.updateNewHitCountReset();
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}
	
	@Scheduled(cron="0 5 9 * * *")
	public void crawlYoutube() {
		try {
			CrawlingUtil util = new CrawlingUtil();
			Dm_crawl_vo vo = util.crawlYoutube();
			if (vo != null) {
				List<Dm_crawl_vo> list = Arrays.asList(vo);
				crawlService.insertCrawlResult(list, null);
			}
		} catch (NoSuchElementException nee) {
			log.error("crawling error");
		} catch (RuntimeException rte) {
			log.error(MessageCode.CMM_TRANSACTION_FAIL.getLog());
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}
	
	@Scheduled(cron="0 0 9 * * *")
	public void crawlInsta() {
		
		try {
			CrawlingUtil util = new CrawlingUtil();
			List<Dm_crawl_vo> tt = util.crawlInstagram();
			if (tt.size() > 0) {
				crawlService.insertCrawlResult(tt, path);
			}
			
		} catch (NoSuchElementException nee) {
			log.error("crawling error");
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
		} catch (RuntimeException rte) {
			log.error(MessageCode.CMM_TRANSACTION_FAIL.getLog());
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
		}
	}

	
}
