<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

		<c:if test="${pageVO.dm_main_content ne '1'}">
				</div>
			</div>
		</c:if>
	</div>
</div>
<c:set value="${param.command}" var="comm"/>
<c:set value="${pageVO.dm_page_type eq 'BOARD' ? ((!empty comm || comm eq 'list') ? true: false) : ((pageVO.dm_page_name eq '이벤트' || pageVO.dm_page_name eq '지난호 보기') ? false : true) }" var="quick"/>
<c:if test="${pageVO.dm_main_content ne '1' && quick}">
<div class="scroll_right_cont">
	<h5>함께보는 <br><b>ECO-G</b></h5>
	<ul>
		<li class="float01">
			<a href="https://up.gjto.or.kr/" target="_blank">
				<img src="${layout_path}/images/icon_quick01.png" alt="카카오톡 채널" />
			</a>
		</li>
		<li class="float02">
			<a href="https://www.facebook.com/ecogwangju" target="_blank">
				<img src="${layout_path}/images/icon_quick02.png" alt="페이스북" />
			</a>
		</li>
		<li class="float03">
			<a href="https://twitter.com/kecotwt"  target="_blank">
				<img src="${layout_path}/images/icon_quick03.png" alt="트위터">
			</a>
		</li>
		<li class="float04">
			<button type="button" onclick="copyUrl()">
				<img src="${layout_path}/images/icon_quick04.png" alt="URL 공유">
			</button>
		</li>
	</ul>
</div>

<script>
//url 복사
let nowUrl = window.location.href;

function copyUrl(){
    navigator.clipboard.writeText(nowUrl).then(res=>{
        alert("주소가 복사되었습니다!");
    })
}
</script>
</c:if>

<footer id="ft">
	<div id="ft_wrap">
		<div id="ft_sign">
			<c:choose>
				<c:when test="${CONFIG_INFO.dm_bottom_logo ne null && not empty CONFIG_INFO.dm_bottom_logo}">
					<a class="ft_logo_bk" href="/index.do">
						<img src="<c:out value='${CONFIG_INFO.dm_bottom_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/>
					</a>
				</c:when>
				<c:otherwise>
					<a class="ft_logo_bk" href="/index.do">
						<img src="<c:out value='${layout_path}'/>/images/logo.png" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>">
					</a>
				</c:otherwise>
			</c:choose>
		</div>
		<div id="ft_info">
			<div class="ft_info ft_comp">
				<h3><c:out value="${CONFIG_INFO.dm_company_name}" escapeXml="false"/></h3>
				<ul>
					<c:if test="${CONFIG_INFO.dm_company_name ne null}">
						<li class="cp_com">
							<dl>
								<dt>회사명</dt>
								<dd><c:out value="${CONFIG_INFO.dm_company_name}" escapeXml="false"/></dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${CONFIG_INFO.dm_ceo ne null}">
						<li class="cp_owner">
							<dl>
								<dt>대표자</dt>
								<dd><c:out value="${CONFIG_INFO.dm_ceo}" escapeXml="false"/></dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${CONFIG_INFO.dm_addr1 ne null}">
						<li class="cp_addr">
							<dl>
								<dt>주소</dt>
								<dd>
									<c:out value="${CONFIG_INFO.dm_zip}" escapeXml="false"/>
					    			<c:out value="${CONFIG_INFO.dm_addr1}" escapeXml="false"/>
					    			<c:out value="${CONFIG_INFO.dm_addr2}" escapeXml="false"/>
					    			<c:out value="${CONFIG_INFO.dm_addr3}" escapeXml="false"/>
								</dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${CONFIG_INFO.dm_company_number ne null}">
						<li class="cp_biz">
							<dl>
								<dt>사업자등록번호</dt>
								<dd><c:out value="${CONFIG_INFO.dm_company_number}" escapeXml="false"/></dd>
							</dl>
						</li>	
					</c:if>
					<c:if test="${CONFIG_INFO.dm_tel_company_number ne null}">
						<li class="cp_tno">
							<dl>
								<dt>통신판매업신고번호</dt>
								<dd><c:out value="${CONFIG_INFO.dm_tel_company_number}" escapeXml="false"/></dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${CONFIG_INFO.dm_tel ne null}">
						<li class="cp_tel">
							<dl>
								<dt>TEL.</dt>
								<dd><c:out value="${CONFIG_INFO.dm_tel}" escapeXml="false"/></dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${CONFIG_INFO.dm_ceo_email ne null}">
						<li class="cp_email">
							<dl>
								<dt>이메일</dt>
								<dd><c:out value="${CONFIG_INFO.dm_ceo_email}" escapeXml="false"/></dd>
							</dl>
						</li>
					</c:if>
					<c:if test="${CONFIG_INFO.dm_fax ne null}">
						<li class="cp_fax">
							<dl>
								<dt>FAX.</dt>
								<dd><c:out value="${CONFIG_INFO.dm_fax}" escapeXml="false"/></dd>
							</dl>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
		<div class="ft_info ft_menu">
		</div>
		
		<div id="ft_family">
		</div>
		
		<div id="ft_social">
		</div>
		
		<div id="ft_link">
			<h3>Clause</h3>
			<ul>
				<c:if test="${CONFIG_INFO.dm_policy_status eq '1' }">
					<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${clause_uid }'/>&command=policy" data-clause="provision">이용약관</a></li>
				</c:if>
				<c:if test="${CONFIG_INFO.dm_private_status eq '1' }">
					<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${clause_uid }'/>&command=privacy" data-clause="privacy">개인정보처리방침</a></li>
				</c:if>
				<c:if test="${CONFIG_INFO.dm_reject_status eq '1' }">
					<li><a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${clause_uid }'/>&command=reject" data-clause="rejection">이메일무단수집거부</a></li>
				</c:if>
			</ul>
		</div>
		
		<div id="ft_copy">Copyright (c) 2023, <c:out value="${CONFIG_INFO.dm_company_name}"/>. All Rights Reserved.</div>
	</div>
	
	<div id="ft_goto">
		<a href="https://www.eco-g.or.kr/" target="_blank" id="shortcut">
			<img src="${layout_path}/images/logo_ecog.png" alt="">
			<p><small>ECO-G</small>바로가기</p>
		</a>
		<a href="#root" id="totop" class="totop" title="페이지의 최상단으로 이동"><i class="di di-arr-top"></i></a>
	</div>
