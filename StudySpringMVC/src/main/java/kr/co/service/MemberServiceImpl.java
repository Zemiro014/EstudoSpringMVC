package kr.co.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.MemberDAO;
import kr.co.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService
{
	@Inject
	MemberDAO dao;
	
	@Override
	public void register(MemberVO mVO) throws Exception
	{
		dao.register(mVO);
	}
	
	@Override
	public MemberVO login(MemberVO mVO) throws Exception {
		// TODO Auto-generated method stub
		return dao.login(mVO);
	}
	
	@Override
	public void memberUpdate(MemberVO mVO) throws Exception {
		dao.memberUpdate(mVO);
	}

	@Override
	public void memberDelete(MemberVO mVO) throws Exception {
		dao.memberDelete(mVO);
	}

	@Override
	public int passChk(MemberVO mVO) throws Exception {
		int result = dao.passChk(mVO);
		return result;
	}

	@Override
	public int idChk(MemberVO mVO) throws Exception {
		
		// O DAO recebe parâmetros enviados do serviço.
		int result = dao.idChk(mVO);
		return result;
	}
	
}
