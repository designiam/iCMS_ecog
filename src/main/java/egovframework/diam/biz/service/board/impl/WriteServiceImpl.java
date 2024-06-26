/**
 * Description Date(Format: 2021/11/16)
 */
package egovframework.diam.biz.service.board.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;

import egovframework.diam.biz.db.board.BoardMapper;
import egovframework.diam.biz.db.board.WriteMapper;
import egovframework.diam.biz.model.board.Dm_board_vo;
import egovframework.diam.biz.model.board.Dm_write_vo;
import egovframework.diam.biz.service.board.WriteService;
import egovframework.diam.cmm.util.CommonUtil;
import egovframework.diam.cmm.util.MessageCode;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
/**
 * @Class Name : WriteServiceImpl.java
 * @Description : 관리자/사용자페이지 게시물 페이지에서 사용하는 게시물 데이터 CRUD 메소드를 수행하는 Service
 *              Interface 구현 클래스
 * @author 디자인아이엠 개발팀 한연재
 * @since 2021.11.16
 * @version 1.0
 */

@Service("writeService")
public class WriteServiceImpl extends EgovAbstractServiceImpl implements WriteService {

	@Resource(name = "writeMapper")
	private WriteMapper mapper;

	@Resource(name = "boardMapper")
	private BoardMapper boardMapper;

	/**
	 * selectWriteList 검색 값에 따른 게시물 리스트데이터 조회
	 * 
	 * @param vo 게시물데이터 검색조건,페이징 값을 vo객체에 담아 전달
	 * @return List<Dm_write_vo> 조회된 게시물데이터를 List 자료형으로 전달
	 */
	@Override
	public List<Dm_write_vo> selectWriteList(Dm_write_vo vo) throws Exception {
		List<Dm_write_vo> writeList = mapper.selectWriteList(vo);
		return writeList;
	}

	/**
	 * selectWrite 게시물 PK값과 게시판 아이디로 1건의 게시물데이터 조회
	 * 
	 * @param vo 게시물 PK값과 게시판 아이디를 vo객체에 담아 전달
	 * @return Dm_write_vo 조회된 게시물데이터를 게시물데이터 vo객체에 담아 전달
	 */
	@Override
	public Dm_write_vo selectWrite(Dm_write_vo vo) throws Exception {
		Dm_write_vo result = mapper.selectWrite(vo);
		return result;
	}

	/**
	 * insertWrite 사용자가 입력한 게시물데이터 DB에 insert
	 * 
	 * @param vo 사용자가 입력한 게시물데이터를 vo객체에 담아 전달
	 * @return void 게시물데이터 insert 기능만 담당하는 메소드
	 */
	@Override
	@Transactional
	public int insertWrite(Dm_write_vo vo) throws Exception {
		if (vo.getWr_main() != null && vo.getWr_main().equals("Y")) {
			if (vo.getWr_vol() != null && Integer.parseInt(vo.getWr_vol()) > 0) {
				mapper.updateWriteMainOff(vo);
			}
		}

		int result = mapper.insertWrite(vo);
		if (vo.getWr_reply() < 1) {
			result += mapper.updateWrnumParent(vo);
			if (result > 1) {
				return result;
			} else {
				throw new RuntimeException(MessageCode.CMS_UPDATE_FAIL.getLog());
			}
		} else {
			mapper.updateReplyReply(vo);
			return result;
		}
	}

	/**
	 * updateWrite 게시물 PK값으로 등록되어 있는 게시물데이터 DB에 update
	 * 
	 * @param vo 사용자가 입력한 게시물데이터를 객체에 담아 전달
	 * @return void 게시물데이터 update 기능만 담당하는 메소드
	 */
	@Override
	@Transactional
	public int updateWrite(Dm_write_vo vo) throws Exception {
		if (vo.getWr_main() != null && vo.getWr_main().equals("Y")) {
			if (vo.getWr_vol() != null && Integer.parseInt(vo.getWr_vol()) > 0) {
				mapper.updateWriteMainOff(vo);
			}
		}
		int result = mapper.updateWrite(vo);
		return result;
	}

