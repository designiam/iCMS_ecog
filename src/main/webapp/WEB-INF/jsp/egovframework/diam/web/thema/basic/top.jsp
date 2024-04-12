<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="layer_popup"></div>
<c:if test="${pageVO.dm_main_content eq '1' && !empty mainWrite}">
	<div class="video-banner">
		<div id="preview">
			<div class="preview-wrap">
				<video poster="<c:out value='${mainWrite.wr_path }${mainWrite.wr_background }'/>" muted="muted" autoplay="autoplay" loop="loop">
					<source src="<c:out value='${mainWrite.wr_path }${mainWrite.wr_banner }'/>" type="video/mp4">
				</video>
			</div>
			<!-- //.preview-wrap -->
			<p><c:out value="${cover.dm_title }" escapeXml="false"/></p>
			<div class="origin-wrap">
				<div id="origin">
					<div class="video-container">
						<div class="video-wrap">
							<c:set value="${fn:split(mainWrite.wr_link1, '/')}" var="videoId"/>
							<c:forEach items="${videoId }" var="i" varStatus="stat">
								<c:if test="${stat.last}">
									<c:set var="uniqId" value="${i}"/>
								</c:if>
							</c:forEach>
							<iframe src="https://www.youtube-nocookie.com/embed/<c:out value='${uniqId }'/>?controls=0&autoplay=1&mute=1&loop=1&playlist=<c:out value='${uniqId }'/>" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share;" allowfullscreen></iframe>
						</div>
						<!-- //.video-wrap -->
					</div>
					<!-- //.video-container -->
					<div class="txt">
						<div class="cate-wrap">
							<p class="cate">LIFE</p>
							<p class="date"><c:out value="${fn:substring(mainWrite.wr_datetime, 0, 10) }"/></p>
						</div>
						<div class="subject"><c:out value="${mainWrite.wr_subject }"/></div>
						<div class="content"><c:out value="${mainWrite.wr_summary }" escapeXml="false"/></div>
						<c:choose>
							<c:when test="${!empty mainWrite.wr_direct }">
								<a class="a-more-02" target="_blank" href="<c:out value='${mainWrite.wr_direct }'/>"><p>콘텐츠 바로가기</p><span></span></a>
							</c:when>
							<c:otherwise>
								<a class="a-more-02" href="?contentId=<c:out value='${mainWrite.uid }'/>&wr_id=<c:out value='${mainWrite.wr_id }'/>&command=view"><p>콘텐츠 바로가기</p><span></span></a>								
							</c:otherwise>
						</c:choose>
					</div>
					<!-- //.txt -->
				</div>
				<!-- //.origin-wrap -->
			</div>
			<button class="toggle-on"><i class="di di-arr-bot-r"></i></button>
			<!-- //#preview -->
		</div>
	</div>
	<!-- //.video-banner -->
	<script>
	var preToggle =$('#preview .toggle-on');
	var preVideo = $('#preview .preview-wrap video');
	var oriVideo = $('#origin .video-wrap iframe');
	var originWrap = $('.video-banner .origin-wrap');
	
	preToggle.click(function() {
		if (originWrap.hasClass('on')) {
			$('.video-banner').removeClass('on');
			preVideo.get(0).play();
			originWrap.removeClass('on');
		}
		else {
			preVideo.get(0).pause();
			setTimeout(function() {
				$('.video-banner').addClass('on');
				originWrap.addClass('on');
			}, 250)
		}
	});
	</script>
</c:if>

