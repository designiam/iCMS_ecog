package egovframework.diam.ui.event;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import egovframework.diam.biz.model.event.Dm_event_vo;
import egovframework.diam.biz.service.event.EventService;
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
	
}
