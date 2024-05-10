<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	Date today = new Date();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
	String curDate = transFormat.format(today);
%>
<%@ include file="base.jsp"%>
<c:set var="page" value="${param.page eq null ? 1 : param.page}"/>
<c:set var="curDate" value="<%=curDate%>"/>
<c:set var="ratio" value="${boardVO.dm_gallery_height / boardVO.dm_gallery_width * 100}"/>

<c:if test="${boardVO.dm_header_content ne null && boardVO.dm_header_content ne ''}">
	<c:out value="${boardVO.dm_header_content}" escapeXml="false"/>
</c:if>

<!-- bbs// --> 
<div class="bbs bbs_list bbs_<c:out value='${boardVO.dm_skin }'/>" id="bbs_<c:out value='${boardVO.dm_table }'/>">
<c:choose>
	<c:when test="${fn:length(writeList) > 0}">	
	<div class="event-wrap">
		<c:forEach var="result" items="${writeList}" varStatus="status">
		<c:choose>
			<c:when test="${!empty result.wr_start_dt && !empty result.wr_end_dt }">
				<c:choose>
					<c:when test='${curDate le result.wr_start_dt }'>
						<c:set var="status_name" value="대기" />
						<c:set var="status_class" value=" proceed" />
					</c:when>
					<c:when test='${curDate ge result.wr_start_dt && curDate le result.wr_end_dt }'>
						<c:set var="status_name" value="진행중" />
						<c:set var="status_class" value=" proceed" />
					</c:when>
					<c:otherwise>
						<c:set var="status_name" value="종료" />
						<c:set var="status_class" value="" />
					</c:otherwise>
				</c:choose>
				<div class="event-item">
					<a href="<c:out value='${param.root }'/>/index.do?command=view&wr_id=<c:out value='${result.wr_id}'/>&<c:out value='${writeSearchQueryString}' escapeXml='false'/>">
						<div class="thumb-container">
						<c:choose>
							<c:when test="${empty result.wr_thumb }">
								<div class="thumb-wrap noimg" style="width: 100%; padding-top: ${ratio }%; background-image: url('/images/no_image.png');">
									<p class="img"><img src="/images/no_image.png" alt="no image"></p>
									<p class="label<c:out value='${status_class }'/>"><c:out value="${status_name}"/></p>
								</div>
							</c:when>
							<c:otherwise>
								<div class="thumb-wrap" style="background-image: url('<c:out value='${result.wr_path}${result.wr_thumb_sub}'/>');">
									<p class="img"><img src="<c:out value='${result.wr_path}${result.wr_thumb_sub}'/>" alt="<c:out value='${result.wr_subject}' escapeXml='false'/>" onerror="this.src=\'/thema/basic/images/pages/no_image.png\'"></p>
									<p class="label<c:out value='${status_class }'/>"><c:out value="${status_name}"/></p>
								</div>
							</c:otherwise>
						</c:choose>
						</div>
						<div class="event-txt">
							<div class="title"><c:out value='${result.ca_name}'/></div>
							<div class="subject"><c:if test="${!empty status_name }"><span class="label">[<c:out value="${status_name }"/>]</span> </c:if><c:out value="${result.wr_subject}" escapeXml='false'/></div>
						</div>
					</a>
				</div>				
			</c:when>
			<c:otherwise>
				<div class="event-item">
					<a href="<c:out value='${param.root }'/>/index.do?command=view&wr_id=<c:out value='${result.wr_id}'/>&<c:out value='${writeSearchQueryString}' escapeXml='false'/>">
						<div class="thumb-container">
							<c:choose>
							<c:when test="${empty result.wr_thumb }">
								<div class="thumb-wrap noimg" style="width: 100%; padding-top: ${ratio }%; background-image: url('${layout_path}/images/pages/no_image.png');">
									<p class="img"><img src="${layout_path}/images/pages/no_image.png" alt="no image"></p>
									<p class="label"></p>
								</div>
							</c:when>
							<c:otherwise>
								<div class="thumb-wrap" style="background-image: url('<c:out value='${result.wr_path}${result.wr_thumb}'/>');">
									<p class="img"><img src="<c:out value='${result.wr_path}${result.wr_thumb}'/>" alt="<c:out value='${result.wr_subject}' escapeXml='false'/>" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></p>
									<p class="label"></p>
								</div>
							</c:otherwise>
							</c:choose>
						</div>
						<div class="event-txt">
							<div class="title"><c:out value='${result.ca_name}'/></div>
							<div class="subject"><c:out value="${result.wr_subject}" escapeXml='false'/></div>
						</div>
					</a>
				</div>			
			</c:otherwise>
		</c:choose>
		</c:forEach>
	</div>
	<div class="bbs_paging"><c:out value='${pagingStr}' escapeXml="false"/></div>
	</c:when>
	<c:otherwise>
		<p class="empty"><img src="../images/noimg_content.jpg" alt="콘텐츠가 없습니다."></p>
	</c:otherwise>
</c:choose>

</div>
<!-- //bbs -->
<c:if test="${boardVO.dm_footer_content ne null && boardVO.dm_footer_content ne ''}">
	<c:out value="${boardVO.dm_footer_content}" escapeXml="false"/>
</c:if>