<header id="hd">
	<div class="m-vol">
		<div class="subject">계간 <b>ECO-G</b></div>
		<div class="d-flex">
			<div class="volume mr20">Vol. <b class="ml10"><c:out value="${cover.dm_vol}"/></b></div>
			<div class="date"><c:out value="${cover.dm_year }.${cover.dm_month }"/></div>
		</div>
	</div>
	<!-- //.m-vol -->
	<div id="hd_wrap">
		<div id="hd_logo">
			<c:choose>
				<c:when test="${CONFIG_INFO.dm_top_logo ne null && not empty CONFIG_INFO.dm_top_logo}">
					<a class="hd_logo_bk" href="<c:out value='${param.root }'/>/index.do">
						<img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/>
					</a>
					<%-- <c:choose>
						<c:when test="${pageVO.dm_main_content eq '1'}">
							<a class="hd_logo_bk" href="<c:out value='${param.root }'/>/index.do">
								<img src="${layout_path}/images/main/logo_ecog.png" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" />
							</a>
						</c:when>
						<c:otherwise>
							<a class="hd_logo_bk" href="<c:out value='${param.root }'/>/index.do">
								<img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/>
							</a>
						</c:otherwise>
					</c:choose> --%>
				</c:when>
				<c:otherwise>
					<a href="<c:out value='${param.root }'/>/index.do">
						<img src="<c:out value='${layout_path}'/>/images/logo.png" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>">
					</a>
				</c:otherwise>
			</c:choose>
		</div>

		<div id="hd_home">
			<ul>
				<li>
					<a href="<c:out value='${param.root }'/>/index.do" class="home">
						<i class="material-icons">home</i>
					</a>
				</li>
				<li>
					<a href="#" class="bookmark">
						<i class="material-icons">bookmark</i>
					</a>
				</li>
			</ul>
		</div>
		<c:if test="${memberConfigVO.dm_is_member eq '1'}">
		<div id="hd_user">
			<ul>
				<c:choose>
					<c:when test="${DiamLoginVO.id eq null}">
						<c:choose>
							<c:when test="${login_uid eq null}">
							<li><a href="javascript:alert('준비중입니다.');">로그인</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${login_uid}'/>">로그인</a></li>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${member_uid eq null}">
								<li><a href="javascript:alert('준비중입니다.');">회원가입</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${member_uid}'/>&command=terms">회원가입</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<li><a href="<c:out value='${param.root}'/>/web/logout.do">로그아웃</a></li>
						<c:if test="${!DiamLoginVO.is_admin}">
							<c:choose>
								<c:when test="${member_uid eq null}">
									<li><a href="javascript:alert('준비중입니다.');">정보수정</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${member_uid}'/>&command=modify&dm_no=<c:out value='${DiamLoginVO.dm_no}'/>">정보수정</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
			 		</c:otherwise>
				</c:choose>
			</ul>
		</div>
		</c:if>
		<div id="hd_navbar"></div>
		<div id="hd_etcbar"></div>
		<div id="hd_contact">
			<ul>
				<c:choose>
					<c:when test="${CONFIG_INFO.dm_tel ne null}">
						<li>
							<a class="unit-group" href="tel:<c:out value='${CONFIG_INFO.dm_tel}'/>">
								<i class="unit-stamp fa fa-fw fa-phone" aria-hidden="true"></i>
								<span class="unit-label">Call</span>
								<span class="unit-field"><c:out value='${CONFIG_INFO.dm_tel}'/></span>
							</a>
						</li>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${CONFIG_INFO.dm_ceo_email ne null}">
						<li>
							<a class="unit-group" href="mailto:<c:out value='${CONFIG_INFO.dm_ceo_email}'/>">
								<i class="unit-stamp fa fa-fw fa-envelope-o" aria-hidden="true"></i>
								<span class="unit-label">Mail</span>
								<span class="unit-field"><c:out value='${CONFIG_INFO.dm_ceo_email}'/></span>
							</a>
						</li>
					</c:when>
				</c:choose>
			</ul>
		</div>

		<div id="hd_search">
			<div class="hd_search">
				<form onsubmit="return false" class="form-inline">
					<div class="form-group m-0">
						<label for="sch_stx" class="sr-only">검색어</label>
						<input type="text" name="stx" id="sch_stx" maxlength="20" class="form-control" placeholder="검색어를 입력하세요." />
					</div>
					<button type="submit" id="sch_submit" class="btn btn-outline-secondary ml-1" data-domain="<c:out value='${CONFIG_INFO.dm_domain_id}'/>">
						<i class="fa fa-fw fa-search" aria-hidden="true"></i>
						<span class="sr-only">검색</span>
					</button>
					<button type="button" id="sch_search" class="btn btn-outline-secondary ml-1">
						<i class="fa fa-fw fa-search" aria-hidden="true"></i>
						<span class="sr-only">열기</span>
					</button>
				</form>
			</div>
		</div>

        <div id="hd_mapper">
            <button type="button" data-toggle="sitemap">
                <span class="sr-only">사이트맵 열기</span>
            </button>
        </div>
        <div id="hd_toggle">
            <button type="button" class="offcanvas-toggle" data-toggle="offcanvas" data-target="#off">
                <span class="sr-only">Toggle navigation</span>
                <span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </span>
            </button>
        </div>

		<div id="gnb">
			<div id="gnb_wrap">
				<h2 id="gnb_heading" class="sr-only">Menu</h2>
				<div id="gnb_container">
					<c:choose>
						<c:when test="${fn:length(menuList) > 0 }">
							<ul id="gnb_1dul">
								<c:forEach var="menu" items="${menuList}" varStatus="status">
									<c:if test="${menu.dm_depth eq 2 && menu.dm_menu_hidden ne '1'}">
										<li class="gnb_1dli">
											<a href='<c:out value="${menu.dm_url}"/>' class="gnb_1da" target="<c:out value='${menu.dm_link_target}'/>"><span><c:out value="${menu.dm_menu_text}" /></span></a>
											<div class="gnb_2dul_con">
												<ul class="gnb_2dul">
													<c:forEach var="subMenu" items="${menuList}" varStatus="subStatus">
														<c:if test="${menu.dm_id eq subMenu.dm_parent_id && subMenu.dm_menu_hidden ne '1'}">
															<li class="gnb_2dli">
																<a href="<c:out value='${subMenu.dm_url}' />" class="gnb_2da" target="<c:out value='${subMenu.dm_link_target}'/>"><c:out value="${subMenu.dm_menu_text}" /></a>
																<ul class="gnb_3dul">
																<c:forEach items="${menuList }" var="depth3">
																	<c:if test="${subMenu.dm_id eq depth3.dm_parent_id && depth3.dm_menu_hidden ne '1'}">
																		<li><a href="<c:out value='${depth3.dm_url }'/>" class="gnb_3da" target="${depth3.dm_link_target }"><c:out value="${depth3.dm_menu_text }"/></a>
																		</li>
																	</c:if>
																</c:forEach>
																</ul>
															</li>
														</c:if>
													</c:forEach>
												</ul>
											</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</c:when>
					</c:choose>
				</div>
				<!-- //#gnb_container -->
			</div>
			<!-- //#gnb_wrap -->
		</div>
		<!-- //#gnb -->

		<div id="hd_button">
			<ul>
				<li>
					<button type="button" class="hd_button_search">
						<i aria-hidden="true"></i>
						<span class="sr-only">검색 열기</span>
					</button>
				</li>
				<%-- <li>
					<button type="button" class="hd_button_navbar" data-toggle="sitemap">
						<i class="di di-menu" aria-hidden="true"></i>
						<span class="sr-only">사이트맵 열기</span>
					</button>
				</li> --%>
			</ul>
		</div>
		
		<div class="btn-wrap2">
			<a href="#" data-toggle="modal" data-target="#Modal" class="btn_b subscribe">구독하기</a>
			<!-- <a href="?contentId=abb7c68a0900d318989c201245657cf7433701a9ff1e317f7043ac8aaebebbb4" class="btn-sm btn-fill-02">지난호 보기</a> -->
		</div>
		
	</div>
	<!-- //#hd_wrap -->
