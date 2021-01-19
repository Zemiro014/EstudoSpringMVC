package kr.co.dao;

import java.util.List;

import java.util.Map;

import kr.co.vo.Board;
import kr.co.vo.SearchCriteria;

public interface BoardDAO
{
	//
	public void write(Board board) throws Exception;
	
	public List<Board> list(SearchCriteria scri) throws Exception;
	
	public int listCount(SearchCriteria scri) throws Exception;
	
	public Board read(int idx) throws Exception;
	
	public void update(Board board) throws Exception;
	
	public void delete(int idx) throws Exception;
	
	public void insertFile(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> selectFile(int idx) throws Exception;
	
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	
	public void updateFile(Map<String, Object> map) throws Exception;
	
	public void boardHit(int idx) throws Exception;
}
