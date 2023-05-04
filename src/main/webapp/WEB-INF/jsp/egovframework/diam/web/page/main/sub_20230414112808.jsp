<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="area-custom-select">
	<div class="custom-select" tabindex="0">
		<span class="custom-select-text"><strong>Vol.02</strong>2023.05</span>
		<img src="${layout_path}/images/pages/select_arrow.png" class="custom-select-arrow">
	</div>
	<ul class="custom-select-list" style="display:none;">
		<li value="selectOption1" class="custom-select-option"><strong>Vol.02</strong>2023.05</li>
		<li value="selectOption2" class="custom-select-option"><strong>Vol.01</strong>2023.04</li>
	</ul>
</div>
<!-- //.area-custom-select -->

<div class="bbs_gallist">
	<ul class="gall row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
		<li class="cell col">
			<a href="#;">
				<div class="cell_thumb">
					<div class="thumb-wrap" style="background-image: url('${layout_path}/images/pages/sample_thumb04.jpg');">
						<img src="${layout_path}/images/pages/sample_thumb04.jpg" alt="" onerror="this.src='/images/no_image.png'">
					</div>
					<span class="vol">Vol.1</span>
				</div>
				<div class="cell_txt">
					<div class="cell_cate">Report</div>
					<div class="cell_subject">승촌보캠핑장 '청량한 음악 한 모금' 콘서트에 초대합니다.</div>
					<div class="cell_content">오는 5월 13일 토요일 저녁 6시부터 약 1시간 가량 공연이 있을 예정입니다. 승촌공원과 캠핑장 일대를 찾는 모든 분들에게 개방된 무료 음악행사이오니 많은 관심 부탁드립니다. 자세한 글은 블로그를 참조해주세요! https://blog.naver.com/ecogj/223091324193</div>
				</div>
			</a>
		</li>
		<li class="cell col">
			<a href="#;">
				<div class="cell_thumb">
					<div class="thumb-wrap" style="background-image: url('${layout_path}/images/pages/sample_thumb03.jpg');">
						<img src="${layout_path}/images/pages/sample_thumb03.jpg" alt="" onerror="this.src='/images/no_image.png'">
					</div>
					<span class="vol">Vol.1</span>
				</div>
				<div class="cell_txt">
					<div class="cell_cate">News</div>
					<div class="cell_subject">제15회 기후변화주간, #오늘도나는지구를구했다.</div>
					<div class="cell_content">제53주년 지구의 날을 기념하여 탄소중립 인식제고 및 생활실천 확산을 위해 '제15회 기후변화주간'을 운영합니다. #오늘도 나는 지구를 구했다. 전국 소등행사에 많은 참여 바랍니다. 일시: 2023.4.22.(토) 20:00 ~ 20:10, 10분간</div>
				</div>
			</a>
		</li>
		<li class="cell col">
			<a href="#;">
				<div class="cell_thumb">
					<div class="thumb-wrap" style="background-image: url('${layout_path}/images/pages/sample_thumb02.jpg');">
						<img src="${layout_path}/images/pages/sample_thumb02.jpg" alt="" onerror="this.src='/images/no_image.png'">
					</div>
					<span class="vol">Vol.1</span>
				</div>
				<div class="cell_txt">
					<div class="cell_cate">People</div>
					<div class="cell_subject">재난상황 조직체계 및 프로세스</div>
					<div class="cell_content">광주환경공단 재난관리 조직체계 및 재난상황 프로세스</div>
				</div>
			</a>
		</li>
		<li class="cell col">
			<a href="#;">
				<div class="cell_thumb">
					<div class="thumb-wrap" style="background-image: url('${layout_path}/images/pages/sample_thumb01.jpg');">
						<img src="${layout_path}/images/pages/sample_thumb01.jpg" alt="" onerror="this.src='/images/no_image.png'">
					</div>
					<span class="vol">Vol.1</span>
				</div>
				<div class="cell_txt">
					<div class="cell_cate">Special</div>
					<div class="cell_subject">광주환경공단 2021년 공공데이터 신규 개방 알림</div>
					<div class="cell_content">광주환경공단은 「공공데이터의 제공 및 이용 활성화에 관한 법률」에 따라 수요자 중심 활용도가 높은 공공데이터 개방을 위해 신규 데이터를 발굴·개방합니다. 올해 신규 개방 공공데이터뿐 아니라, 매년 주기에 따라 다양한 분야의 공공데이터를 개방·관리하고 있으니, 많은 관심 바랍니다.</div>
				</div>
			</a>
		</li>
	</ul>
</div>

<script>
let selectFlag;
$('.custom-select').on('click', function() {
	$(this).toggleClass('selected');
	if($(this).hasClass('selected')) {
		$('.custom-select-list').slideDown();
	} else {
		$('.custom-select-list').slideUp();
	}
})

$('.custom-select').on('focusin', function() {
	$('.custom-select-list').slideDown();
});

$('.custom-select').on('focusout', function() {
	if(!selectFlag) {
		$('.custom-select-list').slideUp();
	}
	$(this).removeClass('selected');
});

$('.custom-select-option').on('mouseenter', function() {
	selectFlag = true;
});

$('.custom-select-option').on('mouseout', function() {
	selectFlag = false;
});

$('.custom-select-option').on('click', function() {
	let value = $(this).attr('value');

	$('.custom-select-text').html($(this).html());
	$('.custom-select-list').slideUp();
});
</script>