package egovframework.diam.biz.model.event;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Dm_event_vo {
	
	private String dm_id;
	
	private String dm_title;
	
	private String dm_content;
	
	private String dm_status;
	
	//문의처
	private String dm_inquiry;
	
	//주최
	private String dm_host;
	
	//응모대상
	private String dm_target;
	
	private String dm_event_start;
	
	private String dm_event_end;
	
	private String dm_hit;
	
	private String dm_file_name;
	
	private String dm_file_path;
	
	//발표일
	private String dm_announce;
	
	private String dm_twitter;
	
	private String dm_instagram;
	
	private String dm_naver;
	
	private String dm_facebook;
	
	private String dm_youtube;
	
	private String dm_kakao;
	
	private String dm_etc;
	
	private String dm_create_dt;
	private String dm_create_id;
	private String dm_modify_dt;
	private String dm_modify_id;
	private String dm_delete_dt;
	private String dm_delete_id;
	
	private int rows;
	private int page;
}