</header>


<!-- class in -->
<div id="off" class="">
	<div id="off_wrap">
		<h2 id="off_heading" class="">
			<c:choose>
				<c:when test="${CONFIG_INFO.dm_top_logo ne null && not empty CONFIG_INFO.dm_top_logo}">
					<a href="<c:out value='${param.root }'/>/index.do">
						<img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/>
					</a> 
				</c:when>
				<c:otherwise>
					<img src="/images/no_logo.jpg" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>">
				</c:otherwise>
			</c:choose>
			
			<button type="button" class="offcanvas-toggle is-open" data-toggle="offcanvas" data-target="#off">
				<span class="sr-only">Toggle navigation</span>
				<span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</span>
			</button>
		</h2>
		<div id="off_container">
			<ul id="off_member">
				<c:choose>
					<c:when test="${DiamLoginVO.id eq null}">
						<c:choose>
							<c:when test="${login_uid eq null}">
								<li><a href="javascript:alert('준비중입니다.');">로그인</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${login_uid}'/>">로그인</a></li>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${member_uid eq null}">
								<li><a href="javascript:alert('준비중입니다.');">회원가입</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${member_uid}'/>&command=terms">회원가입</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:if test="${!DiamLoginVO.is_admin}">
							<c:choose>
								<c:when test="${member_uid eq null}">
									<li><a href="javascript:alert('준비중입니다.');">정보수정</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${member_uid}'/>&command=modify&dm_no=<c:out value='${DiamLoginVO.dm_no}'/>">정보수정</a></li>
								</c:otherwise>
							</c:choose>
						</c:if>
						<li><a href="<c:out value='${param.root}'/>/web/logout.do">로그아웃</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
			<div id="off_search">
				<div class="unified-search">
					<label><input type="text" class="unified-search-keyword" placeholder="검색어를 입력하세요."></label>
					<button class="unified-search-submit">검색</button>
				</div>
			</div>
			<c:choose>
                <c:when test="${fn:length(menuList) > 0 }">
                    <ul id="off_1dul">
                        <c:forEach var="menu" items="${menuList}" varStatus="status">
                            <c:if test="${menu.dm_depth eq '2' && menu.dm_menu_hidden ne '1'}">
                                <c:forEach var="check" items="${menuList}" varStatus="cnt">
    
                                    <c:if test="${menu.dm_id eq check.dm_parent_id && menu.dm_menu_hidden ne '1' }">
                                        <c:if test="${menu.dm_id eq check.dm_parent_id}">
                                            <c:set var="childCnt" value="${childCnt+1 }"></c:set>
                                        </c:if>
                                        <c:if test="${pageVO.dm_uid eq check.dm_link_data}">
                                            <c:set var="active" value="${active+1}" />
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                                <!-- off_1dli_active -->
                                <li class="off_1dli <c:if test="${childCnt ne null }">off_1dli_family</c:if><c:if test="${active ne null }"> off_1dli_active</c:if>">
                                    <a href="<c:out value='${menu.dm_url}'/>" class="off_1da" target="<c:out value='${menu.dm_link_target}'/>">
                                        <c:out value="${menu.dm_menu_text}" />
                                    </a>
    
                                    <ul class="<c:if test='${childCnt ne null }'>off_2dul</c:if>">
                                        <c:forEach var="subMenu" items="${menuList}" varStatus="subStatus">
                                            <c:if test="${menu.dm_id eq subMenu.dm_parent_id && subMenu.dm_menu_hidden ne '1'}">
                                                <li class="off_2dli <c:if test='${subMenu.dm_link_data eq pageVO.dm_uid }'>off_2dli_active</c:if><c:if test='${fn:substring(subMenu.dm_url,0,4) eq "http"}'>ex</c:if>">
                                                    <a href="<c:out value='${subMenu.dm_url}' />" class="off_2da" target="<c:out value='${subMenu.dm_link_target}'/>">
                                                        <c:out value="${subMenu.dm_menu_text}" />
                                                    </a>
                                                    <ul class="off_3dul">
                                                        <c:forEach var="childMenu" items="${menuList}" varStatus="subStatus">
                                                            <c:if test="${subMenu.dm_id eq childMenu.dm_parent_id && childMenu.dm_menu_hidden ne '1'}">
                                                                <li class="off_3dli <c:if test='${childMenu.dm_link_data eq pageVO.dm_uid }'>off_3dli_active</c:if>">
                                                                    <a href="<c:out value='${childMenu.dm_url}' />"  class="off_3da">
                                                                   		<c:out value="${childMenu.dm_menu_text }"/>
                                                                    </a>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                    
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <!-- off_2dli_active -->
                                    </ul>
                                </li>
                                <c:remove var="active" />
                                <c:remove var="childCnt" />
                            </c:if>
    
                        </c:forEach>
                    </ul>
                </c:when>
            </c:choose>
		</div>
	</div>
