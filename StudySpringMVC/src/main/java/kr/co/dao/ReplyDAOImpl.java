package kr.co.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO
{
	@Inject
	SqlSession sql;

	@Override
	public List<ReplyVO> readReply(int idx) throws Exception
	{
		// TODO Auto-generated method stub
		return sql.selectList("replyMapper.readReply",idx);
	}

	@Override
	public void writeReply(ReplyVO rVO) throws Exception
	{
		sql.insert("replyMapper.writeReply",rVO);		
	}

	@Override
	public void updateReplay(ReplyVO rVO) throws Exception 
	{
		sql.update("replyMapper.updateReply", rVO);		
	}

	@Override
	public void deleteReply(ReplyVO rVO) throws Exception 
	{
		sql.delete("replyMapper.deleteReply",rVO);		
	}

	@Override
	public ReplyVO selectReply(int id_r) throws Exception 
	{
		// TODO Auto-generated method stub
		return sql.selectOne("replyMapper.selectReply", id_r);
	}
}
