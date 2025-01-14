<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

		<c:if test="${pageVO.dm_main_content ne '1'}">
				</div>
			</div>
		</c:if>
	</div>
</div>

<!-- 뉴스레터구독// -->
<c:if test="${pageVO.dm_main_content ne '1'}">
<div class="bot_subscribe">
	<div class="inner">
		<div class="con_txt">
			<p class="txt">환경소식을 빠르게 만나는 방법!</p>
			<p class="tit">함께 GREEN 광주 구독하기</p>
			<p class="btn_con"><a href="#" data-toggle="modal" data-target="#Modal" class="btn_go">뉴스레터 구독 <i class="fas fa-thin fa-arrow-right"></i></a></p>
		</div>
	</div>
</div>
</c:if>
<!-- //뉴스레터구독 -->
		
<%-- <c:set value="${param.command}" var="comm"/>
<c:set value="${pageVO.dm_page_type eq 'BOARD' ? ((!empty comm && comm ne 'list') ? true: false) : ((pageVO.dm_page_name eq '이벤트' || pageVO.dm_page_name eq '지난호 보기') ? false : true) }" var="quick"/>
<c:if test="${pageVO.dm_main_content ne '1' && quick}">
<div class="scroll_right_cont">
	<h5>함께보는 <br><b>ECO-G</b></h5>
	<ul>
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
			<a href="https://www.instagram.com/ecogwangju_official"  target="_blank">
				<img src="${layout_path}/images/icon_quick08.png" alt="인스타그램">
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
</c:if> --%>

<%-- <c:if test="${pageVO.dm_main_content eq '1'}">
	<div class="scroll_right_cont main">
		<ul>
			<li class="float01">
				<button type="button" class="" data-toggle="modal" data-target="#Modal">
					<img src="${layout_path}/images/icon_quick05.png" alt="" />
					<span><small>ECO-G 웹진</small>정기구독</span>
				</button>
			</li>
			<li class="float02">
				<a href="?contentId=8180651d8a732fbb4725b901344c433690e13340dae9f2585414d363ee17aaf0">
					<img src="${layout_path}/images/icon_quick06.png" alt="" />
					<span><small>구독자 의견</small>바로가기</span>
				</a>
			</li>
			<li class="float03">
				<a href="https://www.eco-g.or.kr/" target="_blank">
					<img src="${layout_path}/images/icon_quick07.png" alt="">
					<span><small>ECO-G</small>바로가기</span>
				</a>
			</li>
		</ul>
	</div>
</c:if> --%>

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
<div class="modal fade subscribe" id="Modal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title logo-title">
					<div class="logo"><img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/></div>
					<div>
						지금 <b>환경공단웹진</b>을 <b>구독해보세요!</b>
						<small>간편하게 만나는 함께그린광주</small>
					</div>
				</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<div class="modal-form">
					<div class="form-group">
						<label class="sr-only" for="subscribe_dm_name">이름 <span class="required">필수</span></label>
						<input type="text" name="dm_name" id="subscribe_dm_name" class="form-control" maxlength="30" autocomplete="off" placeholder="이름">
					</div>
					<div class="form-group">
						<label class="sr-only" for="subscribe_dm_email">이메일<span class="required">필수</span></label>
						<div class="form-row align-items-center">
							<div class="col">
								<label for="subscribe_dm_email" class="sr-only">이메일</label>
								<input type="text" id="subscribe_dm_email" class="form-control" maxlength="80" autocomplete="off" placeholder="이메일">
							</div>
						</div>
					</div>
				</div>
				<div class="mb_agree">
					<div class="agree_docs">
						<h4>개인정보 수집 및 활용 동의<span class="required">필수</span></h4>
						<div class="agree_text clause">
							<%-- <c:out value="${CONFIG_INFO.dm_private_text}" escapeXml="false"/> --%>
							<p class="text">광주환경공단은 환경소식지 발송을 위해 필요한 최소한의 개인정보를 아래와 같이 수집&middot;이용하고 있습니다.</p>
							<ul class="list_style">
								<li>수집 목적 : 환경소식지 발송</li>
								<li>수집 항목 : 제안
									<ul class="list_style2">
										<li>웹진발송 : 이름, 이메일</li>
										<li>책자 발송 : 이름, 주소</li>
									</ul>
								</li>
								<li>보유 이용기간 : <strong class="point">환경소식지 수신 철회 시, 환경 소식지 반송 시</strong></li>
							</ul>
							<p class="text">※ 정보주체께서는 개인정보 수집&middot;이용 동의를 거부할 권리가 있으며, 동의를 거부할 경우에는 환경소식지 수신이 어렵습니다.</p>
						</div>
						<div class="custom-control custom-checkbox agree_check">
							<p>☞ 개인정보 수집•이용에 동의하시겠습니까?</p>
							<div class="agree_radio">
								<span>
									<input type="radio" id="subscribe_agreeYN1" name="subscribe_agreeYN" value="y" />
									<label for="subscribe_agreeYN1">동의</label>
								</span>
								<span>
									<input type="radio" id="subscribe_agreeYN2" name="subscribe_agreeYN" value="n" />
									<label for="subscribe_agreeYN2">동의하지 않음</label>
								</span>
							</div>
							<p>(동 서비스는 만14세 이상에게 제공합니다. 필요한 경우에는 법정대리인을 통해 신청해 주시기 바랍니다.)</p>
							<div class="all_check">
								<input type="checkbox" id="subscribe_dm_agree2" class="custom-control-input dm_check"  value="개인정보처리방침" />
								<label for="subscribe_dm_agree2" class="custom-control-label" >환경소식지 수신에 동의합니다.</label>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="subscribe_submit btn-lg btn-fill-03" data-val="Y">구독신청</button>
				<button type="button" class="subscribe_submit btn-lg btn-fill-04" data-val="N">구독해지</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade subscribe" id="subModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<div class="logo">
					<img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/>
				</div>
				<p></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn-lg btn-fill-03" data-dismiss="modal">확인</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
