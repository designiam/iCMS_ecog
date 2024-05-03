package egovframework.diam.web.main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.diam.biz.model.board.Dm_write_vo;
import egovframework.diam.biz.model.main.Dm_cover_vo;
import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.biz.service.main.CoverService;
import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.diam.cmm.service.CrawlService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.MessageCode;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class WebCoverController {

	@Autowired
	private CoverService coverService;
	@Autowired
	private WriteService writeService;
	@Autowired
	private CrawlService crawlService;

	@GetMapping("/web/lastCoverList.do")
	public ResponseEntity<?> selectLastCoverList(Dm_cover_vo vo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();

		try {
			List<Dm_cover_vo> list = coverService.selectCoverCombobox();
			resultMap.put("result", "success");
			resultMap.put("rows", list);
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}

	@GetMapping("/web/selectCoverComboboxYear.do")
	public ResponseEntity<?> selectCoverComboboxYear(Dm_cover_vo vo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();

		try {
			List<Dm_cover_vo> list = coverService.selectCoverComboboxYear();
			resultMap.put("result", "success");
			resultMap.put("rows", list);
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}

	@GetMapping("/web/selectCoverComboboxVol.do")
	public ResponseEntity<?> selectCoverComboboxVol(Dm_cover_vo vo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();

		try {
			List<Dm_cover_vo> list = coverService.selectCoverComboboxVol(vo);
			resultMap.put("result", "success");
			resultMap.put("rows", list);
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}

	@GetMapping("/web/selectCoverTotalCount.do")
	public ResponseEntity<?> selectCoverTotalCount(Dm_cover_vo vo, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();

		try {
			int rows = coverService.selectCoverListCount(vo);
			resultMap.put("result", "success");
			resultMap.put("rows", rows);
		} catch (DataAccessException dae) {
			log.error(MessageCode.CMM_DATA_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_DATA_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}

	@GetMapping("/web/selectSameVolWrite.do")
	public ResponseEntity<?> selectSameVolWrite(Dm_write_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();

		try {

			List<Dm_write_vo> list = writeService.selectSameVolWrite(vo);
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

	@GetMapping("/web/selectRecommendWrite.do")
	public ResponseEntity<?> selectRecommendWrite(Dm_write_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();

		try {
			List<Dm_write_vo> list = writeService.selectRecommendWrite(vo);
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
	public ResponseEntity<?> selectChildMenus(@RequestParam("dm_id[]") String[] ids, @RequestParam("page") int page,
			HttpSession session) {
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
			param.put("page", 12 * (page - 1));
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

	@GetMapping("/web/selectCrawlData.do")
	public ResponseEntity<?> selectCrawlData() {
		Map<String, Object> resultMap = new HashMap<>();

		try {

			Dm_crawl_vo vo = new Dm_crawl_vo();
			vo.setDm_type("1");
			List<Dm_crawl_vo> list = crawlService.selectCrawlData(vo);
			resultMap.put("insta", list);

			vo.setDm_type("2");
			list = crawlService.selectCrawlData(vo);
			if (list != null) {
				resultMap.put("youtube", list.get(0));
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
	
	@GetMapping("/web/selectCoverVolList.do")
	public ResponseEntity<?> selectCoverVolList(Dm_cover_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();

		int row = vo.getRows() != 0 ? vo.getRows() : 12;
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

			List<Dm_cover_vo> list = coverService.selectCoverList(vo);
			int total = coverService.selectCoverListCount(vo);
			
			resultMap.put("result", "success");
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
	
	@GetMapping("/web/selectWriteListVol.do")
	public ResponseEntity<?> selectWriteListVol(Dm_write_vo vo) {
		Map<String, Object> resultMap = new HashMap<>();

		int row = vo.getRows() != 0 ? vo.getRows() : 12;
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
			List<Dm_write_vo> list = writeService.selectWriteListVol(vo);
			int total = writeService.selectWriteListVolCount(vo);

			resultMap.put("result", "success");
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
	
	@GetMapping("/web/selectSnsBlog.do")
	public ResponseEntity<?> selectSnsBlog(HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			String url = "https://blog.naver.com/prologue/PrologueList.naver?blogId=ecogj";//&amp;noTrackingCode=true&amp;directAccess=true
			Connection conn = Jsoup.connect(url);
			Document document = conn.get();

			List<Element> elements = document.select(".p_photo_d > .p_img");
		
            // 선택자로 원하는 요소를 가져오기
			//Element element = elements.get(0);(하나만 가져올 때)

			ArrayList<Object> resultList = new ArrayList<>();
			String[] ext_arr = {"jpg","jpeg","gif","png","JPG","JPEG","GIF","PNG"};
			
			// 결과 값 출력
	        for(Element element : elements) {
				Map<String, Object> map = new HashMap<>();

	        	String title = element.getElementsByTag("img").get(0).attr("title");
	        	String link = element.getElementsByTag("a").get(0).attr("href");
	        	String imgSrc = element.getElementsByTag("img").get(0).attr("src");
	        	
	        	String blogId = link.replaceAll("[^0-9]", "");
				String ext = "";
	        	//System.out.print("blogId============"+blogId);
	        	for(String temp : ext_arr) {
	        		if(imgSrc.contains(temp)) {
	        			ext = temp;
	        			break;
	        		}
	        	}
	        	
	        	String file_path = request.getServletContext().getRealPath("/resources/sns/blog/");
	        	String file_name = blogId + "." + ext;
	        	File folder = new File(file_path);
				if (!folder.exists()) {
					folder.mkdirs();
				}
				String target_file = file_path + file_name;
				File file = new File(target_file);
				if (!file.exists()) {
					URL imgSrcUrl = new URL(imgSrc);
					//읽기 객체
					InputStream is = imgSrcUrl.openStream();
					//쓰기 객체
					OutputStream os = new FileOutputStream(target_file);
					
					byte[] buffer = new byte[1024*8];
					
					while (true) {
						int inputData = is.read(buffer);
						if(inputData == -1)break;
						os.write(buffer,0,inputData);
						
					}
					is.close(); os.close();
				}
				imgSrc = "/resources/sns/blog/"+file_name;
				map.put("link", link);
				map.put("imgSrc", imgSrc);
				map.put("title", title);
				
				resultList.add(map);
			}
	        
         	resultMap.put("rows", resultList);
         	resultMap.put("result", "success");
         	
		} catch (Exception e) {
			log.error(e.getMessage()+MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
        }
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}

	@GetMapping("/web/selectSnsYoutube.do")
	public ResponseEntity<?> selectSnsYoutube() throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			String key = "AIzaSyCmjd05zfj7Gw6XV-XhQ8cH9X3LcnZ1PyI";
			String channelId = "UCCd9MhX9BrrS-vIbevOvo7w";
			URL url = new URL("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&key="+key+"&channelId="+channelId+"&order=date");

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(response.toString());
			JSONArray  itemsArray = (JSONArray)jsonObject.get("items");
			
			ArrayList<Object> resultList = new ArrayList<>();
			
			for(int i=0;i<itemsArray.size();i++){
				JSONObject tmp = (JSONObject) (itemsArray.get(i));//인덱스 번호로 접근해서 가져온다.
				JSONObject snippet = (JSONObject)tmp.get("snippet");
				
				JSONObject thumbnailsObj = (JSONObject)jsonParser.parse(snippet.get("thumbnails").toString());
				JSONObject defaultObj = (JSONObject)jsonParser.parse(thumbnailsObj.get("high").toString());
				JSONObject idObj = (JSONObject)tmp.get("id");
				String link = "https://www.youtube.com/watch?v="+idObj.get("videoId").toString();
				
				Map<String, Object> map = new HashMap<>();
				map.put("title", snippet.get("title"));
				map.put("imgSrc", defaultObj.get("url"));
				map.put("link", link);
				
				resultList.add(map);
			}
         	resultMap.put("rows", resultList);
         	resultMap.put("result", "success");
		} catch (Exception e) {
			log.error(e.getMessage()+MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
        }
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}


	@GetMapping("/web/selectSnsFacebook.do")
	public ResponseEntity<?> selectSnsFacebook() throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			String appId = "1059840051153042";
			String token = "EAAEnJZBBaNPwBO1A7Ok5mUFhj35oi1DzIRaTPI6Py0iPlZBziRblCFjHSLJyPHnjqwAChR39vYOOBGcOeA2kVArH3NlVH7SZApDzwqTgABcJ0OahYwQl9s4ZCYkeZAsl4lXpPKTIoAhvcSHyK9bLXvMGfKRiqepWFlAWAnJ7K2OJzZBA60ovw5sfP7";
			URL url = new URL("https://graph.facebook.com/"+appId+"/feed?fields=attachments,message,picture,link&access_token="+token);
			//URL url = new URL("https://graph.facebook.com/"+appId+"?fields=posts%7Bcreated_time%2Cmessage%2Cpicture%2Cpermalink_url%7D&access_token="+token);

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(response.toString());
			JSONArray itemsArray = (JSONArray)jsonObject.get("data");
			System.out.print(itemsArray.size());

			ArrayList<Object> resultList = new ArrayList<>();
			for(int i=0;i<itemsArray.size();i++){
				JSONObject data = (JSONObject) (itemsArray.get(i));//인덱스 번호로 접근해서 가져온다.
				
				Map<String, Object> map = new HashMap<>();
				map.put("title", data.get("message").toString());
				map.put("link", data.get("link").toString());

				JSONObject attachments = (JSONObject)data.get("attachments");
				JSONArray dataArray = (JSONArray)attachments.get("data");

				for(int j=0; j<dataArray.size(); j++) {
					JSONObject attachObj = (JSONObject) (dataArray.get(j));//인덱스 번호로 접근해서 가져온다.
					JSONObject mediaObj = (JSONObject)attachObj.get("media");
					JSONObject imageObj = (JSONObject)mediaObj.get("image");
					map.put("imgSrc", imageObj.get("src").toString());
				}
				resultList.add(map);
			}
         	resultMap.put("rows", resultList);
         	resultMap.put("result", "success");
		} catch (Exception e) {
			log.error(e.getMessage()+MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
        }
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}

	@GetMapping("/web/selectSnsInsta.do")
	public ResponseEntity<?> selectSnsInsta() throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			String userId = "7459772327411988";
			String token = "IGQWRPOUJiWE1WRmtzNy1Vak5qQWxBaVJWb0UzMTE1dnRKaXFZAaXNOS3FtOW92ZADlFbl9YejI3MEVfbGlUYmNMUlFtZAXBBQVRDb0tXUEl3QmwxSG0zQ05BNngtcXJxTFQ5SzBId18zLV9JdwZDZD";
			URL url = new URL("https://graph.instagram.com/"+userId+"/media?fields=id,media_type,media_url,permalink,thumbnail_url,username,caption&access_token="+token);

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(response.toString());

			//JSONObject  postObject = (JSONObject)jsonObject.get("data");
			JSONArray itemsArray = (JSONArray)jsonObject.get("data");

			ArrayList<Object> resultList = new ArrayList<>();
			for(int i=0;i<itemsArray.size();i++){
				JSONObject data = (JSONObject) (itemsArray.get(i));
				
				Map<String, Object> map = new HashMap<>();
				if(data.get("media_type").toString().equals("VIDEO")) {
					map.put("imgSrc", data.get("thumbnail_url").toString());
				} else {
					map.put("imgSrc", data.get("media_url").toString());
				}
				map.put("title", data.get("caption").toString());
				map.put("link", data.get("permalink").toString());
				
				resultList.add(map);
			}
         	resultMap.put("rows", resultList);
         	resultMap.put("result", "success");
		} catch (Exception e) {
			log.error(e.getMessage()+MessageCode.CMM_SYSTEM_ERROR.getLog());
			resultMap.put("notice", MessageCode.CMM_SYSTEM_ERROR.getMessage());
			return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
        }
		return new ResponseEntity<>(resultMap, HttpStatus.OK);
	}
	
	//장기실행 instagram 사용자 액세스 토큰 새로고침
	@GetMapping("/web/refreshInstaToken.do")
	public void refreshInstaToken() throws Exception {
		try {
			
			String token = "IGQWRPOUJiWE1WRmtzNy1Vak5qQWxBaVJWb0UzMTE1dnRKaXFZAaXNOS3FtOW92ZADlFbl9YejI3MEVfbGlUYmNMUlFtZAXBBQVRDb0tXUEl3QmwxSG0zQ05BNngtcXJxTFQ5SzBId18zLV9JdwZDZD";
			URL url = new URL("https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token="+token);

			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String inputLine;
			StringBuffer response = new StringBuffer();
			while((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(response.toString());
			
			System.out.print("Refresh_access_token : "+jsonObject.get("expires_in").toString());
			
		} catch (Exception e) {
			log.error(e.getMessage()+MessageCode.CMM_SYSTEM_ERROR.getLog());
        }
		
	}
	
}
