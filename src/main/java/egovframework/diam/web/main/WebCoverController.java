package egovframework.diam.web.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.biz.service.main.CoverService;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class WebCoverController {

	@Autowired private CoverService coverService;
	@Autowired private WriteService writeService;
}