</footer>
</div>

<div class="dm-sitemap" id="dm-sitemap">
	<div class="dm-sitemap-header">
		<c:choose>
			<c:when test="${CONFIG_INFO.dm_top_logo ne null && not empty CONFIG_INFO.dm_top_logo}">
				<a class="hd_logo_bk" href="/index.do">
					<img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/>
				</a>
				
			</c:when>
			<c:otherwise>
				<a class="hd_logo_bk" href="/index.do">
					<img src="<c:out value='${layout_path}'/>/images/logo.png" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" >
				</a>
			</c:otherwise>
		</c:choose>
		<button type="button" class="dm-sitemap-close"><span class="sr-only">닫기</span></button>
	</div>
	<div class="dm-sitemap-body">
		<c:choose>
			<c:when test="${fn:length(menuList) > 0 }">
				<ul>
					<c:forEach var="menu" items="${menuList}" varStatus="status">
						<c:if test="${menu.dm_depth eq 2 && menu.dm_menu_hidden ne '1'}">
							<li>
								<a href='<c:out value="${menu.dm_url}"/>' class="gnb_1da" target="<c:out value='${menu.dm_link_target}'/>"><c:out value="${menu.dm_menu_text}" />
									<span></span>
									<span class="dm-sitemap-menu-circle"><i></i><i></i></span>
								</a>
								<ul>
									<c:forEach var="subMenu" items="${menuList}" varStatus="subStatus">
										<c:if test="${menu.dm_id eq subMenu.dm_parent_id}">
											<li class="">
												<a href='<c:out value="${subMenu.dm_url}" />' class="gnb_2da" target="<c:out value='${subMenu.dm_link_target}'/>"><c:out value="${subMenu.dm_menu_text}" /></a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</c:when>
		</c:choose>
	</div>
	<div class="dm-sitemap-footer">
		Copyright (c) 2023, (주)디자인아이엠. All Rights Reserved.
	</div>
</div>


</body>
</html>