<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:choose>
	<c:when test="${fn:length(list) > 0}">
		<ul>
		<c:forEach var="result" items ="${list}" varStatus="index">
			<li>
				<a href="<c:out value='${param.root }'/>/index.do?command=view&wr_id=<c:out value='${result.wr_id}'/>&<c:out value='${writeSearchQueryString}' escapeXml='false'/>">
					<div class="img">
					<c:choose>
						<c:when test="${empty result.wr_thumb }">
							<div class="thumb-wrap noimg" style="width: 100%; padding-top: ${ratio }%; background-image: url('/images/no_image.png');">
								<img src="/images/no_image.png" alt="no image">
							</div>
						</c:when>
						<c:otherwise>
							<div class="thumb-wrap" style="width: 100%; padding-top: ${ratio }%; background-image: url('<c:out value='${result.wr_path}${result.wr_thumb_sub}'/>');">
								<img src="<c:out value='${result.wr_path}${result.wr_thumb_sub}'/>" alt="<c:out value='${result.wr_subject}' escapeXml='false'/>" onerror="this.src='/images/no_image.png'">
							</div>
						</c:otherwise>
					</c:choose>
					</div>
					<div class="con_txt">
						<p class="tit t02"><c:out value="${result.wr_subject}" escapeXml='false'/></p>
						<div class="bot">
							<p class="vol">vol. <c:out value="${result.wr_vol}" escapeXml='false'/></p>
							<c:if test="${!empty result.wr_hashtag}">
							<p class="tag_con">
							<c:set value="${fn:split(result.wr_hashtag, '#')}" var="hashtag"/>
							<c:set var="tag_count" value="0"/>
							<c:forEach items="${hashtag }" var="tag" varStatus="stat">
							<c:if test="${!empty fn:trim(tag) and tag_count < 3 }">
							<span class="tag">#<c:out value="${fn:trim(tag)}" escapeXml='false'/></span>
							<c:set var="tag_count" value="${tag_count+1 }"/>
							</c:if>
							</c:forEach>
							</p>
							</c:if>
						</div>
					</div>
				</a>
			</li>
		</c:forEach>
		</ul>
	</c:when>
	<c:otherwise>
		<p class="empty"><img src="../images/noimg_content.jpg" alt="콘텐츠가 없습니다."></p>
	</c:otherwise>
</c:choose>
