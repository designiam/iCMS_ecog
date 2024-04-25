package egovframework.diam.biz.model.main;

import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Dm_cover_vo {

	private String dm_id;
	
	@NotBlank(message="발행 호수를 입력해주세요.")
	@Pattern(regexp="^[0-9]*$", message="발행호수는 숫자만 입력가능합니다.")
	private String dm_vol;
	
	@NotBlank(message="발행 연도를 입력해주세요.")
	@Pattern(regexp="^[0-9]*$", message="발행연도는 숫자만 입력가능합니다.")
	@Size(min=4, max=4, message="발행연도는 4자리 숫자로 입력해야합니다.")
	private String dm_year;
	
	@NotBlank(message="발행월을 입력해주세요.")
	@Pattern(regexp="^[0-9]*$", message="발행월은 숫자만 입력가능합니다.")
	@Size(min=2, max=2, message="발행월은 2자리 숫자로 입력해야합니다.")
	private String dm_month;
	
	@NotBlank(message="제목을 입력해주세요.")
	private String dm_title;
	
	private String dm_content;
	
	@Pattern(regexp="^[0-9]*$", message="상태값이 바르지 않습니다.")
	private String dm_status;
	
	private String dm_create_dt;
	private String dm_create_id;
	private String dm_modify_dt;
	private String dm_modify_id;
	private String dm_delete_dt;
	private String dm_delete_id;
	private String dm_delete_yn;
	
	private int rows;
	private int page;
	
	private String search_value;
	private String search_type;
	private String search_start_date;
	private String search_end_date;
	
	private List<String> boardList;
	
	private String dm_cover_img;
	private String dm_cover_img_ori;
	
	/** 삭제파일명 */
	private String dm_del_image;

	/** 업로드 파일 */
	private MultipartFile multiFile;

}
