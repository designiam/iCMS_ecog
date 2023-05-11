package egovframework.diam.biz.service.main.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.diam.biz.db.main.CoverMapper;
import egovframework.diam.biz.model.main.Dm_cover_vo;
import egovframework.diam.biz.service.main.CoverService;
import egovframework.diam.cmm.util.MessageCode;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("coverService")
public class CoverServiceImpl extends EgovAbstractServiceImpl implements CoverService{
	
	@Autowired
	private CoverMapper coverMapper;

	@Override
	public List<Dm_cover_vo> selectCoverList(Dm_cover_vo vo) throws Exception {
		return coverMapper.selectCoverList(vo);
	}

	@Override
	public int selectCoverListCount(Dm_cover_vo vo) throws Exception {
		return coverMapper.selectCoverListCount(vo);
	}

	@Override
	@Transactional
	public void upsertCover(Dm_cover_vo vo) throws Exception {
		if (vo.getDm_status().equals("1")) {
			Dm_cover_vo checkVO = coverMapper.selectUseStatusCover(vo);
			if (checkVO != null) {
				checkVO.setDm_status("0");
				coverMapper.updateCoverStatus(checkVO);
			}
		}
		coverMapper.upsertCover(vo);
	}

	@Override
	public Dm_cover_vo selectCover(Dm_cover_vo vo) throws Exception {
		return coverMapper.selectCover(vo);
	}

	@Override
	public Dm_cover_vo selectUseCover(Dm_cover_vo vo) throws Exception {
		return coverMapper.selectUseStatusCover(vo);
	}

	@Override
	public int selectUniqVol(Dm_cover_vo vo) throws Exception {
		return coverMapper.selectUniqVol(vo);
	}

	@Override
	@Transactional
	public void deleteCover(List<Dm_cover_vo> list) throws Exception {
		list.forEach(item -> {
			if (coverMapper.deleteCover(item) < 1) throw new RuntimeException(MessageCode.CMM_TRANSACTION_FAIL.getLog());
		});
	}

	@Override
	public Dm_cover_vo selectCoverByVol(Dm_cover_vo vo) throws Exception {
		return coverMapper.selectCoverByVol(vo);
	}

	@Override
	public List<Dm_cover_vo> selectCoverCombobox() throws Exception {
		return coverMapper.selectCoverCombobox();
	}

}
