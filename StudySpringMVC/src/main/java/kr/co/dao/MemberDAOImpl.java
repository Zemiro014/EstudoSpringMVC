package kr.co.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO
{
	@Inject
	SqlSession sql;

	@Override
	public void register(MemberVO mVO) throws Exception 
	{
		sql.insert("memberMapper.register",mVO);
	}

	@Override
	public MemberVO login(MemberVO mVO) throws Exception
	{
		// TODO Auto-generated method stub
		System.out.println("MemberDAOImpl UserId::" + mVO.getUserId());
		System.out.println("MemberDAOImpl UserPass::" + mVO.getUserPass());
		return sql.selectOne("memberMapper.login",mVO);
	}

	@Override
	public void memberUpdate(MemberVO mVO) throws Exception 
	{
		sql.update("memberMapper.memberUpdate",mVO);		
	}

	@Override
	public void memberDelete(MemberVO mVO) throws Exception
	{
		// Send the values contained in MemberVO.
		// Then, if you look at memberMapper.memberDelete in xml,
		// Parameter values will match #{userId} and #{userPass}.
		
		sql.delete("memberMapper.memberDelete", mVO);
	}

	@Override
	public int passChk(MemberVO mVO) throws Exception 
	{
		// O DAO recebe parâmetros enviados do serviço.
		int result = sql.selectOne("memberMapper.passChk", mVO);
		return result;
	}

	@Override
	public int idChk(MemberVO mVO) throws Exception {
		// O DAO recebe parâmetros enviados do serviço.
		int result = sql.selectOne("memberMapper.idChk", mVO);
		return result;
	}
	
}
