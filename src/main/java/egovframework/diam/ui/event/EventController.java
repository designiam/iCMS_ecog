package egovframework.diam.ui.event;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.diam.biz.model.event.Dm_event_vo;
import egovframework.diam.biz.service.event.EventService;
import egovframework.diam.cmm.model.LoginVO;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.EgovUserDetailsHelper;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class EventController {

	@Autowired
	private EventService eventService;
	
	@PostMapping("/adm/selectEventList.do")
	public ResponseEntity<?> selectEventList(Dm_event_vo vo) {
		
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
			List<Dm_event_vo> list = eventService.selectEventList(vo);
			int total = eventService.selectEventCount(vo);
			resultMap.put("result", "success");
			resultMap.put("rows", list);
			resultMap.put("total", total);
			
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
	
	@PostMapping("/adm/upsertEvent.do")
	public ResponseEntity<?> upsertEvent(Dm_event_vo vo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String FILE_PATH = request.getServletContext().getRealPath("/") + "resources/event/";
		
		if (commonUtil.isNullOrEmpty(loginVO.getId())) {
			resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
		}
		
		try {
			
			if (!vo.getFile().isEmpty()) {
				File folder = new File(FILE_PATH);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				boolean chkImageExt = commonUtil.imageExtCheck(vo.getFile());
				if (!chkImageExt) {
					resultMap.put("result", "fail");
					resultMap.put("notice", "jpg,jpeg,gif,png 확장자 파일만 업로드 가능합니다.");
					return new ResponseEntity<>(resultMap, HttpStatus.OK);
				}
				String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
				vo.getFile().transferTo(new File(FILE_PATH + today + "_" + vo.getFile().getOriginalFilename()));
				vo.setDm_file_path("/resources/event/" + today + "_" + vo.getFile().getOriginalFilename());
				vo.setDm_file_name(vo.getFile().getOriginalFilename());
				
			}
			vo.setDm_content(commonUtil.xssSaxFiltering(vo.getDm_content()));
			vo.setDm_create_id(loginVO.getId());
			vo.setDm_modify_id(loginVO.getId());
			int result = eventService.upsertEvent(vo);
			if (result > 0) {
				resultMap.put("result", "success");
				resultMap.put("notice", MessageCode.CMS_UPSERT_SUCCESS.getMessage());
			} else {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_UPSERT_FAIL.getMessage());				
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
	
	@GetMapping("/adm/selectEvent.do")
	public ResponseEntity<?> selectEvent(Dm_event_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		if (commonUtil.isNullOrEmpty(vo.getDm_id())) {
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		}
		
		try {
			
			vo = eventService.selectEvent(vo);
			if (vo == null) {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
			} else {
				resultMap.put("result", "success");
				resultMap.put("rows", vo);				
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
	
	@PostMapping("/adm/deleteEvent.do")
	public ResponseEntity<?> deleteEvent(@RequestParam("dm_id[]") String[] ids) {
		Map<String, Object> resultMap = new HashMap<>();
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		CommonUtil commonUtil = new CommonUtil();
		
		try {
			
			if (commonUtil.isNullOrEmpty(loginVO.getId())) {
				resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
			}
			
			if (ids.length > 0) {
				List<Dm_event_vo> list = new ArrayList<>();
				Arrays.asList(ids).forEach(item -> {
					list.add(Dm_event_vo.builder()
							.dm_id(item)
							.dm_delete_id(loginVO.getId())
							.build());
				});
				
				eventService.deleteEvent(list);
				
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
