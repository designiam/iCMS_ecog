package egovframework.diam.cmm.db;

import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CrawlMapper {

	public int insertCrawlResult(Dm_crawl_vo vo);
	
	public Dm_crawl_vo selectDupCrawlResult(Dm_crawl_vo vo);
}