<script>
$(function(){	
	// modal fade in 리스너
	$("#Modal").on("show.bs.modal", function(){
		$("#subscribe_dm_name").val("");
		$("#subscribe_dm_email").val("");
		$("#subscribe_dm_agree2").prop("checked", false);
	});
	
	//제출 리스너
	$(".subscribe_submit").on("click", function(){
		var txt = $(this).text();
		var type = $(this).data("val");
		
		if (type == "" || type == null) {
			alert("잘못된 접근입니다. 새로고침 후 다시 시도해주세요.");
			location.reload();
		}
		//구독신청이면
		if(type == "Y") {
			//개인정보수입이용동의 체크 확인
			var agreeYN = $('input[name="subscribe_agreeYN"]:checked').val();
			if (agreeYN != "y") {
				alert("개인정보 수집•이용 동의 후 이용가능합니다.");
				return;
			}
			//환경소식지 수신 동의
			var agr = $("#subscribe_dm_agree2").prop("checked");
			if (!agr) {
				alert("환경소식지 수신에 동의 후 이용가능합니다.");
				return;
			}
			
		} else if(type == "N") { //구독해지이면
			//개인정보수입이용동의 체크 확인
			var agreeYN = $('input[name="subscribe_agreeYN"]:checked').val();
			if (agreeYN != "y") {
				alert("개인정보 수집•이용 동의 후 이용가능합니다.");
				return;
			}
		}
		
		//이름
		var name = $.trim($("#subscribe_dm_name").val());
		if (name == "") {
			alert("이름은 필수 입력입니다.");
			$("#subscribe_dm_name").focus();
			return;
		}
		
		// 이메일 유효성
		var mail = $.trim($("#subscribe_dm_email").val());
		var emailChk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; //이메일 정규식
		var dotCount = mail.match(/\./g);
		if (!emailChk.test(mail) || dotCount == null || dotCount.length > 2) {
			alert("이메일 형식이 잘못됐습니다.");
			$("#subscribe_dm_email").focus();
			return;
		}
		
		var conf = confirm(txt + " 하시겠습니까?");
		
		if (conf) {
			var setting = {
				url : "/web/requestSubscribe.do",
				data : {
					dm_name : name,
					dm_email : mail,
					dm_status : type
				},
				type : "post"
			}
			
			sendRequest(setting);
		}
	});

});

//async 함수
var subModal = $("#subModal .modal-body p");
var sendRequest = function(set) {
	$.ajax(set).done(function(response){
		//alert(response.notice);
		$('#Modal').modal('hide');
		subModal.html(response.notice);
		setTimeout(function(){
			$('#subModal').modal('show');
		},500);
		
		//if (response.result == "success") {
		//	$(".close").trigger("click");
		//}
		
	}).fail(function(response, status, error){
		//alert(response.responseJSON.notice);
	});
}

</script>
</html>