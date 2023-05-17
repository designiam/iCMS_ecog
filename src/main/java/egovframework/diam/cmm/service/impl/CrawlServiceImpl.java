package egovframework.diam.cmm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.diam.cmm.db.CrawlMapper;
import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.diam.cmm.service.CrawlService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.MessageCode;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("crawlService")
public class CrawlServiceImpl extends EgovAbstractServiceImpl implements CrawlService {
	
	@Autowired private CrawlMapper crawlMapper;

	@Override
	@Transactional
	public int insertCrawlResult(List<Dm_crawl_vo> list, String path) throws Exception {
		int result = 0;
		CommonUtil commonUtil = new CommonUtil();
		if (list.size() > 0) {
			for (Dm_crawl_vo item : list) {
				Dm_crawl_vo vo = crawlMapper.selectDupCrawlResult(item);
				if (vo == null) {
					if (item.getDm_type().equals("1") && !commonUtil.isNullOrEmpty(path)) {
						String newName = commonUtil.downloadImage(item.getDm_src(), path);
						item.setDm_src("/resources/crawl/"+newName);
					}
					
					int subResult = crawlMapper.insertCrawlResult(item);
					
					if (subResult < 1) {
						throw new RuntimeException(MessageCode.CMM_TRANSACTION_FAIL.getLog());
					} else {
						result ++;
					}
				}
			}
		}
		return result;
	}

	@Override
	public List<Dm_crawl_vo> selectCrawlData(Dm_crawl_vo vo) throws Exception {
		return crawlMapper.selectCrawlData(vo);
	}

	@Override
	public int selectCrawlListCount(Dm_crawl_vo vo) throws Exception {
		return crawlMapper.selectCrawlListCount(vo);
	}

	@Override
	public List<Dm_crawl_vo> selectCrawlList(Dm_crawl_vo vo) throws Exception {
		return crawlMapper.selectCrawlList(vo);
	}

	@Override
	public Dm_crawl_vo selectByPK(Dm_crawl_vo vo) throws Exception {
		return crawlMapper.selectByPK(vo);
	}

	@Override
	public int updateCrawlStatus(Dm_crawl_vo vo) throws Exception {
		return crawlMapper.updateCrawlStatus(vo);
	}
}