</div>

<div id="pop">
	<div id="pop_wrap">
	</div>
</div>

<div id="vis">
	<div id="vis_wrap">
		<c:forEach items="${menuList}" var="item">
			<c:if test="${pageVO.dm_uid eq item.dm_link_data }">
				<c:if test="${item.dm_depth eq 2 }">
					<c:set var="name" value="0${item.dm_menu_order }"/>				
				</c:if>
				<c:if test="${item.dm_depth eq 3 }">
					<c:forEach items="${menuList }" var="sub">
						<c:if test="${item.dm_parent_id eq sub.dm_id }">
							<c:set var="name" value="0${sub.dm_menu_order }"/>
						</c:if>
					</c:forEach>
				</c:if>
				<c:if test="${item.dm_depth eq 4 }">
					<c:forEach items="${menuList }" var="sub">
						<c:if test="${item.dm_parent_id  eq sub.dm_id}">
							<c:forEach items="${menuList }" var="subsub">
								<c:if test="${sub.dm_parent_id eq subsub.dm_id}">
									<c:set var="name" value="0${subsub.dm_menu_order }"/>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>
			</c:if>
		</c:forEach>
		<!-- 메뉴별 비주얼 이미지 설정 -->
		<c:if test="${pageVO.dm_main_content ne '1'}">
			<c:if test="${empty name}">
				<c:set var="name" value="00"/>
			</c:if>
			<c:catch var="e">
				<c:import url="/thema/basic/images/title/${name}.jpg" var="imgUrl" />
			</c:catch>
		</c:if>
		<c:choose>
			<c:when test="${pageVO.dm_main_content ne '1'}">
				<!-- 메뉴별 비주얼 이미지 설정 -->
				<div class="titler" id="titler" style="background-image: url('/thema/basic/images/title/${empty imgUrl ? '00' : name}.jpg');">
				<!-- <div class="titler" id="titler" style="background-image: url('/thema/basic/images/title/00.jpg');"> -->
				<c:forEach items="${menuList}" var="item">
					<c:if test="${item.dm_link_data eq pageVO.dm_uid}">
						<c:set var="exist" value="exist"/>
						<c:if test="${item.dm_depth eq '3' }">
							<c:forEach items="${menuList }" var="sub">
								<c:if test="${sub.dm_id eq item.dm_parent_id }">
									<h2 class="leader"><c:out value="${sub.dm_menu_text }"/></h2>
								</c:if>
							</c:forEach>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${exist ne 'exist'}">
					<h2 class="leader"><c:out value="${pageVO.dm_page_name }"/></h2>
				</c:if>
				<!-- //.leader -->
				<%-- menu depth --%>
				<c:forEach var="depth4" items="${menuList }">
					<c:if test="${pageVO.dm_uid eq depth4.dm_link_data && depth4.dm_depth ne 2}">
						<c:choose>
							<c:when test="${depth4.dm_depth eq 5 }">
								<c:set var="fourth_parent" value="${depth4.dm_parent_id}"/>
								<c:set var="fourth_text" value="${depth4.dm_menu_text}"/>
								<c:set var="fourth_id" value="${depth4.dm_id}"/>
								<c:set var="fourth_url" value="${depth4.dm_url }"/>
								<c:forEach var="depth3" items="${menuList }">
									<c:if test="${depth4.dm_parent_id eq depth3.dm_id}">
										<c:set var="third_parent" value="${depth3.dm_parent_id}"/>
										<c:set var="third_text" value="${depth3.dm_menu_text}"/>
										<c:set var="third_id" value="${depth3.dm_id}"/>
										<c:set var="third_url" value="${depth3.dm_url }"/>
										<c:forEach var="depth2" items="${menuList}">
											<c:if test="${depth3.dm_parent_id eq depth2.dm_id}">
												<c:set var="second_parent" value="${depth2.dm_parent_id }"/>
												<c:set var="second_text" value="${depth2.dm_menu_text }"/>
												<c:set var="second_id" value="${depth2.dm_id }"/>
												<c:set var="second_url" value="${depth2.dm_url }"/>
												<c:forEach var="depth1" items="${menuList}">
													<c:if test="${depth2.dm_parent_id eq depth1.dm_id }">
														<c:set var="first_parent" value="${depth1.dm_parent_id }"/>
														<c:set var="first_text" value="${depth1.dm_menu_text }"/>
														<c:set var="first_id" value="${depth1.dm_id }"/>
														<c:set var="first_url" value="${depth1.dm_url }"/>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
							</c:when>
							<c:when test="${depth4.dm_depth eq 4}">
								<c:set var="third_parent" value="${depth4.dm_parent_id}"/>
								<c:set var="third_text" value="${depth4.dm_menu_text}"/>
								<c:set var="third_id" value="${depth4.dm_id}"/>
								<c:set var="third_url" value="${depth4.dm_url }"/>
								<c:forEach var="depth3" items="${menuList }">
									<c:if test="${depth4.dm_parent_id eq depth3.dm_id}">
										<c:set var="second_parent" value="${depth3.dm_parent_id}"/>
										<c:set var="second_text" value="${depth3.dm_menu_text}"/>
										<c:set var="second_id" value="${depth3.dm_id}"/>
										<c:set var="second_url" value="${depth3.dm_url }"/>
										<c:forEach var="depth2" items="${menuList}">
											<c:if test="${depth3.dm_parent_id eq depth2.dm_id}">
												<c:set var="first_parent" value="${depth2.dm_parent_id }"/>
												<c:set var="first_text" value="${depth2.dm_menu_text }"/>
												<c:set var="first_id" value="${depth2.dm_id }"/>
												<c:set var="first_url" value="${depth2.dm_url }"/>
											</c:if>
										</c:forEach>
									</c:if>
									<c:if test="${depth4.dm_id eq depth3.dm_parent_id }">
										<c:set var="fourth_parent" value="${depth3.dm_parent_id}"/>
										<c:set var="fourth_text" value="${depth3.dm_menu_text}"/>
										<c:set var="fourth_id" value="${depth3.dm_id}"/>
										<c:set var="fourth_url" value="${depth3.dm_url }"/>
									</c:if>
								</c:forEach>
							</c:when>
							<c:when test="${depth4.dm_depth eq 3}">
								<c:set var="second_parent" value="${depth4.dm_parent_id}"/>
								<c:set var="second_text" value="${depth4.dm_menu_text}"/>
								<c:set var="second_id" value="${depth4.dm_id}"/>
								<c:set var="second_url" value="${depth4.dm_url }"/>
								<c:forEach var="depth3" items="${menuList }">
									<c:if test="${depth4.dm_parent_id eq depth3.dm_id}">
										<c:set var="first_parent" value="${depth3.dm_parent_id}"/>
										<c:set var="first_text" value="${depth3.dm_menu_text}"/>
										<c:set var="first_id" value="${depth3.dm_id}"/>
										<c:set var="first_url" value="${depth3.dm_url }"/>
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>
					</c:if>
				</c:forEach>
				<%-- end --%>
				<div class="helper">
					<c:forEach items="${menuList}" var="item">
						<c:if test="${item.dm_link_data eq pageVO.dm_uid}">
							<c:out value="${item.dm_menu_desc}"/>
						</c:if>
					</c:forEach>
				</div>
				<!-- //.helper -->
					
				<c:if test="${exist eq 'exist' }">
					<div class="segment">
						<ul>
							<li><a href="<c:out value='${param.root }'/>/index.do"><span class="sr-only">Home</span></a></li>
							<c:if test="${!empty first_id}">
								<li><a href="<c:out value='${first_url }'/>"><c:out value="${first_text }"></c:out></a></li>
								<c:if test="${!empty second_id }">
									<li><a href="<c:out value='${second_url }'/>"><c:out value="${second_text }"></c:out></a></li>
									<c:if test="${!empty third_id }">
										<li><a href="<c:out value='${third_url }'/>"><c:out value="${third_text }"></c:out></a></li>
										<c:if test="${!empty fourth_id }">
											<li><a href="<c:out value='${fourth_url }'/>"><c:out value="${fourth_text }"></c:out></a></li>
										</c:if>
									</c:if>
								</c:if>
							</c:if>
						</ul>
					</div>
				</c:if>
				<!-- //.segment -->
				
				<c:choose>
					<c:when test="${exist eq 'exist' }">
						<c:if test="${!empty first_id }">
							<div class="menutab">
								<div class="dep-wrap">
									<div class="home"><a href="<c:out value='${param.root }'/>/index.do"><span class="sr-only">홈</span></a></div>
									<div class="dep dep1">
										<div><h3><c:out value="${first_text}"/><i class="di di-arr-bot"></i></h3></div>
 										<ul>
											<c:forEach items="${menuList}" var="item">
												<c:if test="${item.dm_parent_id eq first_parent && item.dm_menu_hidden ne '1' }">
													<li class="<c:if test='${first_id eq item.dm_id }'>on</c:if>">
														<a href="<c:out value='${item.dm_url}'/>" target="<c:out value='${item.dm_link_target}'/>"><c:out value="${item.dm_menu_text }"/></a>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
									<c:if test="${!empty second_id}">
										<div class="dep dep2">
											<div><h3>${second_text }<i class="di di-arr-bot"></i></h3></div>
											<ul>
												<c:forEach items="${menuList}" var="item">
													<c:if test="${item.dm_parent_id eq second_parent && item.dm_menu_hidden ne '1'}">
														<li class="<c:if test='${second_id eq item.dm_id }'>on</c:if>">
															<a href="<c:out value='${item.dm_url}'/>" target="<c:out value='${item.dm_link_target}'/>"><c:out value="${item.dm_menu_text }"/></a>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</div>
									</c:if>
									<c:if test="${!empty third_id }">
				 						<div class="dep dep3">
											<div><h3>${third_text }<i class="di di-arr-bot"></i></h3></div>
											<ul>
												<c:forEach items="${menuList}" var="item">
													<c:if test="${item.dm_parent_id eq third_parent  && item.dm_menu_hidden ne '1'}">
														<li class='<c:if test="${third_id eq item.dm_id }">on</c:if>'>
															<a href="<c:out value='${item.dm_url}'/>" target="<c:out value='${item.dm_link_target}'/>"><c:out value="${item.dm_menu_text }"/></a>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</div>
									</c:if>
								</div>
							</div>
						</c:if>
					</c:when>
				</c:choose>
				<!-- //.menutab -->
				</div>
				<!-- //.titler -->
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${fn:length(mainVisualList) > 0}">
						<div class="swiper-container main-slide pc" id="">
							<ul class="swiper-wrapper">
								<c:forEach var="result" items="${mainVisualList}" varStatus="status">
									<c:choose>
										<c:when test="${result.dm_visual_link ne null && not empty result.dm_visual_link}">
											<li class="swiper-slide" style="background-image: url(<c:url value='/resources/main/${result.dm_visual_name}' />);">
												<a href="<c:out value='${result.dm_visual_link}'/>" target="<c:out value='${result.dm_visual_link_type}'/>">
													<img src="<c:url value='/resources/main/${result.dm_visual_name}' />" alt="<c:out value='${result.dm_visual_alt}' />" >
													<div class="main-slide-txt"><img src="${layout_path}/images/main/main_ban_txt.png" alt="" ></div>
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="swiper-slide" style="background-image: url(<c:url value='/resources/main/${result.dm_visual_name}' />);">
												<img src="<c:url value='/resources/main/${result.dm_visual_name}' />" alt="<c:out value='${result.dm_visual_alt}' />">
												<div class="main-slide-txt"><img src="${layout_path}/images/main/main_ban_txt.png" alt="" ></div>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
						</div>
						<div class="swiper-container main-slide mobile" id="">
							<ul class="swiper-wrapper">
								<c:forEach var="result" items="${mainVisualList}" varStatus="status">
									<c:choose>
										<c:when test="${result.dm_visual_link ne null && not empty result.dm_visual_link}">
											<li class="swiper-slide" style="background-image: url(<c:url value='/resources/main/${result.dm_visual_name_m}' />);">
												<a href="<c:out value='${result.dm_visual_link}'/>" target="<c:out value='${result.dm_visual_link_type}'/>">
													<img src="<c:url value='/resources/main/${result.dm_visual_name_m}' />" alt="<c:out value='${result.dm_visual_alt}' />" >
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="swiper-slide" style="background-image: url(<c:url value='/resources/main/${result.dm_visual_name_m}' />);">
												<img src="<c:url value='/resources/main/${result.dm_visual_name_m}' />" alt="<c:out value='${result.dm_visual_alt}' />">
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="no-img" style="background-image: url('<c:out value="${layout_path}"/>/images/no_visual.png');">
							<img src="<c:out value='${layout_path}'/>/images/no_visual.png" alt=""/>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="side-content">
					<div class="title">
						<div>계간 <b>ECO-G</b></div>
						<div style="letter-spacing: 0.1em;">Vol. <span class="vol"><c:out value="${cover.dm_vol }"/></span> <span class="date"><c:out value="${cover.dm_year }.${cover.dm_month }"/></span></div>
						<c:out value="" escapeXml=""/>
						<div class="logo">
							<img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/>
						</div>
					</div>
					<div class="txt">
						<c:out value="${cover.dm_content }" escapeXml="false"/>
					</div>
				</div>
				<!-- //.side-content -->
			</c:otherwise>
		</c:choose>
	</div>