	/**
	 * deleteWrite 게시물 PK값으로 등록되어 있는 게시물데이터 삭제
	 * 
	 * @param vo 사용자가 삭제하고자 하는 게시물데이터의 PK값을 vo객체에 담아 전달
	 * @return void 게시물데이터 delete 기능만 담당하는 메소드
	 */
	@Override
	@Transactional
	public void deleteWrite(List<Dm_write_vo> list) throws Exception {

		if (list.size() > 0) {
			list.forEach(item -> {
				Dm_board_vo boardVO = Dm_board_vo.builder().dm_id(item.getWr_board()).build();
				boardVO = boardMapper.selectBoard(boardVO);
				if (boardVO != null) {
					if ("both".equals(boardVO.getDm_reply_delete_type())
							&& (item.getWr_reply() == 0 && item.getWr_is_comment() == 0)) {
						mapper.deleteWriteBoth(item);
					} else {
						mapper.deleteWrite(item);
					}
				} else {
					throw new RuntimeException();
				}

			});
		}
	}

	/**
	 * moveWrite 특정 게시물을 다른 게시판으로 이동 시 기존 게시판의 게시물을 delete, 이동할 게시판에 게시물데이터 insert한
	 * 후 변경된 PK로 부모아이디 업데이트
	 * 
	 * @param vo 사용자가 이동하고자 하는 게시물데이터를 vo객체에 담아 전달
	 * @return void 게시물데이터 이동 기능만 담당하는 메소드
	 */
	@Override
	@Transactional
	public void moveWrite(List<Dm_write_vo> list) throws Exception {
		if (list.size() > 0) {
			list.forEach(item -> {
				if (mapper.updateWriteMove(item) < 1)
					throw new RuntimeException();
			});
		}
	}

	@Override
	public int selectWriteReplyCount(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteReplyCount(vo);
	}

	/**
	 * selectWriteCommentReplyCnt 게시물 이동 시 댓글/답글이 존재하는지 조회
	 * 
	 * @param vo 등록된 게시물 데이터를 vo객체에 담아 전달
	 * @return int 조회된 댓글/답글의 개수를 정수형으로 전달
	 */
	@Override
	public int selectWriteCommentReplyCnt(Dm_write_vo vo) throws Exception {
		int result = mapper.selectWriteCommentReplyCnt(vo);
		return result;
	}

	/**
	 * selectWriteListCnt 검색 값에 따른 게시물 리스트데이터 개수 조회
	 * 
	 * @param vo 게시물데이터 검색조건값을 vo객체에 담아 전달
	 * @return int 조회된 게시물데이터의 개수를 정수형으로 전달
	 */
	@Override
	public int selectWriteListCnt(Dm_write_vo vo) throws Exception {
		int result = mapper.selectWriteListCnt(vo);
		return result;
	}

	/**
	 * selectWriteListForWeb 사용자페이지 게시물 리스트 검색,정렬 값에 따른 게시물 리스트데이터 조회
	 * 
	 * @param vo 게시물데이터 검색조건,페이징,정렬 값을 vo객체에 담아 전달
	 * @return List<Dm_write_vo> 조회된 게시물데이터를 List 자료형으로 전달
	 */
	/*
	 * @Override public List<Dm_write_vo> selectWriteListForWeb(Dm_write_vo writeVO)
	 * throws Exception { List<Dm_write_vo> result =
	 * mapper.selectWriteList(writeVO); if (result.size() > 0) { result.forEach(item
	 * -> { List<Dm_write_vo> children = mapper.selectReplyListForWeb(item); if
	 * (children.size() > 0) { children.forEach(sub -> { if
	 * (sub.getDm_delete_yn().equals("Y")) { sub.setWr_id("");
	 * sub.setWr_subject("삭제된 게시글입니다."); } }); item.setChildren(children); } }); }
	 * return result; }
	 */

	@Override
	public List<Dm_write_vo> selectWriteListForWeb(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteListForWeb(vo);
	}

	@Override
	public int selectWriteCountForWeb(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteCountForWeb(vo);
	}

	@Override
	public List<Dm_write_vo> selectWriteNoticeForWeb(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteNoticeForWeb(vo);
	}

