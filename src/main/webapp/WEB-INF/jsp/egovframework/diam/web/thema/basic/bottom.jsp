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
<c:set value="${pageVO.dm_page_type eq 'BOARD' ? ((!empty comm && comm ne 'list') ? true: false) : ((pageVO.dm_page_name eq '이벤트' || pageVO.dm_page_name eq '지난호 보기') ? false : true) }" var="quick"/>
<c:if test="${pageVO.dm_main_content ne '1' && quick}">
<div class="scroll_right_cont">
	<h5>함께보는 <br><b>ECO-G</b></h5>
	<ul>
		<li class="float01">
			<button type="button" class="" data-toggle="modal" data-target="#Modal">구독 신청</button>
		</li>
		<li class="float01">
			<a href="https://pf.kakao.com/_lxegxnxb" target="_blank">
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
var nowUrl = window.location.href;

function copyUrl(){
    navigator.clipboard.writeText(nowUrl).then(function(res){
        alert("주소가 복사되었습니다!");
    });
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


<!-- Modal -->
<div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title">구독 신청</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body">
			<div>
				<div class="form-group">
					<label for="dm_name">이름 <span class="required">필수</span></label>
					<input type="text" name="dm_name" id="dm_name" value="최은빈" class="form-control" maxlength="30" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="dm_email1">이메일<span class="required">필수</span></label>
					<div class="form-row align-items-center">
						<div class="col col-4">
							<label for="dm_email1" class="sr-only">메일 아이디</label>
							<input type="text" id="dm_email1" class="form-control">
						</div>
						<div class="col-auto">@</div>
						<div class="col">
							<label for="dm_email2" class="sr-only">메일주소</label>
							<input type="text" id="dm_email2" class="form-control">
						</div>
						<input type="hidden" id="dm_email" name="dm_email">
					</div>
				</div>
			</div>
			<div class="mb_agree">
				<div class="agree_docs">
					<h4 class="">개인정보처리방침<span class="required">필수</span></h4>
					<div class="agree_text clause">${CONFIG_INFO.dm_private_text}</div>
					<div class="custom-control custom-checkbox agree_check">
						<input type="checkbox" name="" id="dm_agree2" class="custom-control-input dm_check"  value="개인정보처리방침" />
						<label for="dm_agree2" class="custom-control-label" >위 개인정보처리방침에 동의합니다.</label>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="">보내기</button>
			<button type="button" class="" data-dismiss="modal">취소</button>
		</div>
    </div>
  </div>
</div>




</body>
</html>