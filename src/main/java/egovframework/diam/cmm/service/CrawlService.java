package egovframework.diam.cmm.service;

import java.util.List;

import egovframework.diam.cmm.model.Dm_crawl_vo;

public interface CrawlService {
	
	public int insertCrawlResult(List<Dm_crawl_vo> list, String path) throws Exception;

	public List<Dm_crawl_vo> selectCrawlData(Dm_crawl_vo vo) throws Exception;
	
	public int selectCrawlListCount(Dm_crawl_vo vo) throws Exception;
	
	public List<Dm_crawl_vo> selectCrawlList(Dm_crawl_vo vo) throws Exception;
	
	public Dm_crawl_vo selectByPK(Dm_crawl_vo vo) throws Exception;
	
	public int updateCrawlStatus(Dm_crawl_vo vo) throws Exception;
}
