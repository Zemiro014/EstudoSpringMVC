package kr.co.service;

import java.util.List;

import kr.co.vo.ReplyVO;


public interface ReplyService
{
	public List<ReplyVO> readReply(int idx) throws Exception;
	
	public void writeReply(ReplyVO rVO) throws Exception;
	
	public void updateReplay(ReplyVO rVO) throws Exception;
	
	public void deleteReply(ReplyVO rVO) throws Exception;
	
	public ReplyVO selectReply(int id_r) throws Exception;
}
