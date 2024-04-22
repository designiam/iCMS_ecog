package egovframework.diam.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.diam.biz.model.config.Dm_config_vo;
import egovframework.diam.biz.model.design.Dm_banners_vo;
import egovframework.diam.biz.model.display.Dm_layout_vo;
import egovframework.diam.biz.model.board.Dm_write_vo;
import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.biz.service.design.BannerService;
import egovframework.diam.cmm.util.CommonUtil;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class PortletController {

	@Autowired private WriteService writeService;

	@Autowired private BannerService bannerService;

	CommonUtil commonUtil = new CommonUtil();

	/**
	 * get 방식의 호출 
	 * 리스트를 호출한다.
	 * 
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/portlet.do"})
	public ModelAndView main(HttpServletRequest request, @RequestParam HashMap<String, Object> paramMap) throws Exception{
		ModelAndView result = new ModelAndView();
		Dm_config_vo configVO = (Dm_config_vo) request.getAttribute("CONFIG_INFO");
		Dm_layout_vo layoutVO = (Dm_layout_vo) request.getAttribute("layoutVO");
		
		if( "board".equals(commonUtil.nullString(paramMap.get("MODE"))) ) {
			Dm_write_vo  vo = new Dm_write_vo();
			if(!commonUtil.isNull(paramMap.get("ID"))) {
				vo.setSearch_board(commonUtil.nullString(paramMap.get("ID")));
			}
			if(!commonUtil.isNull(paramMap.get("VOL"))) {
				vo.setWr_vol(commonUtil.nullString(paramMap.get("VOL")));
			}
			if(!commonUtil.isNull(paramMap.get("SORT"))) {
				vo.setSort(commonUtil.nullString(paramMap.get("SORT")));
			}
			vo.setRows(commonUtil.nullInt(paramMap.get("LAST")));
			vo.setPage(1);
			List<Dm_write_vo> resultList = writeService.selectWriteListForWeb(vo);
			result.addObject("list", resultList);
		}
		else if( "banner".equals(commonUtil.nullString(paramMap.get("MODE"))) ) {
			Dm_banners_vo  vo = new Dm_banners_vo();
			vo.setDm_domain(configVO.getDm_domain_id());
			result.addObject("list", bannerService.selectBannerListForWeb(vo));
		}
		result.setViewName("egovframework/diam/web/thema/" + layoutVO.getDm_layout_folder() + "/" +paramMap.get("VIEW"));
		return result;
	}
}