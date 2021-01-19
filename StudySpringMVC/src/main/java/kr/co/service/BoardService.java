package kr.co.service;

import kr.co.vo.Board;
import kr.co.vo.SearchCriteria;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;
public interface BoardService 
{
	public void write(Board board, MultipartHttpServletRequest mpRequest) throws Exception;
	
	public List<Board> list(SearchCriteria cri) throws Exception;
	
	public int listCount(SearchCriteria cri) throws Exception;
	
	public Board read(int idx) throws Exception;
	
	public void update(Board board, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception;
	
	
	public void delete(int idx) throws Exception;
	
	public List<Map<String, Object>> selectFileList(int idx) throws Exception;
	
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
}
