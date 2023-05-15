package egovframework.diam.cmm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Dm_crawl_vo {
	private String dm_id;
	private String dm_type;
	private String dm_href;
	private String dm_src;
	private String dm_create_dt;
}
