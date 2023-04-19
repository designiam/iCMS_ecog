package egovframework.diam.ui.main;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.diam.biz.model.main.Dm_cover_vo;
import egovframework.diam.biz.service.main.CoverService;
import egovframework.diam.cmm.model.LoginVO;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.EgovUserDetailsHelper;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class CoverController {

	@Autowired
	private CoverService coverService;

	@RequestMapping("/adm/selectCoverList.do")
	public ResponseEntity<?> selectCoverList(Dm_cover_vo coverVO) {
		Map<String, Object> resultMap = new HashMap<>();
		
		int row = coverVO.getRows() != 0 ? coverVO.getRows() : 50;
		int page = coverVO.getPage() != 0 ? coverVO.getPage() : 1;
		
		if (row < 1 || page < 0) {
			log.error(MessageCode.CMM_REQUEST_BADREQUEST.getLog());
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		} else {
			coverVO.setRows(row);
			coverVO.setPage(row * (page -1));
		}
		
		try {
						
			int coverCount = coverService.selectCoverListCount(coverVO);
			List<Dm_cover_vo> list = coverService.selectCoverList(coverVO);
			
			if (list.size() > 0) {
				list.forEach(item -> {
					item.setDm_year(item.getDm_year() + "." + item.getDm_month());
					item.setDm_status(item.getDm_status().equals("1") ? "사용" : "미사용");
				});
			}
			
			resultMap.put("result", "success");
			resultMap.put("total", coverCount);
			resultMap.put("rows", list);
			resultMap.put("notice", MessageCode.CMS_SELECT_SUCCESS.getMessage());
			
		} catch(DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch(Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);			
		}
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/adm/upsertCover.do")
	public ResponseEntity<?> upsertCover(@Valid Dm_cover_vo coverVO, BindingResult br) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		if(br.hasErrors()) {
			List<FieldError> errors = br.getFieldErrors();
			String msg = errors.get(0).getDefaultMessage();
			
			resultMap.put("result", "fail");
			resultMap.put("notice", msg);
			return new ResponseEntity<>(resultMap, HttpStatus.OK);
		}
		
		try {
			if (commonUtil.isNullOrEmpty(loginVO.getId())) {
				resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
			}
			
			int dup = coverService.selectUniqVol(coverVO);
			if (dup > 0) {
				resultMap.put("result", "fail");
				resultMap.put("notice", "중복된 발행호수가 존재합니다.");
				return new ResponseEntity<>(resultMap, HttpStatus.OK);
			}
			
			coverVO.setDm_create_id(loginVO.getId());
			coverVO.setDm_modify_id(loginVO.getId());
			coverVO.setDm_content(commonUtil.xssSaxFiltering(coverVO.getDm_content()));
			
			coverService.upsertCover(coverVO);
			
			resultMap.put("result", "success");
			resultMap.put("notice", MessageCode.CMS_UPSERT_SUCCESS.getMessage());
			
		} catch(DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch(Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);			
		}
		
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/adm/selectCover.do")
	public ResponseEntity<?> selectCover(Dm_cover_vo coverVO) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		if (commonUtil.isNullOrEmpty(coverVO.getDm_id())) {
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		}
		
		try {
			
			coverVO = coverService.selectCover(coverVO);
			if (coverVO == null) {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
			} else {
				resultMap.put("result", "success");
				resultMap.put("rows", coverVO);				
			}
			
		} catch(DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch(Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);			
		}
		
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
	@PostMapping("/adm/deleteCover.do")
	public ResponseEntity<?> deleteCover(@RequestParam("dm_id[]")String[] ids) {
		Map<String, Object> resultMap = new HashMap<>();
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		CommonUtil commonUtil = new CommonUtil();
		
		try {
			if (commonUtil.isNullOrEmpty(loginVO.getId())) {
				resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
			}
			
			if (ids.length > 0) {
				List<Dm_cover_vo> list = new ArrayList<>();
				Arrays.asList(ids).forEach(item -> {
					list.add(Dm_cover_vo.builder()
							.dm_id(item)
							.dm_delete_id(loginVO.getId())
							.build());
					
				});
				
				coverService.deleteCover(list);
				resultMap.put("result", "success");
				resultMap.put("notice", MessageCode.CMS_DELETE_SUCCESS.getMessage());
				
			} else {
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
			}
			
		} catch(DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (RuntimeException rte) {
			log.error(MessageCode.CMM_TRANSACTION_FAIL.getLog());
			resultMap.put("notice", MessageCode.CMS_DELETE_FAIL.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch(Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);			
		}
		
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
}