</div>
<div id="main">
	<div id="container">
		<c:if test="${pageVO.dm_main_content ne '1'}">
			<div class="contentMenu">
				<h3><c:out value="${pageVO.dm_page_name }"/></h3>
			</div>
			<div class="contentWrap">
				<div class="heading">
					<%-- <h3>${pageVO.dm_page_name }</h3> --%>
					<h3>${second_text }</h3>
					<p class="description"></p>
				</div>
				
				<c:choose>
					<c:when test="${exist eq 'exist' }">
						<c:if test="${!empty first_id }">
							<div class="tablist">
								<c:if test="${!empty third_id }">
									<ul class="tablist_3d">
										<c:forEach items="${menuList}" var="item">
											<c:if test="${item.dm_parent_id eq third_parent  && item.dm_menu_hidden ne '1'}">
												<li class="<c:if test="${third_id eq item.dm_id }">on</c:if>" >
													<a href="<c:out value='${item.dm_url}'/>" target="<c:out value='${item.dm_link_target}'/>"><c:out value="${item.dm_menu_text }"/></a>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
								<c:if test="${!empty fourth_id }">
									<ul class="tablist_4d">
										<c:forEach items="${menuList}" var="item">
											<c:if test="${item.dm_parent_id eq fourth_parent  && item.dm_menu_hidden ne '1'}">
												<li class="<c:if test="${fourth_id eq item.dm_id }">on</c:if>" >
													<a href="<c:out value='${item.dm_url}'/>" target="<c:out value='${item.dm_link_target}'/>"><c:out value="${item.dm_menu_text }"/></a>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</div>
						</c:if>
					</c:when>
				</c:choose>
				<div class="contentContainer">
		</c:if>
