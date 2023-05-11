package egovframework.diam.web.event;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import egovframework.diam.biz.model.event.Dm_event_vo;
import egovframework.diam.biz.service.event.EventService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class WebEventController {
	
	@Autowired
	private EventService eventService;
	
	@GetMapping("/web/selectEventList.do")
	public ResponseEntity<?> selectEventList(Dm_event_vo vo) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int row = vo.getRows() != 0 ? vo.getRows() : 6;
		int page = vo.getPage() != 0 ? vo.getPage() : 1;
		
		if (row < 1 || page < 0) {
			log.error(MessageCode.CMM_REQUEST_BADREQUEST.getLog());
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		} else {
			vo.setRows(row);
			vo.setPage(row * (page -1));
			vo.setCommand("web");
		}
		
		try {
			int total = eventService.selectEventCount(vo);
			List<Dm_event_vo> list = eventService.selectEventList(vo);
			
			resultMap.put("rows", list);
			resultMap.put("total", total);
			
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
	
	@GetMapping("/web/selectEvent.do")
	public ResponseEntity<?> selectEvent(Dm_event_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		try {
			
			if (commonUtil.isNullOrEmpty(vo.getDm_id())) {
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
			}
			
			vo = eventService.selectEvent(vo);
			if (vo == null) {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
			} else {
				resultMap.put("result", "success");
				resultMap.put("rows", vo);
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
