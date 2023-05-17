package egovframework.diam.cmm.db;

import java.util.List;

import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CrawlMapper {

	public int insertCrawlResult(Dm_crawl_vo vo);
	
	public Dm_crawl_vo selectDupCrawlResult(Dm_crawl_vo vo);
	
	public List<Dm_crawl_vo> selectCrawlData(Dm_crawl_vo vo);
	
	public int selectCrawlListCount(Dm_crawl_vo vo);
	
	public List<Dm_crawl_vo> selectCrawlList(Dm_crawl_vo vo);
	
	public Dm_crawl_vo selectByPK(Dm_crawl_vo vo);
	
	public int updateCrawlStatus(Dm_crawl_vo vo);
}
