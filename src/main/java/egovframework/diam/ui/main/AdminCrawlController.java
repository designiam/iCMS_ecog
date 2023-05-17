package egovframework.diam.ui.main;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.openqa.selenium.NoSuchElementException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.diam.cmm.selenium.CrawlingUtil;
import egovframework.diam.cmm.service.CrawlService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class AdminCrawlController {
	
	@Autowired private CrawlService crawlService;
	
	@PostMapping("/adm/startCrawling.do")
	public ResponseEntity<?> startCrawling(String type, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		String path = request.getServletContext().getRealPath("/") + "resources/crawl/";
		CrawlingUtil crawl = new CrawlingUtil();
		CommonUtil commonUtil = new CommonUtil();
		
		try {
			List<Dm_crawl_vo> tt = new ArrayList<>();
			if (!commonUtil.isNullOrEmpty(type)) {
				if (type.equals("1")) {
					tt = crawl.crawlInstagram();
				} else {
					tt = Arrays.asList(crawl.crawlYoutube());
				}
				
				if (tt.size() > 0) {
					int size = crawlService.insertCrawlResult(tt, path);
					if (size > 0) {
						resultMap.put("result", "success");
						resultMap.put("notice", size + "건의 새로운 데이터를 저장하였습니다.");						
					} else {
						resultMap.put("result", "fail");
						resultMap.put("notice", "새로운 최신 게시물이 없습니다.");
					}
				} else {
					resultMap.put("result", "fail");
					resultMap.put("notice", "게시글을 찾을 수 없습니다.");
				}
				
			} else {
				resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
				return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
			}
			
		} catch (NoSuchElementException nse) {
			log.error("엘리먼트 찾기 실패");
			resultMap.put("notice", "SNS 크롤링 오류가 발생하였습니다.");
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);		
		} catch (IOException ioe) {
			log.error(MessageCode.CMM_FILE_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_FILE_ERROR.getLog());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);			
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (RuntimeException rte) {
			log.error(MessageCode.CMM_TRANSACTION_FAIL.getLog());
			resultMap.put("notice", MessageCode.CMM_TRANSACTION_FAIL.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(resultMap,HttpStatus.OK);
	}

	
	@PostMapping("/adm/selectCrawlData.do")
	public ResponseEntity<?> selectCrawlData(Dm_crawl_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		int row = vo.getRows() != 0 ? vo.getRows() : 10;
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
			List<Dm_crawl_vo> list = crawlService.selectCrawlList(vo);
			int total = crawlService.selectCrawlListCount(vo);
			if (list.size() > 0) {
				list.forEach(item -> {
					if (!commonUtil.isNullOrEmpty(item.getDm_src())) {
						item.setDm_src("<img style=\"max-width:50%;\" src=\""+item.getDm_src()+"\"/>");
					}
					if (!commonUtil.isNullOrEmpty(item.getDm_status())) {
						item.setDm_status(item.getDm_status().equals("1") ? "사용" : "사용안함");
					}
				});
				
			}
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
		
		return new ResponseEntity<>(resultMap,HttpStatus.OK);
	}
	
	@PostMapping("/adm/changeCrawlStatus.do")
	public ResponseEntity<?> changeCrawlStatus(Dm_crawl_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			vo = crawlService.selectByPK(vo);
			if (vo == null) {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
			} else {
				String newStat = vo.getDm_status().equals("1") ? "0" : "1";
				vo.setDm_status(newStat);
				int result = crawlService.updateCrawlStatus(vo);
				if (result > 0) {
					resultMap.put("result", "success");
					resultMap.put("notice", MessageCode.CMS_UPDATE_SUCCESS.getMessage());
				} else {
					resultMap.put("result", "fail");
					resultMap.put("notice", MessageCode.CMS_UPDATE_FAIL.getMessage());					
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
		
		return new ResponseEntity<>(resultMap,HttpStatus.OK);
	}
}
