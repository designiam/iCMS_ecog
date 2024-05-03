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
		    	<form method="post" onsubmit="return unifiedSearch(this.search_value.value, <c:out value='${CONFIG_INFO.dm_domain_id}'/>);">
			        <div class="searchG">
			            <input type="text" name="search_value" placeholder="검색어를 입력해주세요." id="sch_stx" class="input_style">
			            <input type="image" src="${layout_path}/images/common/ico_search.png" class="sch_btn" data-domain="<c:out value='${CONFIG_INFO.dm_domain_id}'/>">
			        </div>
			        <div class="recommendG">
						<h3 class="tit">자주 찾는 검색어</h3>
			            <div class="cont">
			            <c:forEach items="${searchPopList }" var="data">
			                <a href="javascript:;" onclick="unifiedSearch('<c:out value="${data.dm_word }"/>',<c:out value="${CONFIG_INFO.dm_domain_id}"/>)"><c:out value='${data.dm_word }'/></a>
			            </c:forEach>
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
					<c:out value="${total_result }"  escapeXml="false"/>
				</ul>
			</div>					
		</div>
		<!-- //카테고리별 검색결과 건수 -->
		<c:forEach items="${writeList }" var="data">
			<c:if test="${data.total > 0 }">
			<div class="search-result-wrap">
			
				<!-- title// -->
				<p class="title"><c:out value="${data.dm_subject }"/> <span><c:out value="${data.total }"/></span></p>
				<!-- //title -->
				<!-- .bbs_gallist// -->
				<div class="bbs_gallist">
					<ul id="<c:out value="data_${data.dm_table }"/>" class="gall row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
					<c:forEach items="${data.write }" var="item" varStatus="loop">
						<li class="cell col"<c:if test="${loop.index > 2 }"> style="display:none"</c:if>>
							<a href="<c:out value='${root }'/>/index.do?command=view&contentId=<c:out value='${data.dm_uid }'/>&wr_id=<c:out value='${item.wr_id}'/>">
								<div class="img">
								<c:choose>
									<c:when test="${!empty item.wr_thumb_sub}">
									<div class="thumb-wrap" style="width: 100%; background-image: url('<c:out value="${item.wr_path }"/><c:out value="${item.wr_thumb_sub }" escapeXml="false"/>');">
										<img src="<c:out value="${item.wr_path }"/><c:out value="${item.wr_thumb_sub }"/>" alt="<c:out value="${item.wr_subject }" escapeXml="false"/>" />
									</div>
									</c:when>
									<c:otherwise>
									<div class="thumb-wrap noimg" style="width: 100%; background-image: url('${layout_path}/images/pages/no_image.png');">
										<img src="${layout_path}/images/pages/no_image.png" alt="no image">
									</div>
									</c:otherwise>
								</c:choose>
								</div>
								<!-- //.cell_thumb -->
								<div class="con_txt">
									<p class="tit t02"><c:out value="${item.wr_subject }" escapeXml="false"/></p>
									<div class="bot">
										<c:if test="${!empty item.wr_vol}"><p class="vol">vol. <c:out value="${item.wr_vol }"/></p></c:if>
										<c:if test="${!empty item.wr_hashtag}"><p class="tag_con"><span class="tag">#민원정보</span><span class="tag">#업무정보</span><span class="tag">#사업분야</span></p></c:if>
									</div>
								</div>
							</a>
						</li>
					</c:forEach>	
					</ul>
				</div>
				<!-- //.bbs_gallist -->
				<!-- .btn_more : s -->
				<c:if test="${data.total > 3 }"><p class="btn_more" id="btn_more<c:out value='${data.dm_table }'/>"><a href="javascript:;" onclick="data_more('<c:out value="${data.dm_table }"/>',<c:out value="${data.total }"/>);">더보기</a></p></c:if>
				<!-- .btn_more : e -->
			</div>
			</c:if>
		</c:forEach>
	</div>
</div>
<script>
function data_more(board, total) {
	var cnt = 0;
	var visible_cnt = 0;
	$("#data_"+board).children().each(function() {
		if($(this).is(":hidden")) {
			 if(cnt < 3) {
				$(this).css("display","");
				cnt++;
			 }
		} else {
			visible_cnt++;
		}
	});
	
	if(cnt + visible_cnt == total) {
		$("#btn_more"+board).css("display", "none");
	}
	
}
</script>