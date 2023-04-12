<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section id="latest_list">
	<h2>iCMS 소식</h2>
	<p class="sub_copy">새로운 소식을 전해드립니다.</p>
	<div class="mt50">
		<div class="latest_contents">
			<div class="board_list_wrap">
				<h4 class="sr-only">최근 게시글 리스트</h4>
				<c:if test="${!empty writeMap }">
					<c:forEach items="${writeMap }" var="entry" varStatus="status">
					 	<div class="latest_box <c:out value='${status.count eq 1 ? "active" : ""}'/>">
					 		<h5><a onclick="javascript:clickMiniBoard(this)"><c:out value="${writeMap[entry.key][0].dm_table_text}"/></a></h5>
					 		<ul>
					 			<c:choose>
									<c:when test="${fn:length(writeMap[entry.key]) > 0 and !empty writeMap[entry.key][0].wr_id}">
								 		<c:forEach var="item" items="${writeMap[entry.key]}">
								 			<li>
								 				<a href="/index.do?contentId=<c:out value='${item.uid }'/>&command=view&wr_id=<c:out value='${item.wr_id }'/>"><c:out value="${item.wr_subject }" escapeXml="false"/></a>
												<span>
									 				<fmt:parseDate value="${item.wr_datetime}" var="registered" pattern="yyyy-MM-dd HH:mm:ss" />
													<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
												</span>
								 			</li>
								 		</c:forEach>
									</c:when>
									<c:otherwise>
										<li>게시글이 없습니다.</li>
									</c:otherwise>
					 			</c:choose>
					 		</ul>
					 		<a href="?contentId=<c:out value='${writeMap[entry.key][0].uid}'/>" class="a-more-05" title="페이지 이동"><span></span></a>
					 	</div>
					</c:forEach>
				</c:if>
			</div>
			
			<div class="banner_list_wrap">
				<h4>배너존</h4>
				<div class="swiper-button-next"><img src="${layout_path}/images/swiper_arrow.png"></div>
				<div class="swiper-button-prev"><img src="${layout_path}/images/swiper_arrow.png"></div>
				<c:choose>
					<c:when test="${fn:length(bannerList) > 0}">
						<div class="swiper-container" id="banSlider">
							<ul class="banner_list swiper-wrapper">
							<c:forEach var="result" items ="${bannerList}" varStatus="index">
								<c:choose>
									<c:when test="${result.dm_link ne null && not empty result.dm_link}">
										<li class="swiper-slide" style="background-image: url('/resources/banner/${result.dm_banner_img}');">
											<a href="${result.dm_link}" target="${result.dm_link_type}">
												<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
											</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="swiper-slide" style="background-image: url('/resources/banner/${result.dm_banner_img}');">
											<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="no-img" style="background-image: url('/images/no_image.png');">
							<img src="/images/no_image.png" alt="등록된 배너가 없습니다."/>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</section>

<script>
function clickMiniBoard($this){
	$(".latest_box").removeClass("active");
	$($this).parent().parent().addClass("active");
}
</script>