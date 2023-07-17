package egovframework.diam.ui.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.diam.biz.model.file.Dm_file_vo;
import egovframework.diam.biz.service.file.FileService;
import egovframework.diam.cmm.model.LoginVO;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.EgovUserDetailsHelper;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class FileController {
	
	@Autowired
	private FileService fileService;

	@PostMapping("/adm/selectFileList.do")
	public ResponseEntity<?> selectFileList(Dm_file_vo fileVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int row = fileVO.getRows() != 0 ? fileVO.getRows() : 50;
		int page = fileVO.getPage() != 0 ? fileVO.getPage() : 1;
		
		if (row < 1 || page < 0) {
			log.error(MessageCode.CMM_REQUEST_BADREQUEST.getLog());
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		} else {
			fileVO.setRows(row);
			fileVO.setPage(row * (page -1));
		}
		
		try {
			List<Dm_file_vo> list = fileService.selectFileList(fileVO);
			int total = fileService.selectfileListCount(fileVO);
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
	
	@PostMapping("/adm/createFile.do")
	public ResponseEntity<?> createFile(Dm_file_vo fileVO, HttpServletRequest request) {
		CommonUtil commonUtil = new CommonUtil();
		Map<String, Object> resultMap = new HashMap<>();
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String FILE_PATH = request.getServletContext().getRealPath("/") + "resources/file/";
		
		if (commonUtil.isNullOrEmpty(loginVO.getId())) {
			resultMap.put("notice", MessageCode.CMM_SESSION_EXPIRED.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.UNAUTHORIZED);
		}
		
		System.out.println("file vo : " + fileVO.getFile().getOriginalFilename());
		try {
			if(!fileVO.getFile().isEmpty()) {
				String fileExt = fileVO.getFile().getOriginalFilename().substring(fileVO.getFile().getOriginalFilename().lastIndexOf(".")+1);
				boolean fileExtCheck = false;
				File folder = new File(FILE_PATH);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				
				if(fileExt.toLowerCase().equals("pdf")) {
					fileExtCheck = commonUtil.pdfExtCheck(fileVO.getFile());
				} else {
					fileExtCheck = commonUtil.imageExtCheck(fileVO.getFile());
				}
				
				if (!fileExtCheck) {
					resultMap.put("result", "fail");
					resultMap.put("notice", "jpg,jpeg,gif,png,pdf 확장자 파일만 업로드 가능합니다.");
					return new ResponseEntity<>(resultMap, HttpStatus.OK);
				}
				
				String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
				fileVO.getFile().transferTo(new File(FILE_PATH + today + "_" + fileVO.getFile().getOriginalFilename()));
				fileVO.setDm_path("/resources/file/");
				fileVO.setDm_org_name(fileVO.getFile().getOriginalFilename());
				fileVO.setDm_file_name(today + "_" + fileVO.getFile().getOriginalFilename());
				fileVO.setDm_size(fileVO.getFile().getSize());
				fileVO.setDm_ext(fileExt);
				fileVO.setDm_type(fileVO.getFile().getContentType());
				fileVO.setDm_create_id(loginVO.getId());
				
				int result = fileService.createFile(fileVO);
				if (result > 0) {
					resultMap.put("result", "success");
					resultMap.put("notice", MessageCode.CMS_UPSERT_SUCCESS.getMessage());
				} else {
					resultMap.put("result", "fail");
					resultMap.put("notice", MessageCode.CMS_UPSERT_FAIL.getMessage());				
				}
			} else {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMM_NULL_ERROR.getMessage());
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
	
	@GetMapping("/adm/selectFile.do")
	public ResponseEntity<?> selectFile(Dm_file_vo fileVO) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		if (commonUtil.isNullOrEmpty(fileVO.getDm_id())) {
			resultMap.put("notice", MessageCode.CMM_REQUEST_BADREQUEST.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
		}
		
		try {
			
			fileVO = fileService.selectFile(fileVO); 
			if (fileVO == null) {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
			} else {
				resultMap.put("result", "success");
				resultMap.put("rows", fileVO);				
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
	
	@RequestMapping(value="/down/image.do", produces=MediaType.IMAGE_JPEG_VALUE)
	public @ResponseBody byte[] imageDownEdit(@RequestParam("fileNo") String fileNo
			,HttpServletRequest request) throws Exception {
		Dm_file_vo vo = new Dm_file_vo();
		vo = fileService.selectFile(Dm_file_vo.builder().dm_id(fileNo).build());
		
		String imagePath =  request.getServletContext().getRealPath("resources/file/") + vo.getDm_file_name();
		InputStream imageStream = new FileInputStream(imagePath);
		
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		
		return imageByteArray;
		
	}
	
	@RequestMapping(value="/down/pdf.do", produces=MediaType.APPLICATION_PDF_VALUE)
	public @ResponseBody byte[] pdfDownEdit(@RequestParam("fileNo") String fileNo
			,HttpServletRequest request) throws Exception {
		Dm_file_vo vo = new Dm_file_vo();
		vo = fileService.selectFile(Dm_file_vo.builder().dm_id(fileNo).build());
		
		String imagePath =  request.getServletContext().getRealPath("resources/file/") + vo.getDm_file_name();
		InputStream imageStream = new FileInputStream(imagePath);
		
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();
		
		return imageByteArray;
	}
	
	
}
