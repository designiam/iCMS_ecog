package egovframework.diam.biz.model.main;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Dm_subscribe_vo {
	
	private String dm_id;
	private String dm_email;
	private String dm_name;
	private String dm_status;
	private String dm_create_dt;
	
	private int page;
	private int rows;
	
	private String status_text;
	private String search_type;
	private String search_value;	

}