	/**
	 * selectWriteCheckPassword 사용자페이지 게시물 리스트에서 비밀글 접근 시 사용자가 입력한 비밀번호 검증
	 * 
	 * @param vo 게시물데이터 PK, 게시판아이디, 입력한 비밀번호 값을 vo객체에 담아 전달
	 * @return Dm_write_vo 조회된 게시물데이터를 게시물데이터 vo객체에 담아 전달
	 */
	@Override
	public Dm_write_vo selectWriteCheckPassword(Dm_write_vo vo) throws Exception {
		Dm_write_vo result = mapper.selectWriteCheckPassword(vo);
		return result;
	}

	/**
	 * selectWriteAndUpdateHits 사용자가 게시물 상세보기 시 게시물데이터 조회와 조회수 업데이트를 동시에 수행
	 * 
	 * @param vo 게시물데이터 PK, 게시판아이디, 증가할 조회수를 vo객체에 담아 전달
	 * @return Dm_write_vo 조회된 게시물데이터를 게시물데이터 vo객체에 담아 전달
	 */
	@Override
	public Dm_write_vo selectWriteAndUpdateHits(Dm_write_vo vo) throws Exception {
		mapper.updateWriteHits(vo);
		Dm_write_vo result = mapper.selectWrite(vo);
		return result;
	}

	/**
	 * selectWriteOri 게시글 수정 시 답글/댓글일 경우를 대비해 답급/댓글의 원글데이터를 조회
	 * 
	 * @param vo 게시물 정렬값, 게시판아이디 값을 vo객체에 담아 전달
	 * @return Dm_write_vo 조회된 게시물데이터를 게시물데이터 vo객체에 담아 전달
	 */
	@Override
	public Dm_write_vo selectWriteOri(Dm_write_vo vo) throws Exception {
		Dm_write_vo result = mapper.selectWriteOri(vo);
		return result;
	}

	@Override
	public int insertComment(Dm_write_vo vo) throws Exception {
		return mapper.insertComment(vo);
	}

	@Override
	public int updateComment(Dm_write_vo vo) throws Exception {
		return mapper.updateComment(vo);
	}

	@Override
	public List<Dm_write_vo> selectParentComment(Dm_write_vo vo) throws Exception {
		return mapper.selectParentComment(vo);
	}

	@Override
	public List<Dm_write_vo> selectCommentChildrenAll(Dm_write_vo vo) throws Exception {
		return mapper.selectCommentChildrenAll(vo);
	}

	@Override
	@Transactional
	public void deleteComment(List<Dm_write_vo> list) throws Exception {
		if (list.size() > 0) {
			list.forEach(item -> {
				if (mapper.deleteWrite(item) < 1)
					throw new RuntimeException(MessageCode.CMS_DELETE_FAIL.getLog());
			});
		}
	}

	@Override
	public int selectMaxCommentReply(Dm_write_vo vo) throws Exception {
		return mapper.selectMaxCommentReply(vo);
	}

	@Override
	public List<Dm_write_vo> selectReplyList(Dm_write_vo vo) throws Exception {
		return mapper.selectReplyList(vo);
	}

	@Override
	public int selectMaxReplyReply(Dm_write_vo vo) throws Exception {
		return mapper.selectMaxReplyReply(vo);
	}

	@Override
	public Map<String, List<Dm_write_vo>> selectMainWriteList(List<Dm_board_vo> list) throws Exception {
		CommonUtil commonUtil = new CommonUtil();
		Map<String, List<Dm_write_vo>> resultMap = new HashMap<>();

		list.forEach(item -> {
			if (!commonUtil.isNullOrEmpty(item.getDm_id()) && !commonUtil.isNullOrEmpty(item.getDm_main_count())) {
				List<Dm_write_vo> children = new ArrayList<>();
				Dm_write_vo vo = Dm_write_vo.builder().wr_board(item.getDm_id())
						.rows(Integer.parseInt(item.getDm_main_count())).build();
				children = mapper.selectMainWriteList(vo);
				if (children.size() > 0) {
					children.forEach(sub -> {
						sub.setUid(item.getDm_uid());
						sub.setType(item.getDm_skin());
						sub.setDm_table_text(item.getDm_subject());
					});

					resultMap.put(item.getDm_table(), children);
				} else {
					children.add(Dm_write_vo.builder().dm_table_text(item.getDm_subject()).type(item.getDm_skin())
							.uid(item.getDm_uid()).build());
					resultMap.put(item.getDm_table(), children);
				}

			}
		});

		return resultMap;
	}

