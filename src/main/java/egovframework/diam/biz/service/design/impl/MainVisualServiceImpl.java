/**
 * Description Date(Format: 2021/11/16)
 */
package egovframework.diam.biz.service.design.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.diam.biz.db.design.MainVisualMapper;
import egovframework.diam.biz.model.design.Dm_main_visual_vo;
import egovframework.diam.biz.service.design.MainVisualService;
import egovframework.diam.cmm.util.MessageCode;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : MainVisualServiceImpl.java
 * @Description : 사용자페이지 메인페이지에 표출되는 메인비주얼 데이터 CRUD 메소드를 수행하는 Service Interface 구현 클래스
 * @author 디자인아이엠 개발팀 한연재
 * @since 2021.11.16
 * @version 1.0
*/

@Service("mainVisualService")
public class MainVisualServiceImpl extends EgovAbstractServiceImpl implements MainVisualService {
	
	@Resource(name="mainVisualMapper")
	private MainVisualMapper mainVisualMapper;
	
	/**
	 * selectMainVisualList
	 * 검색 값에 따른 메인비주얼 리스트데이터 조회
	 * @param vo 메인비주얼 데이터 검색조건,페이징 값을 vo객체에 담아 전달
	 * @return List<Dm_main_visual_vo> 조회된 메인비주얼 데이터를 List 자료형으로 전달
	*/
	@Override
	public List<Dm_main_visual_vo> selectMainVisualList(Dm_main_visual_vo vo) throws Exception{
		List<Dm_main_visual_vo> result = mainVisualMapper.selectMainVisualList(vo);
		return result;
	}
	
	/**
	 * insertMainVisual
	 * 사용자가 입력한 메인비주얼 데이터 DB에 insert
	 * @param vo 사용자가 입력한 메인비주얼 데이터를 vo객체에 담아 전달
	 * @return void 메인비주얼 데이터 insert 기능만 담당하는 메소드
	*/
	@Override
	public int insertMainVisual(Dm_main_visual_vo vo) throws Exception{
		return mainVisualMapper.insertMainVisual(vo);
	}
	
	/**
	 * updateMainVisual
	 * 메인비주얼 PK값으로 등록되어 있는 메인비주얼 데이터 DB에 update
	 * @param vo 사용자가 입력한 메인비주얼 데이터를 객체에 담아 전달
	 * @return void 메인비주얼 데이터 update 기능만 담당하는 메소드
	*/
	@Override
	public int updateMainVisual(Dm_main_visual_vo vo) throws Exception{
		return mainVisualMapper.updateMainVisual(vo);
	}
	
	/**
	 * deleteMainVisual
	 * 메인비주얼 PK값으로 등록되어 있는 메인비주얼 데이터 삭제
	 * @param vo 사용자가 삭제하고자 하는 메인비주얼 데이터의 PK값을 vo객체에 담아 전달
	 * @return void 메인비주얼 데이터 delete 기능만 담당하는 메소드
	*/
	@Override
	@Transactional
	public void deleteMainVisual(List<Dm_main_visual_vo> list) throws Exception{

		if (list.size() > 0) {
			list.forEach(item -> {
				int result = mainVisualMapper.deleteMainVisual(item);
				
				if (result < 1) throw new RuntimeException(MessageCode.CMS_DELETE_FAIL.getLog());
			});
		}
	}
	
	/**
	 * selectMainVisualListCnt
	 * 검색 값에 따른 메인비주얼 리스트데이터 개수 조회
	 * @param vo 메인비주얼 데이터 검색조건값을 vo객체에 담아 전달
	 * @return int 조회된 메인비주얼 데이터의 개수를 정수형으로 전달
	*/
	@Override
	public int selectMainVisualListCnt(Dm_main_visual_vo vo) throws Exception{
		int result = mainVisualMapper.selectMainVisualListCnt(vo);
		return result;
	}
	
	/**
	 * selectMainVisualByDmid
	 * 메인비주얼 PK값으로 1건의 메인비주얼 데이터 조회
	 * @param vo 메인비주얼 PK값을 vo객체에 담아 전달
	 * @return Dm_main_visual_vo 조회된 메인비주얼 데이터를 메인비주얼 데이터 vo객체에 담아 전달
	*/
	@Override
	public Dm_main_visual_vo selectMainVisualByDmid(Dm_main_visual_vo vo) throws Exception{
		Dm_main_visual_vo result = mainVisualMapper.selectMainVisualByDmid(vo);
		return result;
	}

	/**
	 * selectMainVisualListForWeb
	 * 사용자페이지 메인페이지에 표출할 게시기간이 지나지 않거나,기간무제한인 메인비주얼 리스트데이터 조회
	 * @param vo 메인비주얼 도메인PK값을 vo객체에 담아 전달
	 * @return List<Dm_main_visual_vo> 조회된 메인비주얼 데이터를 List 자료형으로 전달
	*/
	@Override
	public List<Dm_main_visual_vo> selectMainVisualListForWeb(Dm_main_visual_vo vo) throws Exception{
		List<Dm_main_visual_vo> result = mainVisualMapper.selectMainVisualListForWeb(vo);
		return result;
	}

}