<script>
	$(function(){
		var target = $(".gnb_3dul");
		for (var i = 0; i < target.length; i++) {
			if ($(target[i]).children().length == 0) {
				$(target[i]).remove();
			}
		}
		
		setFont($("#gnb_1dul").find("li a span, li a"));
		setFont($(".dep-wrap").find("li a"));
		setFont($("#off_1dul").find("li a"));
		
	});
	
	function setFont(data) {
		$.each(data, function(i, obj){
			var txt = $(obj).text();
			txt = txt.replace(/\s/g, "");
			if (checkEng(txt)) {
				$(obj).css("font-family", "'Poppins',sans-serif");
			} else if (checkKor(txt)) {
				$(obj).css("font-family", "'Poppins',sans-serif");
			} else {
				//디폴트 font
				$(obj).css("font-family", "'Poppins',sans-serif");
			}
		});
	}
	
	// 영문(영어) 체크
	function checkEng(str){
	    var regExp = /^[a-z|A-Z|\-]+$/; // 영어
	    return regExp.test(str) ? true : false;
	}
	// 한글 체크
	function checkKor(str) {
	    var regExp = /^[가-힣|\-]+$/;
	    return regExp.test(str) ? true : false;
	}
	
</script>

<%--<div class="overlay"></div>
 <c:if test="${pageVO.dm_main_content ne '1'}">
    <c:import url="/web/frame_top.sub.do" />
</c:if> --%>