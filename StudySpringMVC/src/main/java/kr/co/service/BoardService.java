package kr.co.service;

import kr.co.vo.Board;
import kr.co.vo.SearchCriteria;

import java.util.List;
public interface BoardService 
{
	public void write(Board board) throws Exception;
	
	public List<Board> list(SearchCriteria cri) throws Exception;
	
	public int listCount(SearchCriteria cri) throws Exception;
	
	public Board read(int idx) throws Exception;
	
	public void update(Board board) throws Exception;
	
	public void delete(int idx) throws Exception;
}