	@Override
	public void updateNewHitCountReset() throws Exception {
		mapper.updateNewHitCountReset();
	}

	@Override
	public Dm_write_vo selectMainByVol(Dm_write_vo vo) throws Exception {
		return mapper.selectMainByVol(vo);
	}

	@Override
	public List<Dm_write_vo> selectPopularWrite(Dm_write_vo vo) throws Exception {
		return mapper.selectPopularWrite(vo);
	}

	@Override
	public List<Dm_write_vo> selectRecommendWrite(Dm_write_vo vo) throws Exception {
		return mapper.selectRecommendWrite(vo);
	}

	@Override
	public List<Dm_write_vo> selectSameVolWrite(Dm_write_vo vo) throws Exception {
		return mapper.selectSameVolWrite(vo);
	}

	@Override
	public List<Dm_write_vo> selectMainWrite(Map<String, Object> param) throws Exception {
		return mapper.selectMainWrite(param);
	}

	@Override
	public List<Dm_write_vo> selectWriteListVol(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteListVol(vo);
	}

	@Override
	public int selectWriteListVolCount(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteListVolCount(vo);
	}

	@Override
	public List<Dm_write_vo> selectWriteListForMain(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteListForMain(vo);
	}

	@Override
	public int selectWriteListForMainCount(Dm_write_vo vo) throws Exception {
		return mapper.selectWriteListForMainCount(vo);
	}

	@Override
	public List<Dm_write_vo> selectCoverVolList(Dm_write_vo vo) throws Exception {
		return mapper.selectCoverVolList(vo);
	}
	
	@Override
	public Dm_write_vo selectWriteForEvent(Dm_write_vo vo) throws Exception{
		return mapper.selectWriteForEvent(vo);
	}

	@Override
	public Dm_write_vo selectPrevWrite(Dm_write_vo vo) throws Exception{
		return mapper.selectPrevWrite(vo);
	}

	@Override
	public Dm_write_vo selectNextWrite(Dm_write_vo vo) throws Exception{
		return mapper.selectNextWrite(vo);
	}

	/**
	 * selectWriteList
	 * 검색 값에 따른 게시물 리스트데이터 조회
	 * @param vo 게시물데이터 검색조건,페이징 값을 vo객체에 담아 전달
	 * @return List<Dm_write_vo> 조회된 게시물데이터를 List 자료형으로 전달
	*/
	@Override
	public List<Dm_write_vo> selectDeleteList(Dm_write_vo vo) throws Exception {
		List<Dm_write_vo> writeList = mapper.selectDeleteList(vo);
		return writeList;
	}
	
	/**
	 * selectDeleteListCnt
	 * 검색 값에 따른 게시물 리스트데이터 개수 조회
	 * @param vo 게시물데이터 검색조건값을 vo객체에 담아 전달
	 * @return int 조회된 게시물데이터의 개수를 정수형으로 전달
	*/
	@Override
	public int selectDeleteListCnt(Dm_write_vo vo) throws Exception {
		int result = mapper.selectDeleteListCnt(vo);
		return result;
	}
	
