package egovframework.diam.cmm.service;

import java.util.List;

import egovframework.diam.cmm.model.Dm_crawl_vo;

public interface CrawlService {
	
	public void insertCrawlResult(List<Dm_crawl_vo> list) throws Exception;

}
