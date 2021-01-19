package kr.co.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.ReplyDAO;
import kr.co.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService
{
	@Inject 
	ReplyDAO dao;

	@Override
	public List<ReplyVO> readReply(int idx) throws Exception
	{
		return dao.readReply(idx);
	}

	@Override
	public void writeReply(ReplyVO rVO) throws Exception 
	{
		dao.writeReply(rVO);		
	}

	@Override
	public void updateReplay(ReplyVO rVO) throws Exception
	{
		dao.updateReplay(rVO);		
	}

	@Override
	public void deleteReply(ReplyVO rVO) throws Exception
	{
		dao.deleteReply(rVO);		
	}

	@Override
	public ReplyVO selectReply(int id_r) throws Exception
	{		
		return dao.selectReply(id_r);
	}
}
