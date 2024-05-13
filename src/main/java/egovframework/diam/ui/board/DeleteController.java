package egovframework.diam.ui.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.diam.biz.model.board.Dm_write_vo;
import egovframework.diam.biz.service.board.BoardService;
import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.biz.service.config.ConfigService;
import egovframework.diam.biz.service.display.PageService;
import egovframework.diam.biz.service.member.MemberService;
import egovframework.diam.cmm.model.LoginVO;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.EgovUserDetailsHelper;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class DeleteController {
	@Resource(name="writeService") private WriteService writeService;
	@Resource(name="boardService") private BoardService boardService;
	@Resource(name="configService") private ConfigService configService;
	@Resource(name="memberService") private MemberService memberService;
	@Resource(name="pageService") private PageService pageService;

	@RequestMapping("/adm/get_delete_list.do")
	public ResponseEntity<Object> get_delete_list (Dm_write_vo writeVO) {
		Map<String, Object> resultMap = new HashMap<>();
		
		int row = writeVO.getRows() != 0 ? writeVO.getRows() : 50;
		int page = writeVO.getPage() != 0 ? writeVO.getPage() : 1;
		
		if (row < 1 || page < 0) {
			log.error(MessageCode.CMM_REQUEST_BADREQUEST.getLog());
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		} else {
			writeVO.setRows(row);
			writeVO.setPage(row * (page -1));
		}
		try {		
			List<Dm_write_vo> writeList = writeService.selectDeleteList(writeVO);
			int writeCnt = writeService.selectDeleteListCnt(writeVO);
			if (writeList.size() > 0) {
				writeList.forEach(item -> {
					if (item.getWr_is_notice() != null && item.getWr_is_notice().equals("1")) {
						item.setWr_is_notice("Y");
					} else {
						item.setWr_is_notice("N");						
					}
				});
			}
			resultMap.put("result", "success");
			resultMap.put("total", writeCnt);
			resultMap.put("rows", writeList);
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
	
	/**
	 * delete_write_remove
	 * request 객체를 통하여 전달받은 게시판아이디/게시물PK 배열에 해당하는 게시물데이터 완전삭제
	 * @param request 메소드 수행 시 HttpServletRequest 객체에서 값을 꺼낼 때 사용하는 객체
	 * @param response 메소드의 수행결과를 화면에 전달하기 위해 사용하는 HttpServletResponse 객체
	 * @return void response객체를 통하여 ajax 결과값 전송
	*/
	@RequestMapping("/adm/delete_write_remove.do")
	public ResponseEntity<Object> delete_write_remove (@RequestParam("wr_id[]") String ids[]) {
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		try {
			
			if (commonUtil.isNullOrEmpty(loginVO.getId())) {
				resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
			}
			
			if (ids.length > 0) {
				List<Dm_write_vo> list = new ArrayList<>();
				for(String item : ids) {
					Dm_write_vo vo = new Dm_write_vo();
					vo.setWr_id(item);
					vo = writeService.selectWrite(vo);
					if (vo == null) {
						resultMap.put("result", "fail");
						resultMap.put("notice", "완전삭제하고자 하는 게시글정보가 없습니다.");
						return new ResponseEntity<>(resultMap, HttpStatus.OK);
					}
					vo.setDm_delete_id(loginVO.getId());
					list.add(vo);
				}
				writeService.removeWrite(list);
				resultMap.put("result", "success");
				resultMap.put("notice", MessageCode.CMS_DELETE_SUCCESS.getMessage());
			} else {
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
			}
			
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
	
	/**
	 * delete_write_remove
	 * request 객체를 통하여 전달받은 게시판아이디/게시물PK 배열에 해당하는 게시물데이터 완전삭제
	 * @param request 메소드 수행 시 HttpServletRequest 객체에서 값을 꺼낼 때 사용하는 객체
	 * @param response 메소드의 수행결과를 화면에 전달하기 위해 사용하는 HttpServletResponse 객체
	 * @return void response객체를 통하여 ajax 결과값 전송
	*/
	@RequestMapping("/adm/delete_write_restore.do")
	public ResponseEntity<Object> delete_write_restore (@RequestParam("wr_id[]") String ids[]) {
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		try {
			
			if (commonUtil.isNullOrEmpty(loginVO.getId())) {
				resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
			}
			
			if (ids.length > 0) {
				List<Dm_write_vo> list = new ArrayList<>();
				for(String item : ids) {
					Dm_write_vo vo = new Dm_write_vo();
					vo.setWr_id(item);
					vo = writeService.selectWrite(vo);
					if (vo == null) {
						resultMap.put("result", "fail");
						resultMap.put("notice", "복구하고자 하는 게시글정보가 없습니다.");
						return new ResponseEntity<>(resultMap, HttpStatus.OK);
					}
					list.add(vo);
				}
				writeService.restoreWrite(list);
				resultMap.put("result", "success");
				resultMap.put("notice", MessageCode.CMS_RESTORE_SUCCESS.getMessage());
			} else {
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
			}
			
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