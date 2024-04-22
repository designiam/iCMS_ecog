<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:choose>
	<c:when test="${fn:contains(CONFIG_INFO.dm_url, '/') }">
		<c:set value="/${fn:split(CONFIG_INFO.dm_url, '/')[1]}" var="root"/>	
	</c:when>
	<c:otherwise>
		<c:set value="" var="root"/>
	</c:otherwise>
</c:choose>

<div class="unified-search-result">
	<!-- 검색결과// -->
	<div class="search-result">
		<div class="search_box">
		    <div class="inner">
		    	<form method="post" action="">
			        <div class="searchG">
			            <input type="text" placeholder="검색어를 입력해주세요." id="sch_stx" class="input_style">
			            <input type="image" src="${layout_path}/images/common/ico_search.png" id="sch_submit" class="sch_btn" data-domain="<c:out value='${CONFIG_INFO.dm_domain_id}'/>">
			        </div>
			        <div class="recommendG">
						<h3 class="tit">자주 찾는 검색어</h3>
			            <div class="cont">
			                <a href="#">분리배출</a>
			                <a href="#">민원</a>
			                <a href="#">행사</a>
			                <a href="#">뉴스</a>
			                <a href="#">제로웨이스트</a>
			                <a href="#">리포트</a>
			            </div>
			        </div>
		        </form>
		        <p class="result_txt"><strong><c:out value="${search_value }"/></strong>검색결과</p>
		    </div>
		</div>
		<!--//search_box-->
	</div>
	<!-- //검색결과 -->

	<div class="search-result-body">
		<!-- 카테고리별 검색결과 건수// -->
		<div class="total_result">
			<div class="inner">
				<ul>
					<li>전체 콘텐츠 <span>678</span></li>
					<li>People <span>123</span></li>
					<li>Article <span>56</span></li>
					<li>함께G <span>71</span></li>
					<li>Event <span>32</span></li>
				</ul>
			</div>					
		</div>
		<!-- //카테고리별 검색결과 건수 -->
		
		<c:forEach items="${writeList }" var="data">
			<c:if test="${data.total > 0 }">
			<div class="search-result-wrap">
			
			
				<!-- title_more// -->
				<div class="title_more">
					<p class="title"><c:out value="${data.dm_subject }"/> <span><c:out value="${data.total }"/></span></p>
					<p class="btn_more"><a href="#">더보기</a></p>
				</div>
				<!-- //title_more -->
				<!-- .bbs_gallist// -->
				<div class="bbs_gallist">
					<ul class="gall row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
						<li class="cell col">
							<a href="#">
								<div class="img">
									<div class="thumb-wrap">
										<img src="/img_test.jpg" alt="우~우~ 풍문으로 들었소, 광주환경공단 업무가 아니라는 사실을!" />
									</div>
								</div>
								<!-- //.cell_thumb -->
								<div class="con_txt">
									<p class="tit t02">우~우~ 풍문으로 들었소, 광주환경공단 업무가 아니라는 사실을!</p>
									<div class="bot">
										<p class="vol">vol. 71</p>
										<p class="tag_con"><span class="tag">#민원정보</span><span class="tag">#업무정보</span><span class="tag">#사업분야</span></p>
									</div>
								</div>
							</a>
						</li>
						<li class="cell col">
							<a href="#">
								<div class="img">
									<div class="thumb-wrap">
										<img src="/img_test.jpg" alt="우~우~ 풍문으로 들었소, 광주환경공단 업무가 아니라는 사실을!" />
									</div>
								</div>
								<!-- //.cell_thumb -->
								<div class="con_txt">
									<p class="tit t02">우~우~ 풍문으로 들었소, 광주환경공단 업무가 아니라는 사실을!</p>
									<div class="bot">
										<p class="vol">vol. 71</p>
										<p class="tag_con"><span class="tag">#민원정보</span><span class="tag">#업무정보</span><span class="tag">#사업분야</span></p>
									</div>
								</div>
							</a>
						</li>
						<li class="cell col">
							<a href="#">
								<div class="img">
									<div class="thumb-wrap">
										<img src="/img_test.jpg" alt="우~우~ 풍문으로 들었소, 광주환경공단 업무가 아니라는 사실을!" />
									</div>
								</div>
								<!-- //.cell_thumb -->
								<div class="con_txt">
									<p class="tit t02">우~우~ 풍문으로 들었소, 광주환경공단 업무가 아니라는 사실을!</p>
									<div class="bot">
										<p class="vol">vol. 71</p>
										<p class="tag_con"><span class="tag">#민원정보</span><span class="tag">#업무정보</span><span class="tag">#사업분야</span></p>
									</div>
								</div>
							</a>
						</li>
					</ul>
				</div>
				<!-- //.bbs_gallist -->
				
				
				
				<table class="table">
					<caption><c:out value="${data.dm_subject }"/> 검색 결과 테이블</caption>
					<thead>
						<tr>
							<!-- <th>구분</th> -->
							<th class="td_subject">제목</th>
							<th>작성자</th>
							<th>내용</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${data.write }" var="item">
							<c:choose>
								<c:when test="${item.wr_is_comment eq 1 }">
									<c:set var="comment" value="댓글"/>
								</c:when>
								<c:otherwise>
									<c:set var="comment" value="게시글"/>
								</c:otherwise>
							</c:choose>
							<tr>
								<%-- <td class="td_type">${comment}</td> --%>
								<td class="td_subject"><a href="<c:out value='${root }'/>/index.do?command=view&contentId=<c:out value='${data.dm_uid }'/>&wr_id=<c:out value='${item.wr_id}'/>"><c:out value="${item.wr_subject }"/></a></td>
								<td class="td_content"><c:out value="${item.wr_content }"/></td>
								<td class="td_name">
									<c:choose>
										<c:when test='${data.dm_writer_type eq "name"}'>
											 <c:choose>
												<c:when test="${data.dm_writer_secret eq '2' }">
													<c:out value="${fn:substring(item.wr_name, 0, fn:length(item.wr_name) - 1)}"/>*
												</c:when>
												<c:when test="${data.dm_writer_secret eq '3' }">
													<c:out value="${fn:substring(item.wr_name, 0, 1)}"/><c:forEach begin="0" end="${fn:length(item.wr_name) - 2}">*</c:forEach>
												</c:when>
												<c:when test="${data.dm_writer_secret eq '4' }">
													<c:out value="${fn:substring(item.wr_name, 0 , fn:length(item.wr_name) - 2)}"/>**
												</c:when>
												<c:otherwise>
													<c:out value="${item.wr_name}"/>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${data.dm_writer_secret eq '2' }">
													<c:out value="${fn:substring(item.mb_id, 0, fn:length(item.mb_id) - 1)}"/>*
												</c:when>
												<c:when test="${data.dm_writer_secret eq '3' }">
													<c:out value="${fn:substring(item.mb_id, 0, 1)}"/><c:forEach begin="0" end="${fn:length(item.mb_id) - 2}">*</c:forEach>
												</c:when>
												<c:when test="${data.dm_writer_secret eq '4' }">
													<c:out value="${fn:substring(item.mb_id, 0 , fn:length(item.mb_id) - 2)}"/>**
												</c:when>
												<c:otherwise>
													<c:out value="${item.mb_id}"/>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</td>
								<td class="td_date"><c:out value="${item.wr_datetime }"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			</c:if>
		</c:forEach>
	</div>
</div>