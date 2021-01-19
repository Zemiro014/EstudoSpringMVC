package kr.co.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.Map;

import kr.co.vo.Board;
import kr.co.vo.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO
{
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void write(Board board) throws Exception
	{
		sqlSession.insert("boardMapper.insert",board);		
	}

	@Override
	public List<Board> list(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("boardMapper.listPage", scri);
	}
	@Override
	public int listCount(SearchCriteria scri) throws Exception
	{
		return sqlSession.selectOne("boardMapper.listCount", scri);
	}
	@Override
	public Board read(int idx) throws Exception {
		return sqlSession.selectOne("boardMapper.read", idx);		
	}

	@Override
	public void update(Board board) throws Exception {
		sqlSession.update("boardMapper.update", board);	
	}

	@Override
	public void delete(int idx) throws Exception {
		sqlSession.delete("boardMapper.delete",idx);		
	}

	// It receives and sends a Map type parameter. Map will have FILE_ID.
	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		sqlSession.insert("boardMapper.insertFile", map);
	}

	@Override
	public List<Map<String, Object>> selectFile(int idx) throws Exception 
	{
		return sqlSession.selectList("boardMapper.selectFileList",idx);
	}

	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception
	{
		return sqlSession.selectOne("boardMapper.selectFileInfo", map);
	}

	@Override
	public void updateFile(Map<String, Object> map) throws Exception
	{
		sqlSession.update("boardMapper.updateFile", map);		
	}

	@Override
	public void boardHit(int idx) throws Exception 
	{
		sqlSession.update("boardMapper.boardHit", idx);
	}
}
