package egovframework.diam.ui.main;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
	public ResponseEntity<?> upsertCover(@Valid Dm_cover_vo coverVO, BindingResult br, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String FILE_PATH = request.getServletContext().getRealPath("/") + "resources/cover/";
		
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
			
			int result = 0;
			if (commonUtil.isNullOrEmpty(coverVO.getDm_id())) {
				int dup = coverService.selectUniqVol(coverVO);
				if (dup > 0) {
					resultMap.put("result", "fail");
					resultMap.put("notice", "중복된 발행호수가 존재합니다.");
					return new ResponseEntity<>(resultMap, HttpStatus.OK);
				}
				
				if (coverVO.getDm_status().equals("0")) {
					Dm_cover_vo checkVO = coverService.selectUseCover(coverVO);
					if (checkVO == null) {
						resultMap.put("result", "fail");
						resultMap.put("notice", "메인 표지를 등록해야 합니다.");
						return new ResponseEntity<>(resultMap, HttpStatus.OK);
					}
				}
				
				File folder = new File(FILE_PATH);
				if (!folder.exists()) {
					folder.mkdirs();
				}

				if (coverVO.getMultiFile().getSize() > 0) {
					boolean chkImageExt = commonUtil.imageExtCheck(coverVO.getMultiFile());
					if (!chkImageExt) {
						resultMap.put("result", "fail");
						resultMap.put("notice", "jpg,jpeg,gif,png 확장자 파일만 업로드 가능합니다.");
						return new ResponseEntity<>(resultMap, HttpStatus.OK);
					}

					uploadCoverFile(coverVO, null, FILE_PATH);
				}

				coverVO.setDm_create_id(loginVO.getId());
				coverVO.setDm_content(commonUtil.xssSaxFiltering(coverVO.getDm_content()));
				
				result = coverService.insertCover(coverVO);
				
				if (result > 0) {
					resultMap.put("result", "success");
					resultMap.put("notice", MessageCode.CMS_INSERT_SUCCESS.getMessage());
				} else {
					resultMap.put("result", "fail");
					resultMap.put("notice", MessageCode.CMS_INSERT_FAIL.getMessage());
				}
			} else {

				Dm_cover_vo checkVO = new Dm_cover_vo();
				checkVO.setDm_id(coverVO.getDm_id());
				checkVO = coverService.selectCover(checkVO);
				if (checkVO != null) {
					if (!commonUtil.isNullOrEmpty(coverVO.getDm_del_image())) {
						if(coverVO.getMultiFile().getSize() > 0) {
							File file = new File(FILE_PATH + coverVO.getDm_del_image());
							if( file.exists() ){
								FileDelete(file);
							}
						} else {
							resultMap.put("result", "fail");
							resultMap.put("notice", "표지 이미지를 등록해주세요.");
							return new ResponseEntity<>(resultMap, HttpStatus.OK);
						}
					}
					
					File folder = new File(FILE_PATH);
					if (!folder.exists()) {
						folder.mkdirs();
					}

					if (coverVO.getMultiFile().getSize() > 0) {
						boolean chkImageExt = commonUtil.imageExtCheck(coverVO.getMultiFile());
						if (!chkImageExt) {
							resultMap.put("result", "fail");
							resultMap.put("notice", "jpg,jpeg,gif,png 확장자 파일만 업로드 가능합니다.");
							return new ResponseEntity<>(resultMap, HttpStatus.OK);
						}

						uploadCoverFile(coverVO, checkVO, FILE_PATH);
					}
					
					coverVO.setDm_modify_id(loginVO.getId());
					coverVO.setDm_content(commonUtil.xssSaxFiltering(coverVO.getDm_content()));
					result = coverService.updateCover(coverVO);	
					
					if (result > 0) {
						resultMap.put("result", "success");
						resultMap.put("notice", MessageCode.CMS_UPDATE_SUCCESS.getMessage());							
					} else {
						resultMap.put("result", "success");
						resultMap.put("notice", MessageCode.CMS_UPDATE_FAIL.getMessage());
					}	

				} else {
					resultMap.put("result", "fail");
					resultMap.put("notice", "수정하고자 하는 표지 정보가 없습니다.");
				}
			}

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

	/**
	 * @Method : uploadCoverFile
	 * @Description : CMS  파일 업로드
	 * @param coverVO
	 * @param checkVO
	 * @param file_path
	 * @throws Exception
	 */
	private void uploadCoverFile(Dm_cover_vo coverVO, Dm_cover_vo checkVO, String file_path) throws Exception {
		CommonUtil commonUtil = new CommonUtil();
		String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

        if (coverVO.getMultiFile().getSize() > 0 ) {
        	coverVO.setDm_cover_img_ori(coverVO.getMultiFile().getOriginalFilename());
    		String ext = coverVO.getMultiFile().getOriginalFilename().substring(coverVO.getMultiFile().getOriginalFilename().indexOf(".") + 1);
			String upload_visual = today + "_" + commonUtil.convertSHA256(coverVO.getMultiFile().getOriginalFilename()) + "." + ext;
    		System.out.print(file_path + upload_visual);
			coverVO.getMultiFile().transferTo(new File(file_path + upload_visual));
			coverVO.setDm_cover_img(upload_visual);
		} else {
			if (checkVO != null && (coverVO.getDm_del_image() == null || coverVO.getDm_del_image().isEmpty())) {
				coverVO.setDm_cover_img(checkVO.getDm_cover_img());
				coverVO.setDm_cover_img_ori(checkVO.getDm_cover_img_ori());
			}
		}
	}
	
	/**
	 * @Method : FileDelete
	 * @Description : 파일삭제
	 * @param file
	 */
	private synchronized void FileDelete(File file) {
		file.delete();
	}
	
}
