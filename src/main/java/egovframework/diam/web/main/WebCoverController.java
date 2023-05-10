package egovframework.diam.web.main;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.diam.biz.model.board.Dm_write_vo;
import egovframework.diam.biz.model.display.Dm_menus_vo;
import egovframework.diam.biz.model.main.Dm_cover_vo;
import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.biz.service.display.MenuService;
import egovframework.diam.biz.service.main.CoverService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class WebCoverController {

	@Autowired private CoverService coverService;
	@Autowired private WriteService writeService;
	@Autowired private MenuService menuService;
	
	@GetMapping("/web/lastCoverList.do")
	public ResponseEntity<?> selectLastCoverList(Dm_cover_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			List<Dm_cover_vo> list = coverService.selectCoverList(vo);
			resultMap.put("result", "success");
			resultMap.put("rows", list);
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
	@GetMapping("/web/selectSameVolWrite.do")
	public ResponseEntity<?> selectSameVolWrite(Dm_write_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		if (commonUtil.isNullOrEmpty(vo.getWr_id())) {
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		}
		
		try {
			Dm_write_vo se = writeService.selectWrite(vo);
			
			if (se == null) {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			} else {
				List<Dm_write_vo> list = writeService.selectSameVolWrite(se);
				resultMap.put("result", "success");
				resultMap.put("rows", list);
			}
			
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
	@GetMapping("/web/selectPopularWrite.do")
	public ResponseEntity<?> selectPopularWrite(Dm_write_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		try {
			List<Dm_write_vo> list = writeService.selectPopularWrite(vo);
			if (list.size() > 0) {
				list.forEach(item -> {
					item.setWr_content(commonUtil.removeHtml(item.getWr_content()));
				});
			}
			resultMap.put("result", "success");
			resultMap.put("rows", list);
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
	@GetMapping("/web/selectChildMenuBoard.do")
	public ResponseEntity<?> selectChildMenus(@RequestParam("dm_id[]") String[] ids, @RequestParam("page") int page, HttpSession session) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		if (ids.length < 1) {
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		}
		
		try {
			String vol = (String) session.getAttribute("vol");
			if (commonUtil.isNullOrEmpty(vol)) {
				resultMap.put("result", "fail");
				resultMap.put("notice", "발행호수 정보를 찾을 수 없습니다.");
				return new ResponseEntity<>(resultMap, HttpStatus.OK);
			}
			
			Map<String, Object> param = new HashMap<>();
			param.put("vol", vol);
			param.put("list", Arrays.asList(ids));
			param.put("page", 12 * (page -1));
			param.put("rows", 12);
			
			List<Dm_write_vo> list = writeService.selectMainWrite(param);
			
			if (list.size() > 0) {
				resultMap.put("result", "success");
				resultMap.put("rows", list);
				
			} else {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());				
			}
		
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
}
