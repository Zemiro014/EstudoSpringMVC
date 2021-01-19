package kr.co.dao;

import kr.co.vo.MemberVO;

public interface MemberDAO
{
	public void register(MemberVO mVO) throws Exception;
	
	public MemberVO login(MemberVO mVO) throws Exception;
	
	public void memberUpdate(MemberVO mVO) throws Exception;
	
	public void memberDelete(MemberVO mVO) throws Exception;
	
	public int passChk(MemberVO mVO) throws Exception;
	
	public int idChk(MemberVO mVO) throws Exception;
}
