package egovframework.diam.web.main;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import egovframework.diam.biz.model.main.Dm_subscribe_vo;
import egovframework.diam.biz.service.main.SubscribeService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class WebSubscribeController {
	
	@Autowired private SubscribeService subscribeService;
	
	@PostMapping("/web/requestSubscribe.do")
	public ResponseEntity<?> requestSubscribe(Dm_subscribe_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		try {
			if (commonUtil.isNullOrEmpty(vo.getDm_name()) || commonUtil.isNullOrEmpty(vo.getDm_email()) || commonUtil.isNullOrEmpty(vo.getDm_status())) {
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
			}
			
			Dm_subscribe_vo chk = subscribeService.selectByEmail(vo);
			
			if (chk == null) {
				if (vo.getDm_status().equals("N")) {
					resultMap.put("result", "fail");
					resultMap.put("notice", "입력 정보와 일치하는 구독자가 없습니다.");
				} else {
					vo.setDm_status("Y");
					int result = subscribeService.insertSubscribe(vo);
					if (result > 0) {
						resultMap.put("result", "success");
						resultMap.put("notice", "구독 신청 되었습니다.");
					} else {
						resultMap.put("result", "fail");
						resultMap.put("notice", MessageCode.CMS_INSERT_FAIL.getMessage());
					}
				}
			} else {
				if (vo.getDm_status().equals("Y")) {
					resultMap.put("result", "fail");
					resultMap.put("notice", "입력 정보는 이미 구독중입니다.");
				} else {
					if (!chk.getDm_name().equals(vo.getDm_name())) {
						resultMap.put("result", "fail");
						resultMap.put("notice", "입력한 이메일과 이름이 일치하지 않습니다.");
					} else {
						vo.setDm_id(chk.getDm_id());
						int result = subscribeService.deleteSubscribe(vo);
						if (result > 0) {
							resultMap.put("result", "success");
							resultMap.put("notice", "구독 해지 되었습니다.");
						} else {
							resultMap.put("result", "fail");
							resultMap.put("notice", MessageCode.CMS_UPDATE_FAIL.getMessage());
						}
					}
				}
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
