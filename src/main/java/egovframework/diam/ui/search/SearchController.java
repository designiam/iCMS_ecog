package egovframework.diam.ui.search;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.diam.cmm.service.SearchService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.EgovUserDetailsHelper;
import egovframework.diam.cmm.util.MessageCode;
import egovframework.diam.biz.model.config.Dm_domain_list_vo;
import egovframework.diam.biz.service.config.DomainService;
import egovframework.diam.cmm.model.Dm_search_vo;
import egovframework.diam.cmm.model.LoginVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class SearchController {
	@Resource(name="searchService")	private SearchService searchService;
	@Resource(name="domainService") private DomainService domainService;

	CommonUtil commonUtil = new CommonUtil();

	@RequestMapping("/adm/get_search_word_log.do")
	public ResponseEntity<Object> get_search_word_log (Dm_search_vo vo) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		int row = vo.getRows() != 0 ? vo.getRows() : 50;
		int page = vo.getPage() != 0 ? vo.getPage() : 1;

		if (row < 1 || page < 0) {
			log.error(MessageCode.CMM_REQUEST_BADREQUEST.getLog());
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		} else {
			vo.setRows(row);
			vo.setPage(row * (page -1));
		}

		try {
			int resultCnt = searchService.selectSearchWordListCnt(vo);
			List<Dm_search_vo> resultList = searchService.selectSearchWordList(vo);
			
			if(resultList.size() > 0) {
				resultMap.put("result", "success");
				resultMap.put("total", resultCnt);
				resultMap.put("rows", resultList);
				resultMap.put("notice", MessageCode.CMS_SELECT_SUCCESS.getMessage());
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
	
	@RequestMapping("/adm/get_search_word.do")
	public ResponseEntity<Object> getSearch_word(Dm_search_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			vo= searchService.selectSearchWord(vo);
			if (vo != null) {
				resultMap.put("result", "success");
				resultMap.put("rows", vo);
			} else {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
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
	
	@RequestMapping("/adm/set_search_word.do")
	public ResponseEntity<Object> setSearchWord(@Valid Dm_search_vo searchVO, BindingResult br, HttpServletRequest request) {
		
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		if(br.hasErrors()) {
			List<FieldError> errors = br.getFieldErrors();
			String msg = errors.get(0).getDefaultMessage();
			
			resultMap.put("result", "fail");
			resultMap.put("notice", msg);
			return new ResponseEntity<>(resultMap, HttpStatus.OK);
		}
		
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if (commonUtil.isNullOrEmpty(loginVO.getId())) {
			resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
		}
				
		Dm_search_vo checkVO = new Dm_search_vo();
		try {
			Dm_domain_list_vo domainVO = new Dm_domain_list_vo();
			domainVO.setDm_id(searchVO.getDm_domain());
			domainVO = domainService.selectDomainByDmid(domainVO);
			
			if (domainVO != null) {
				
				if (!commonUtil.isNullOrEmpty(searchVO.getDm_id())) {
					checkVO.setDm_id(searchVO.getDm_id());
					checkVO = searchService.selectSearchWord(checkVO);
					if (checkVO != null) {
						int result = searchService.updateSearchWord(searchVO);
						
						if (result > 0) {
							resultMap.put("result", "success");
							resultMap.put("notice", MessageCode.CMS_UPDATE_SUCCESS.getMessage());									
						} else {
							resultMap.put("result", "fail");
							resultMap.put("notice", MessageCode.CMS_UPDATE_FAIL.getMessage());
						}
					} else {
						resultMap.put("result", "fail");
						resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
					}
				} else {
					Dm_search_vo dupVO = searchService.selectSearchWordDup(searchVO);
					
					if (dupVO != null) {
						resultMap.put("result",  "duplicate");
						resultMap.put("notice", "동일한 검색어가 존재합니다.");
					} else {
						int result = searchService.insertSearchWord(searchVO);
						if (result > 0) {
							resultMap.put("result", "success");
							resultMap.put("notice", MessageCode.CMS_INSERT_SUCCESS.getMessage());
						} else {
							resultMap.put("result", "fail");
							resultMap.put("notice", MessageCode.CMS_INSERT_FAIL.getMessage());								
						}
					}
				}
			} else {
				resultMap.put("result", "fail");
				resultMap.put("notice", "도메인 정보가 없습니다.");
			}								
		} catch (IOException ioe) {
			log.error(MessageCode.CMM_FILE_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_FILE_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
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
	
	@RequestMapping("/adm/delete_search_word.do")
	public ResponseEntity<Object> delete_search_word(@RequestParam("dm_id[]") String ids[]) {
		Map<String, Object> resultMap = new HashMap<>();
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		try {
			
			if (commonUtil.isNullOrEmpty(loginVO.getId())) {
				resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
			}
			
			if (ids.length < 1) {
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);				
			}
			List<Dm_search_vo> list = new ArrayList<>();
			Arrays.asList(ids).forEach(item -> {
				Dm_search_vo vo = new Dm_search_vo();
				vo.setDm_id(item);
				list.add(vo);
			});
			
			searchService.deleteSearchWord(list);
			resultMap.put("result", "success");
			resultMap.put("notice", MessageCode.CMS_DELETE_SUCCESS.getMessage());

		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (RuntimeException rte) {
			log.error(MessageCode.CMS_DELETE_FAIL.getLog());
			resultMap.put("notice", MessageCode.CMS_DELETE_FAIL.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}	
}