package egovframework.diam.biz.model.file;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Dm_file_vo {

	private String dm_id;
	
	private String dm_file_name;
	
	private String dm_org_name;
	
	private String dm_path;
	
	private long dm_size;
	
	private String dm_type;
	
	private String dm_ext;
	
	private String dm_etc;
	
	private String dm_create_dt;
	
	private String dm_create_id;
	
	private MultipartFile file;
	
	private int rows;
	private int page;
	private String search_start_date;
	private String search_end_date;
	private String search_type;
	private String search_value;
}
