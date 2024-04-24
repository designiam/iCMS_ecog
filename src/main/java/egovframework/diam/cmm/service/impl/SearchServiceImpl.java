package egovframework.diam.cmm.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.diam.biz.model.board.Dm_board_vo;
import egovframework.diam.biz.model.board.Dm_write_vo;
import egovframework.diam.biz.model.display.Dm_pages_vo;
import egovframework.diam.cmm.db.SearchMapper;
import egovframework.diam.cmm.model.Dm_search_vo;
import egovframework.diam.cmm.service.SearchService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("searchService")
public class SearchServiceImpl extends EgovAbstractServiceImpl implements SearchService {
	
	@Resource(name="searchMapper") private SearchMapper searchMapper;

	@Override
	public List<Dm_board_vo> selectBoardList(Dm_pages_vo vo) throws Exception {
		return searchMapper.selectBoardList(vo);
	}

	@Override
	public List<Dm_write_vo> selectWriteList(Dm_board_vo vo) throws Exception {
		return searchMapper.selectWriteList(vo);
	}

	@Override
	public int selectWriteListCnt(Dm_board_vo vo) throws Exception {
		return searchMapper.selectWriteListCnt(vo);
	}
	
	@Override
	public int selectSearchWordCount(Dm_search_vo vo) throws Exception {
		return searchMapper.selectSearchWordCount(vo);
	}
	
	@Override
	public int insertSearchWord(Dm_search_vo vo) throws Exception{
		return searchMapper.insertSearchWord(vo);
	}

	@Override
	public int updateSearchWordCount(Dm_search_vo vo) throws Exception{
		return searchMapper.updateSearchWordCount(vo);
	}

	@Override
	public List<Dm_search_vo> selectPopularWord(Dm_search_vo vo) throws Exception{
		return searchMapper.selectPopularWord(vo);
	}
}