	/**
	 * deleteWrite
	 * 게시물 PK값으로 등록되어 있는 게시물데이터 삭제
	 * @param vo 사용자가 삭제하고자 하는 게시물데이터의 PK값을 vo객체에 담아 전달
	 * @return void 게시물데이터 delete 기능만 담당하는 메소드
	*/
	@Override
	@Transactional
	public void removeWrite(List<Dm_write_vo> list) throws Exception {
		
		if (list.size() > 0) {
			list.forEach(item -> {
				Dm_board_vo boardVO = Dm_board_vo.builder().dm_id(item.getWr_board()).build();
				boardVO = boardMapper.selectBoard(boardVO);
				
				if (boardVO != null) {
					//첨부파일 삭제
					List<String> file_list = new ArrayList<String>(Arrays.asList(item.getWr_file().split("\\|")));
					String[] extlist = {"jpg","gif","png","JPG","GIF","PNG","jpeg","JPEG"};
					
					if (file_list.size() > 0) {
						for (int i=0 ; i < file_list.size() ; i++) {
							File file = new File(getRealPath() + file_list.get(i));
							
							if(file.exists()) {
								file.delete();
								System.out.print("원본파일삭제");
							}
							//썸네일삭제
							String ext = file_list.get(i).substring(file_list.get(i).indexOf(".") + 1);
							boolean extchk = false;
							extchk = Arrays.asList(extlist).contains(ext);

							if(extchk) {
								String thumbname = file_list.get(i).replace("/resources/board/"+boardVO.getDm_table()+"/", "/resources/board/"+boardVO.getDm_table()+"/gallery/t-");
								File thumbFile = new File(getRealPath() + thumbname);
								if(thumbFile.exists()) {
									thumbFile.delete();
									System.out.print("썸네일파일 삭제");
								}
							}
						} 					
					}
					
					if(!"".equals(item.getWr_path())) {
						if(!"".equals(item.getWr_head())) {
							File file = new File(getRealPath() + item.getWr_path() + item.getWr_head());
							if(file.exists()) {
								file.delete();
								System.out.print("head 파일 삭제");
							}
						}
						
						if(!"".equals(item.getWr_banner())) {
							File file = new File(getRealPath() + item.getWr_path() + item.getWr_banner());
							if(file.exists()) {
								file.delete();
								System.out.print("banner 파일 삭제");
							}
						}
						if(!"".equals(item.getWr_thumb())) {
							File file = new File(getRealPath() + item.getWr_path() + item.getWr_thumb());
							if(file.exists()) {
								file.delete();
								System.out.print("thumb 파일 삭제");
							}
						}
						if(!"".equals(item.getWr_background())) {
							File file = new File(getRealPath() + item.getWr_path() + item.getWr_background());
							if(file.exists()) {
								file.delete();
								System.out.print("background 파일 삭제");
							}
						}
						if(!"".equals(item.getWr_thumb_sub())) {
							File file = new File(getRealPath() + item.getWr_path() + item.getWr_thumb_sub());
							if(file.exists()) {
								file.delete();
								System.out.print("thumb_sub 파일 삭제");
							}
						}
					}
					
					if ("both".equals(boardVO.getDm_reply_delete_type()) && (item.getWr_reply() == 0 && item.getWr_is_comment() == 0)) {
						//게시글 데이터 삭제
						mapper.removeWriteBoth(item);
					} else {
						mapper.removeWrite(item);
					}
				} else {
					throw new RuntimeException();
				}
				
			});
		}
	}

	/**
	 * restoreWrite
	 * 게시물 PK값으로 등록되어 있는 게시물데이터 복구
	 * @param vo 사용자가 복구하고자 하는 게시물데이터의 PK값을 vo객체에 담아 전달
	 * @return void 게시물데이터 복구 기능만 담당하는 메소드
	*/
	@Override
	@Transactional
	public void restoreWrite(List<Dm_write_vo> list) throws Exception {
		
		if (list.size() > 0) {
			list.forEach(item -> {
				Dm_board_vo boardVO = Dm_board_vo.builder().dm_id(item.getWr_board()).build();
				boardVO = boardMapper.selectBoard(boardVO);
				if (boardVO != null) {
					if ("both".equals(boardVO.getDm_reply_delete_type()) && (item.getWr_reply() == 0 && item.getWr_is_comment() == 0)) {
						//게시글 데이터 복원
						mapper.restoreWriteBoth(item);
					} else {
						mapper.restoreWrite(item);
					}
				} else {
					throw new RuntimeException();
				}
				
			});
		}
	}
	
	@SuppressWarnings("deprecation")
	public static String getRealPath() {
		//StringBuffer sb = new StringBuffer();
		ServletRequestAttributes sra = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();

		return sra.getRequest().getRealPath("");
	}

}