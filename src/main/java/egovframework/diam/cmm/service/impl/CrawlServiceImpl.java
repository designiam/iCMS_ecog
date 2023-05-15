package egovframework.diam.cmm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.diam.cmm.db.CrawlMapper;
import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.diam.cmm.service.CrawlService;
import egovframework.diam.cmm.util.MessageCode;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("crawlService")
public class CrawlServiceImpl extends EgovAbstractServiceImpl implements CrawlService {
	
	@Autowired private CrawlMapper crawlMapper;

	@Override
	@Transactional
	public void insertCrawlResult(List<Dm_crawl_vo> list) throws Exception {
		if (list.size() > 0) {
			list.forEach(item -> {
				Dm_crawl_vo vo = crawlMapper.selectDupCrawlResult(item);
				if (vo == null) {
					if (crawlMapper.insertCrawlResult(item) < 1) {
						throw new RuntimeException(MessageCode.CMM_TRANSACTION_FAIL.getLog());
					}
				}
			});
		}		
	}
}
