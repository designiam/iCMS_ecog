package egovframework.diam.cmm.model;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Dm_search_vo implements Serializable {

	/** VO 직렬화 시 version uid 값 */
	private static final long serialVersionUID = 2061181777668650192L;

	/** PK */
	@Pattern(regexp="^[0-9]*$", message="올바르지 않은 요청값입니다.")
	private String dm_id;
	
	/** 도메인 */
	private String dm_domain;

	/** 도메인명 */
	private String dm_domain_text;

	/** 검색어 */
	@NotBlank(message="검색어를 입력해주세요.")
	@Pattern(regexp="^[a-zA-Z0-9가-힣ㄱ-ㅎ\\s]*$", message="검색어는 한글, 영문, 숫자로만 입력해주세요.")
	@Size(min=1, max=20, message="검색어는 1자 이상 20자 이하로 입력해주세요.")
	private String dm_word;
	
	/** 검색 횟수 */
	private int dm_count;
	
	private int dm_sort;
	
	/** 등록일자 */
	private String dm_create_dt;
	
	/** 수정일자 */
	private String dm_modify_dt;

	private String search_domain;
	
	/** 검색어 리스트 검색시작일 */
	private String search_start_date;
	
	/** 검색어 리스트 검색종료일 */
	private String search_end_date;
	
	/** 검색어 리스트 검색조건 */
	private String search_type;
	
	/** 검색어 리스트 검색단어 */
	private String search_value;

	/** 검색어 리스트 페이지당 게시물 수 */
	private int page;
	
	/** 검색어 리스트 페이지번호 */
	private int rows;
		

	
}