package egovframework.diam.ui.main;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import egovframework.diam.biz.model.main.Dm_subscribe_vo;
import egovframework.diam.biz.service.main.SubscribeService;
import egovframework.diam.cmm.model.LoginVO;
import egovframework.diam.cmm.util.EgovUserDetailsHelper;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class SubscribeController {
	
	@Autowired private SubscribeService subscribeService;
	
	@GetMapping("/adm/selectSubsList.do")
	public ResponseEntity<?> selectSubsList(Dm_subscribe_vo vo) {
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
			int total = subscribeService.selectSubsListCount(vo);
			List<Dm_subscribe_vo> list = subscribeService.selectSubsList(vo);
			
			resultMap.put("result", "success");
			resultMap.put("total", total);
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
	
	@PostMapping("/adm/updateSubsStatus.do")
	public ResponseEntity<?> updateSubsStatus(Dm_subscribe_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			vo = subscribeService.selectByPk(vo);
			if (vo == null) {
				resultMap.put("result", "fail");
				resultMap.put("notice", MessageCode.CMS_SELECT_NODATA.getMessage());
			} else {
				int result = subscribeService.deleteSubscribe(vo);
				if (result > 0) {
					resultMap.put("result", "success");
					resultMap.put("notice", MessageCode.CMS_DELETE_SUCCESS.getMessage());
				} else {
					resultMap.put("result", "fail");
					resultMap.put("notice", MessageCode.CMS_DELETE_FAIL.getMessage());					
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
	
	@GetMapping("/adm/getSubscribeExcel.do")
	public ResponseEntity<?> reserveExcel(Dm_subscribe_vo vo, HttpServletRequest request) {
		List<Dm_subscribe_vo> infoList = new ArrayList<>();
		Map<String, String> resultMap = new HashMap<>();
		String[] headerList = {"번호","이름","이메일","구독 상태","구독일"};
		String excel_title = "구독자";
		try {
			
			infoList = subscribeService.selectSubsList(vo);

			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = workbook.createSheet(excel_title + "리스트");
			XSSFRow row = sheet.createRow(0);
			XSSFCell cell = null;
			CellStyle style = workbook.createCellStyle();
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
						
			for (int i = 0 ; i < headerList.length ; i++) {
				cell = row.createCell(i);
				cell.setCellStyle(style);
				cell.setCellValue(headerList[i]);
				//sheet.autoSizeColumn(i);
			}
			
			for (int i = 0 ; i < infoList.size() ; i++) {
				row = sheet.createRow(i+1);
				
				int cellCnt = 0 ;
				cell = row.createCell(cellCnt);
				cell.setCellStyle(style);
				cellCnt++;
				cell.setCellValue(i+1);
				
				cell = row.createCell(cellCnt);
				cell.setCellStyle(style);
				cellCnt++;
				cell.setCellValue(infoList.get(i).getDm_name());
											
				cell = row.createCell(cellCnt);
				cell.setCellStyle(style);
				cellCnt++;
				cell.setCellValue(infoList.get(i).getDm_email());
				
				cell = row.createCell(cellCnt);
				cell.setCellStyle(style);
				cellCnt++;
				cell.setCellValue(infoList.get(i).getStatus_text());
				
				cell = row.createCell(cellCnt);
				cell.setCellStyle(style);
				cellCnt++;
				cell.setCellValue(infoList.get(i).getDm_create_dt());
						
			}
						
			for (int i = 0 ; i < headerList.length ; i++) {
				sheet.autoSizeColumn(i);
				sheet.setColumnWidth(i, (sheet.getColumnWidth(i)+1024));
			}
			
			String path = request.getServletContext().getRealPath("/resources/excel/");
			String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddhhmmss"));
			String filename = excel_title+"목록_"+time + ".xlsx";
			File folder = new File(path);
			if (!folder.exists()) {
				folder.mkdirs();			
			}
			File save = new File(path + filename);
			FileOutputStream fos = new FileOutputStream(save);
			workbook.write(fos);
			if (save.exists()) {
				resultMap.put("result", "success");
				resultMap.put("rows", "/resources/excel/" + filename);
			} else {
				throw new FileNotFoundException();
			}
			
		} catch(FileNotFoundException e) {
			log.error("File not found Exception");
			resultMap.put("notice", "엑셀 파일을 찾을 수 없습니다.");
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch(DataAccessException dae) {
			log.error("data access exception");
			resultMap.put("notice", "SQL 구문 오류가 발생했습니다.");
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (IOException e) {
			log.error("IO exception");
			resultMap.put("notice", "엑셀파일 생성 중 오류가 발생했습니다.");
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch(Exception e) {
			log.error("system error");
			resultMap.put("notice", "시스템 오류가 발생했습니다. 관리자에게 문의주세요");
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}

}
