package kr.co.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.MemberService;
import kr.co.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController
{
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	MemberService service;
	
	// Adicione BCryptPasswordEncoder para habilitar a função de criptografia.
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public void getRegister() throws Exception
	{
		logger.info("get register or Showing the member registration form to the user");
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String posRegister(MemberVO mVO) throws Exception
	{
		logger.info("post register or Passing data from the member registration form to the database");
		
		// Search the database for how many UserId looks like the UserId the user typed in the form
		// if return 0, it´s means that no exists in DataBase the UserId like this ones
		int result = service.idChk(mVO); 
		try 
		{
			// Deste ponto, verifique se o ID inserido existe. Se existir, voltar para a página de registro de membro
			// se não existir, o novo membro será registrado
			if(result == 1)
			{
				return "/member/register";
			}
			else if (result == 0) 
			{
				// "inputPassWord" receives the password entered by the user
				String inputPassWord = mVO.getUserPass(); 
				
				// The password entered is "encrypted" and then stored in the "pwd" variable
				String pwd = pwdEncoder.encode(inputPassWord); 
				
				// Reset the value of the variable "userPass" of the object "mVO" to the encrypted value
				mVO.setUserPass(pwd);
				
				// After the variable "userPass" of the mVO object receives the encrypted value, then it is inserted in the database
				service.register(mVO); 
			}
		}
		catch(Exception e) 
		{
			throw new RuntimeException();
		}		
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String login(MemberVO mVO, HttpSession session, RedirectAttributes rttr) throws Exception
	{
		logger.info("post login or Login Process");
		
		session.getAttribute("member");
		System.out.println("11111111111111111111111");
		MemberVO login = service.login(mVO);
		
		System.out.println("UserName ==> " + login.getUserName());
		System.out.println("UserPass ==> " + login.getUserPass());
		
		
		//comparison pwdEncoder.matches (password entered (), password encrypted ()).
		// comparação pwdEncoder.matches (senha inserida (), senha criptografada ()).
		boolean pwdMatch = pwdEncoder.matches(mVO.getUserPass(), login.getUserPass());
		
		System.out.println("pwdMatch :: ##> " + pwdMatch);
		
		if(login !=null && pwdMatch == true) 
		{
			System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			session.setAttribute("member", login);
		}
		else 
		{
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		}
		
		System.out.println("#######################");
		return "redirect:/";
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception
	{
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/memberUpdateView",method=RequestMethod.GET)
	public String registerUpdateView() throws Exception
	{
		logger.info("Showing the user the form to update the user's login information");
		return "member/memberUpdateView";
	}
	
	@RequestMapping(value="/memberUpdate",method=RequestMethod.POST)
	public String registerUpdate(MemberVO mVO, HttpSession session)throws Exception
	{
		/*
		 * MemberVO login = service.login(mVO);
		
		boolean pwdMatch = pwdEncoder.matches(mVO.getUserPass(), login.getUserPass());
		if(pwdMatch) {
			service.memberUpdate(mVO);
			session.invalidate();
		}else {
			return "member/memberUpdateView";
		}*/
		
		service.memberUpdate(mVO);
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/memberDeleteView", method=RequestMethod.GET)
	public String memberDelete() throws Exception
	{
		logger.info("Showing the user the form to disconnect a user from the system");
		return "member/memberDeleteView";
	}
	
	@RequestMapping(value="/memberDelete", method = RequestMethod.POST)
	public String memberDelete(MemberVO mVO, HttpSession session, RedirectAttributes rttr) throws Exception
	{
		/*
		MemberVO member = (MemberVO) session.getAttribute("member");
		String sessionPassWord = member.getUserPass();
		
		String mVO_PassWord = mVO.getUserPass(); 
		
		if(!(sessionPassWord.equals(mVO_PassWord))) 
		{
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/memberDeleteView";
		}
		*/
		
		service.memberDelete(mVO);
		session.invalidate();
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="/passChk", method=RequestMethod.POST)
	public boolean passChk(MemberVO mVO) throws Exception
	{
		MemberVO  login = service.login(mVO);
		boolean pwdChk = pwdEncoder.matches(mVO.getUserPass(), login.getUserPass());
		// int result = service.passChk(mVO);
		return pwdChk;
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO mVO) throws Exception
	{
		/*
		 * Quando a solicitação "idChk" chega ao MemberController, 
		 * o parâmetro é enviado ao MemberService e o resultado da pesquisa é colocado no resultado.
		 * */
		int result = service.idChk(mVO);
		return result;
	}
}
