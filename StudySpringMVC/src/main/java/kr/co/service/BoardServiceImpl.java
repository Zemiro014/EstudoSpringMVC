package kr.co.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.BoardDAO;
import kr.co.vo.Board;
import kr.co.vo.Criteria;

@Service
public class BoardServiceImpl implements BoardService
{
	@Inject
	private BoardDAO dao;
	
	@Override
	public void write(Board board) throws Exception
	{
		dao.write(board);
	}

	@Override
	public List<Board> list(Criteria cri) throws Exception {
		return dao.list(cri);
	}
	
	@Override
	public int listCount() throws Exception {
		// TODO Auto-generated method stub
		return dao.listCount();
	}

	@Override
	public Board read(int idx) throws Exception {
		return dao.read(idx);
	}

	@Override
	public void update(Board board) throws Exception {
		dao.update(board);		
	}

	@Override
	public void delete(int idx) throws Exception {
		dao.delete(idx);
	}



}
