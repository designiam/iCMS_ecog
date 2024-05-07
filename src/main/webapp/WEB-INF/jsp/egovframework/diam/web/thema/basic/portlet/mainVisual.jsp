<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<div class="swiper-wrapper" id="top_banner_pc">
			<c:forEach var="result" items ="${list}" varStatus="index">
				<c:choose>
					<c:when test="${result.dm_visual_link ne null && not empty result.dm_visual_link}">
						<c:if test="${result.dm_status eq 1 }">
						<div class="swiper-slide" style="background-image: url('/resources/mainr/${result.dm_visual_name}');">
							<a href="${result.dm_visual_link}" target="${result.dm_visual_link_type}">
								<img src="/resources/main/${result.dm_visual_name}" alt="${result.dm_visual_alt}">
							</a>
						</div>
						</c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${result.dm_status eq 1 }">
						<div class="swiper-slide" style="background-image: url('/resources/main/${result.dm_visual_name}');">
							<img src="/resources/main/${result.dm_visual_name}" alt="${result.dm_visual_alt}">
						</div>
						</c:if>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div class="swiper-wrapper" id="top_banner_m">
			<c:forEach var="result" items ="${list}" varStatus="index">
				<c:choose>
					<c:when test="${result.dm_visual_link ne null && not empty result.dm_visual_link}">
						<div class="swiper-slide" style="background-image: url('/resources/mainr/${result.dm_visual_name_m}');">
							<a href="${result.dm_visual_link}" target="${result.dm_visual_link_type}">
								<img src="/resources/main/${result.dm_visual_name_m}" alt="${result.dm_visual_alt}">
							</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="swiper-slide" style="background-image: url('/resources/main/${result.dm_visual_name_m}');">
							<img src="/resources/main/${result.dm_visual_name_m}" alt="${result.dm_visual_alt}">
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-button-next"></div>
	</c:when>
	<c:otherwise>
		<div class="no-img" style="background-image: url('/images/no_image.png');">
			<img src="/images/no_image.png" alt="등록된 배너가 없습니다."/>
		</div>
	</c:otherwise>
</c:choose>

				