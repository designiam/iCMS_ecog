package egovframework.diam.cmm.service;

import java.util.List;

import egovframework.diam.biz.model.board.Dm_board_vo;
import egovframework.diam.biz.model.board.Dm_write_vo;
import egovframework.diam.biz.model.display.Dm_pages_vo;
import egovframework.diam.cmm.model.Dm_search_vo;

public interface SearchService {
	
	public List<Dm_board_vo> selectBoardList(Dm_pages_vo vo) throws Exception;
	
	public List<Dm_write_vo> selectWriteList(Dm_board_vo vo) throws Exception;
	
	public int selectWriteListCnt(Dm_board_vo vo) throws Exception;
	
	public int selectSearchWordCount(Dm_search_vo vo) throws Exception;
	
	public int insertSearchWord(Dm_search_vo vo) throws Exception;

	public int updateSearchWordCount(Dm_search_vo vo) throws Exception;
	
	public List<Dm_search_vo> selectPopularWord(Dm_search_vo vo) throws Exception;
}
