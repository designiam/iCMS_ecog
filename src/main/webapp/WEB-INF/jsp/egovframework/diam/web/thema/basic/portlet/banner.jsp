<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
				<c:choose>
					<c:when test="${fn:length(list) > 0}">
						<div class="swiper-container" id="banSlider">
							<ul class="banner_list swiper-wrapper">
							<c:forEach var="result" items ="${list}" varStatus="index">
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
